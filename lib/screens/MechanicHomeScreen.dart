import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomechanic/model/ServiceModel.dart';
import 'package:gomechanic/model/complain_history_model.dart';
import 'package:gomechanic/model/completed_task_model.dart';
import 'package:gomechanic/services/MechanicTasksService.dart';
import 'package:gomechanic/services/PackageService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:gomechanic/utils/MechanicDrawerElements.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customer_map_screen.dart';

class MechanicHomeScreen extends StatefulWidget {
  @override
  _MechanicHomeScreenState createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {

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

    serviceList = await MechanicTasksService.getCompletedTasks(userId);

  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorConstants.APP_THEME_COLOR
    ));

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('     Details' , style: headingTextStyle,)),
        backgroundColor: ColorConstants.APP_THEME_COLOR,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      endDrawer: Drawer(
        child: MechanicDrawerElements('home')
      ),
      body: (isLoading) ? Center(child: CircularProgressIndicator()) : SafeArea(
        child: Stack(
          children: [
            Container(
              color: ColorConstants.APP_THEME_COLOR,
            ),
            ListView(
              children: [
                SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileLayout(),
                      SizedBox(height: 30,),
                      Text('Completed Tasks' , style: TextStyle(fontSize: 17),),
                      SizedBox(height: 15,),
                      ListView.builder(
                        shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: serviceList.length,
                          itemBuilder: (BuildContext ctx , int index){
                            return tileItem(serviceList[index]);
                          })
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  profileLayout()
  {
    return Container(
      padding: const EdgeInsets.only(left: 15 , top: 15 , bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person , color: Color.fromRGBO(220, 184, 152, 1),),
              SizedBox(width: 60,),
              Expanded(child: Text('${username}' , style: TextStyle(color: Colors.black , fontSize: 17),)),
              SizedBox(width: 30,),
              Expanded(child: Text('${phone}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500),))
            ],
          ),
        ],
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
              Container(
                  width: 200,
                  child: Text((model.client_mobile!=null) ? "Phone : ${model.client_mobile}" : "Phone : "  , style: TextStyle(color: Colors.black , fontSize: 13 , fontWeight: FontWeight.w500))),
              SizedBox(height: 10,),
              RichText(text:  TextSpan(
                  style: new TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),
                  children: [
                    new TextSpan(text : 'Time : ' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500)),
                    new TextSpan(text : '${model.fault_time}' , style: TextStyle(color: Colors.black54))
                  ]
              ),),
              SizedBox(height: 10,),
              Text('${model.breakdown_loc}' ,  style: TextStyle(color: Colors.black , fontSize: 13 , fontWeight: FontWeight.w500))
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


}
