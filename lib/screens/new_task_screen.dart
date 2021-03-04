import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/model/completed_task_model.dart';
import 'package:gomechanic/screens/complete_task_message.dart';
import 'package:gomechanic/screens/mechanic_map_screen.dart';
import 'package:gomechanic/services/MechanicTasksService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:gomechanic/utils/MechanicDrawerElements.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  DateTime currentBackPressTime;

  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );

  var username , emailId , phone , userId , email;
  bool isLoading = true;

  List<CompletedTaskModel> serviceList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadProfile();

  }


  loadProfile() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await json.decode( prefs.getString("user"));

    username = user["user_name"];
    phone = user["mobile"];
    userId = user["user_id"];
    email = user["emailid"];

    await getCompeletedTasks(userId);

    isLoading = false;
    setState(() {
    });

  }



  getCompeletedTasks(userId) async{

    serviceList = await MechanicTasksService.getNewTasks(userId);

  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorConstants.APP_THEME_COLOR
    ));

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('New Tasks' , style: headingTextStyle,)),
          backgroundColor: ColorConstants.APP_THEME_COLOR,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
        ),
        endDrawer: Drawer(
            child: MechanicDrawerElements('new')
        ),
        body: (isLoading) ? Center(child: CircularProgressIndicator()) : SafeArea(
          child: Stack(
            children: [
              Container(
                color: ColorConstants.APP_THEME_COLOR,
              ),
              (serviceList!=null) ? Container(
                margin: const EdgeInsets.all(20),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: serviceList.length,
                    itemBuilder: (BuildContext ctx , int index){
                      return tileItem(serviceList[index]);
                    }),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }


  Widget tileItem(CompletedTaskModel model) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 0 , right: 0 , top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((model.fault_prob!=null) ? model.fault_prob : "" , style: TextStyle(color: ColorConstants.APP_THEME_COLOR , fontWeight: FontWeight.bold , fontSize: 17),),
              SizedBox(height: 10,),
              RichText(text:  TextSpan(
                  style: new TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),
                  children: [
                    new TextSpan(text : 'Date : ' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500)),
                    new TextSpan(text : (model.fault_date!=null) ? '${model.fault_date}' : '' , style: TextStyle(color: Colors.black54))
                  ]
              ),),
              SizedBox(height: 10,),
              Container(
                  width: 200,
                  child: Text((model.client_name!=null) ? "Name : ${model.client_name}" : "Name : "  , style: TextStyle(color: Colors.black , fontSize: 13 , fontWeight: FontWeight.w500))),
              SizedBox(height: 10,),
              RichText(text:  TextSpan(
                  style: new TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),
                  children: [
                    new TextSpan(text : 'Time : ' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500)),
                    new TextSpan(text : '${model.fault_time}' , style: TextStyle(color: Colors.black54))
                  ]
              ),),
              SizedBox(height: 10,),
              Text('${model.breakdown_loc}' ,  style: TextStyle(color: Colors.black , fontSize: 13 , fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Divider(color: Colors.black, thickness: 1,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          if(model.lat!="NA" && model.lng!="NA"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MechanicMapScreen(model.lat, model.lng)),
                            );
                          }
                          else{
                            Fluttertoast.showToast(msg: "Customer position not found!");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Get Direction'),
                          margin: EdgeInsets.all(10),
                          height: 45,
                          color: Color.fromRGBO(92, 181, 179, 1),
                        ),
                      )
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                         var ress = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CompleteTaskMessageScreen(model.fault_sr , userId)),
                          );

                        if(ress == true){
                         isLoading = true;
                         setState(() {

                         });
                          await getCompeletedTasks(userId);
                          isLoading = false;
                          setState(() {
                           });
                        }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Complete Task'),
                          margin: EdgeInsets.all(10),
                          height: 45,
                          color: Color.fromRGBO(92, 181, 179, 1),
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius : BorderRadius.circular(10)
          ),
        ),

      ],
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit!");
      return Future.value(false);
    }
    return Future.value(true);
  }

}

