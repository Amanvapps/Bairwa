import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/request_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  static const String TOKEN = "9306488494";

  static Future login(phone , password) async{

    var response = await RequestHandler.POSTQUERY(ApiConstants.LOGIN, {
      'mobb': phone,
      'pass': password,
      'token' : TOKEN
    });

    if(response["status"]=="1" && response["data"]!=null)
    {
      print(response["data"][0]);
           await saveToken(jsonDecode(json.encode(response["data"][0])));

           var obj = {
             "result" : true,
             "type" : response["data"][0]["types"]
           };
      return obj;
    }
    Fluttertoast.showToast(msg: "Invalid Credentials !" ,  textColor: Colors.black,
        backgroundColor: Colors.white);
    return {
      "result" : false,
      "type" : ""
    };

  }


  static Future saveToken(var user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("user", json.encode(user));
  }



  static Future register(String username , String email , String latt , String long , String phone, String password , String state , String type) async {
    var form;
    form = {
      'user_name': username,
      'user_email': email,
      'user_mobb' : phone,
      'user_pass' : password,
      'user_loc' : state,
      'user_type' : type ,
      'latt' : latt,
      'longg' : long,
      'token' : TOKEN

    };

  var response = await RequestHandler.POSTQUERY(ApiConstants.REGISTRATION, form);
  return response["data"];
}

  static Future reset(String email) async {
    var form;
    form = {
      'email' : email,
      'token' : TOKEN
};

    var response = await RequestHandler.POSTQUERY(ApiConstants.RESET, form);
    if(response["status"] == "1")
      return true;
    else
      return false;
  }




}