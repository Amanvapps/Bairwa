import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gomechanic/screens/package_screen.dart';
import 'package:gomechanic/screens/payment_screen_package.dart';
import 'package:gomechanic/screens/service_history_screen.dart';
import 'package:gomechanic/services/PackageService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


import '../main.dart';
import 'fault_request_screen.dart';

class BuyPackageScreen extends StatefulWidget {

  var type;
  int amount;

  BuyPackageScreen(this.type , this.amount);

  @override
  _BuyPackageScreenState createState() => _BuyPackageScreenState();
}

class _BuyPackageScreenState extends State<BuyPackageScreen> {

  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );

  List<String> serviceTypeList = [] , brandList = [] , modelList = [] , yearList=[] , insExpList = [];
  String _selectedLocation , _yearLocation , _brandLocation , _insExpLocation , _modelLocation;
  TextEditingController discountController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController chasisController = TextEditingController();
  TextEditingController inscompController = TextEditingController();

  bool isLoading = true;
  var userId , pincode="NA" , username , mobb , email;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getServiceType();


  }



  getServiceType() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await json.decode( prefs.getString("user"));
    userId = user["user_id"];
    username = user["user_name"];
    mobb = user["mobile"];
    email = user["emailid"];


    List res = await PackageService.getServiceType();

    serviceTypeList.clear();
    await res.forEach((element) {
      serviceTypeList.add(element["service_type"]);
    });

    await getYears();


  }

  getBrand() async{
    List res = await PackageService.getBrand(_selectedLocation);

    brandList.clear();
    await res.forEach((element) {
      brandList.add(element["model_name"]);
    });

    _brandLocation = brandList[0];


    isLoading = false;
    setState(() {
    });


  }

  getModel() async{
    List res = await PackageService.getModel(_selectedLocation , _brandLocation);

    modelList.clear();
   if(res!=null){
     await res.forEach((element) {
       modelList.add(element["car_type"]);
     });

     _modelLocation = modelList[0];
   }


    isLoading = false;
    setState(() {
    });


  }


  getYears() async{
    List res = await PackageService.getYears();

    await res.forEach((element) {
      yearList.add(element["years"]);
    });

    await getExpYears();


  }

  getExpYears() async{

    int curentYear = int.parse(DateFormat('yyyy').format(DateTime.now()).toString());

    for(int i=curentYear ; i>=curentYear-10 ; i--){
      insExpList.add(i.toString());
    }


    isLoading = false;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.type} Package' , style: headingTextStyle,)),
        backgroundColor: ColorConstants.APP_THEME_COLOR,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: (isLoading) ? Center(child: CircularProgressIndicator(),) : Stack(
          children: [
            Container(
              color: ColorConstants.APP_THEME_COLOR,
            ),
            Container(
              padding: EdgeInsets.only(left: 40 , top: 30 , right: 40),
              child: ListView(
                children: [
                  // Text('Discount Coupon' , style: TextStyle(fontSize: 17),),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   height: 50,
                  //   child: TextField(
                  //     controller: discountController,
                  //     style: TextStyle(color: Colors.black),
                  //     decoration: InputDecoration(
                  //       hintText: 'Coupon code',
                  //       suffixIcon: Container(
                  //         height: 50,
                  //           decoration: BoxDecoration(
                  //               color: Color.fromRGBO(92, 181, 179, 1),
                  //               borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomRight: Radius.circular(20))
                  //           ),
                  //           child: Icon(Icons.done , color: Colors.white,)),
                  //       contentPadding: EdgeInsets.only(left: 10 , top: 10),
                  //       border: InputBorder.none
                  //     ),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(20)
                  //   ),
                  // ),
                  // SizedBox(height: 10,),

                  Text('Registration Number' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: TextField(
                      controller: regNoController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: 'Registration No.',
                          contentPadding: EdgeInsets.only(left: 10 , top: 10),
                          border: InputBorder.none
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),

                  SizedBox(height: 30,),

                  Text('Chasis Number' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: TextField(
                      controller: chasisController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: 'Chasis No.',
                          contentPadding: EdgeInsets.only(left: 10 , top: 10),
                          border: InputBorder.none
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),


                  SizedBox(height: 30,),

                  Text('Insurance Company' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: TextField(
                      controller: inscompController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: 'Insurance Company',
                          contentPadding: EdgeInsets.only(left: 10 , top: 10),
                          border: InputBorder.none
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),


                  SizedBox(height: 30,),

                  Text('Select Service Type' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('Select Service Type' , style: TextStyle(color: Colors.black),),
                        ),
                        value: _selectedLocation,
                        items: serviceTypeList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(value , style: TextStyle(color: Colors.black),),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            isLoading = true;
                            setState(() {

                            });
                            getBrand();
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),




                  SizedBox(height: 30,),

                  Text('Select Brand' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('Select Brand' , style: TextStyle(color: Colors.black),),
                        ),
                        value: _brandLocation,
                        items: brandList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(value , style: TextStyle(color: Colors.black),),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {

                            _brandLocation = newValue;
                           isLoading = true;
                            setState(() {});

                            getModel();
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),




                  SizedBox(height: 30,),

                  Text('Select Model' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('Select Model' , style: TextStyle(color: Colors.black),),
                        ),
                        value: _modelLocation,
                        items: modelList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(value , style: TextStyle(color: Colors.black),),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _modelLocation = newValue;
                            // priceController.text = _selectedLocation.fault_price;
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),




                  SizedBox(height: 30,),

                  Text('Select Year' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('Select Year' , style: TextStyle(color: Colors.black),),
                        ),
                        value: _yearLocation,
                        items: yearList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(value , style: TextStyle(color: Colors.black),),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _yearLocation = newValue;
                            // priceController.text = _selectedLocation.fault_price;
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),


                  SizedBox(height: 30,),

                  Text('Select Insurance Expire Year' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('Select Insurance Exp Year' , style: TextStyle(color: Colors.black),),
                        ),
                        value: _insExpLocation,
                        items: insExpList.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(value , style: TextStyle(color: Colors.black),),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _insExpLocation = newValue;
                            // priceController.text = _selectedLocation.fault_price;
                          });
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),



                  SizedBox(height: 30,),

                  GestureDetector(
                    onTap: (){
                      buyPackage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left : 20 , top: 20 , bottom: 20 ,  right: 20),
                      height: 50,
                      child: Text('Buy Now' ,style: TextStyle(fontSize: 20  , fontWeight: FontWeight.w500),),
                      decoration: BoxDecoration(
                          color : Color.fromRGBO(92, 181, 179, 1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

   buyPackage() async{

    isLoading = true;
    setState(() {
    });

    if(discountController.text==""){
      discountController.text="NA";
    }
    if(inscompController.text==""){
      inscompController.text="NA";
    }
    if(chasisController.text==""){
      chasisController.text="NA";
    }
    if(regNoController.text==""){
      regNoController.text="NA";
    }


    var query = {
      "token" : "9306488494",
      "user_sr" : userId,
      "brand_name" : _brandLocation,
      "service_type" : _selectedLocation,
      "insurance_exp" : _insExpLocation,
      "pincode" : pincode,
      "cvalue" : discountController.text,
      "pack_name" : widget.type,
      "car_model" : _modelLocation,
      "model_year" : _yearLocation,
      "regNo" : regNoController.text,
      "chassis_no": chasisController.text,
      "insurance_comp" : inscompController.text
    };



    var res = await PackageService.savePackageInfo(query);

    if(res!=null){
      isLoading  = false;
      setState(() {
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentScreenPackage("token=9306488494&uuid=" + res.toString() +"&phone="+ mobb +"&user_name="+ username +"&user_email=" + email+"&price=" + widget.amount.toString()
        )),
      );
    }





   }
}
