import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/model/complain_history_model.dart';
import 'package:gomechanic/screens/customer_map_screen.dart';
import 'package:gomechanic/screens/package_screen.dart';
import 'package:gomechanic/services/FaultService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:gomechanic/utils/CompanyDrawerElements.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'fault_request_screen.dart';

class ServiceHistoryScreen extends StatefulWidget {
  @override
  _ServiceHistoryScreenState createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  DateTime currentBackPressTime;

  List<CompliantHistoryModel> list =[];

  bool isLoading = true;
  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );



  getData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await json.decode( prefs.getString("user"));

  list = await FaultService.complaintHistory({
    "user_id" : user["user_id"],
    "token" : "9306488494"
  });

  isLoading = false;
  setState(() {
  });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Service History' , style: headingTextStyle,)),
          backgroundColor: ColorConstants.APP_THEME_COLOR,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0,
        ),
        endDrawer: Drawer(
            child: CompanyDrawerElements('history')
        ),
        body: (isLoading) ? Center(child: CircularProgressIndicator(),) : SafeArea(
          child: Stack(
            children: [
              Container(
                color: ColorConstants.APP_THEME_COLOR,
              ),
              (list!=null) ? ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext ctx , int index){
                   return tileItem(list[index]);
              }) : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget tileItem(CompliantHistoryModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 20 , right: 20 , top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.fault_type , style: TextStyle(color: ColorConstants.APP_THEME_COLOR , fontWeight: FontWeight.bold , fontSize: 17),),
              SizedBox(height: 10,),
              Row(
                children: [
                 RichText(text:  TextSpan(
                     style: new TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),
                     children: [
                       new TextSpan(text : 'Date : ' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500)),
                       new TextSpan(text : '${model.date}' , style: TextStyle(color: Colors.black54))
                     ]
                  ),),
                  Container(
                    alignment: Alignment.center,
                      width: 200,
                      child: Text("\u20B9 ${model.fault_price}"  , style: TextStyle(fontSize:20 , color: Colors.black , fontWeight: FontWeight.w500)))
                ],
              ),
              SizedBox(height: 10,),
              RichText(text:  TextSpan(
                  style: new TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),
                  children: [
                    new TextSpan(text : 'Time : ' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500)),
                    new TextSpan(text : '${model.time}' , style: TextStyle(color: Colors.black54))
                  ]
              ),),
              SizedBox(height: 10,),
              Text('${model.location}' ,  style: TextStyle(color: Colors.black , fontSize: 13 , fontWeight: FontWeight.w500))
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius : BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10))
          ),
        ),
        Container(
          child: Center(
          child: Column(
            children: [
              (model.mechanic != "NA") ?
              Text('Mechanic : ${model.mechanic}' , style: TextStyle(fontSize: 17),)
                  : Text('Mechanic Not Assigned' , style: TextStyle(fontWeight : FontWeight.normal , color : Colors.black , fontSize: 17),),
              (model.mechanic != "NA") ? GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerMapScreen(model.mechanicId)),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(15),
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.5,
                  color: ColorConstants.APP_THEME_COLOR,
                  child: Text('TRACK MECHANIC' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                ),
              ) : Container()
            ],
          )
          ),
          padding: EdgeInsets.only(top: 10 , bottom: 10),
          margin: EdgeInsets.only(left: 20 , right: 20 , bottom: 20),
          decoration: BoxDecoration(
             color: Color.fromRGBO(92, 181, 179, 1),
             borderRadius : BorderRadius.only(bottomLeft: Radius.circular(10) , bottomRight: Radius.circular(10))
          ),
        )
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
