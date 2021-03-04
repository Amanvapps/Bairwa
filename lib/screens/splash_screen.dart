import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gomechanic/main.dart';
import 'package:gomechanic/screens/MechanicHomeScreen.dart';
import 'package:gomechanic/screens/customer_home_screen.dart';
import 'package:gomechanic/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = new Timer(new Duration(seconds: 3), () {
      getRole(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Center(
            child: Container(
             height: 250,
             width: 250,
              child: Image.asset("images/logo.png")),
    ),
        ));
  }

  Future<String> getRole(BuildContext context) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = await prefs.getString("user");

    if(user == null){

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()));
    }
    else{

      var type = await json.decode(user);

      if(type["types"] == "1"){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomerHomeScreen()));
      }
      else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MechanicHomeScreen()));
      }


    }
  }


}
