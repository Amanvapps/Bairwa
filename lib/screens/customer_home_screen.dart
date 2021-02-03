import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/main.dart';
import 'package:gomechanic/model/PackageModel.dart';
import 'package:gomechanic/model/ServiceModel.dart';
import 'package:gomechanic/screens/fault_request_screen.dart';
import 'package:gomechanic/screens/package_screen.dart';
import 'package:gomechanic/screens/service_history_screen.dart';
import 'package:gomechanic/services/PackageService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:gomechanic/utils/CompanyDrawerElements.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {

  DateTime currentBackPressTime;

  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );

  var username , emailId , phone , userId , email;
  bool isLoading = true;
  List<PackageModel> packageList = [];
  List<ServiceModel> serviceList = [];


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


    await getAssignedPackage(userId, phone, email);

    await getAssignedService(userId, email);

    isLoading = false;
    setState(() {
    });

  }

  getAssignedPackage(userId, mob, email) async{

    packageList = await PackageService.getUserPackage(userId, mob, email);

  }

  getAssignedService(userId, email) async{

    serviceList = await PackageService.getUserService(userId , email);

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
          title: Center(child: Text('     Details' , style: headingTextStyle,)),
          backgroundColor: ColorConstants.APP_THEME_COLOR,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        elevation: 0,
        ),
        endDrawer: Drawer(
          child: CompanyDrawerElements('home')
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
                        Text('Recent Package' , style: TextStyle(fontSize: 17),),
                        SizedBox(height: 15,),
                        packageLayout(),
                        SizedBox(height: 15,),
                        Text('Recent Service' , style: TextStyle(fontSize: 17),),
                        SizedBox(height: 15,),
                        serviceLayout(),
                        mechanicNameLayout(),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
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
          )
        ],
      ),
    );
  }

  packageLayout(){
    return  Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15 , top: 15 , bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: (packageList != null) ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star , color: Color.fromRGBO(92, 181, 179, 1),),
              SizedBox(width: 60,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width : 140,
                      child: Text('${packageList[0].pack_name}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 16),)),
                  SizedBox(height: 30,),
                  Text('Valid From : ' + '${packageList[0].pack_date}' , style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.w500 , fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('Expire On : ' + '${packageList[0].package_expire_date}' , style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.w500 , fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('Pack Id : ${packageList[0].uuid}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),),
                  SizedBox(height: 10,),
                  Text( '(' + '${packageList[0].car_model}' + ') ${packageList[0].car_type}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 16),),
                  SizedBox(height: 30,),
                ],
              ),
              SizedBox(width: 0,),
              Expanded(child: Text('\u{20B9} ${packageList[0].pack_price}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 17),))
            ],
          ),
        ],
      ) : Text('No Active Package!' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 16),),
    );
  }

  serviceLayout(){
    return  Container(
      padding: const EdgeInsets.only(left: 15 , top: 15 , bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5) ),
        color: Colors.white,
      ),
      child: (serviceList != null) ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.done , color: Color.fromRGBO(92, 181, 179, 1),),
              SizedBox(width: 60,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width : 140,
                      child: Text('${serviceList[0].fault_prob}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w600 , fontSize: 16),)),
                  SizedBox(height: 30,),
                  Text('${serviceList[0].service_date}' , style: TextStyle(color: Colors.black54 , fontWeight: FontWeight.w500 , fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('Service Id : ${serviceList[0].payment_id}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 15),),
                  SizedBox(height: 10,),
                  Container(
                      width: 200,
                      child: Text('Location : ${serviceList[0].breakdown_loc}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 16),)),
                  SizedBox(height: 30,),
                ],
              ),
              SizedBox(width: 30,),
              Expanded(child: Text('\u{20B9} ${serviceList[0].service_amount}' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 17),))
            ],
          ),
        ],
      ): Text('No Active Service!' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.w500 , fontSize: 16),),
    );
  }

  mechanicNameLayout()
  {
    return  Container(
      padding: const EdgeInsets.only(left: 15 , top: 15 , bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5) ),
        color: Color.fromRGBO(92, 181, 179, 1),
      ),
      child: Center(
        child: Text('Mechanic : ${serviceList[0].name}' , style: TextStyle(fontSize: 17),),
      )
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
