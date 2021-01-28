import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/model/FaultModel.dart';
import 'package:gomechanic/screens/customer_home_screen.dart';
import 'package:gomechanic/screens/package_screen.dart';
import 'package:gomechanic/screens/payment_screen_request_eng.dart';
import 'package:gomechanic/screens/service_history_screen.dart';
import 'package:gomechanic/services/FaultService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:gomechanic/utils/LocationHandler.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';


import '../main.dart';

class FaultRequestScreen extends StatefulWidget {



  @override
  _FaultRequestScreenState createState() => _FaultRequestScreenState();
}

class _FaultRequestScreenState extends State<FaultRequestScreen> {

  List<FaultModel> _locations = [];
  FaultModel _selectedLocation;
  bool isLoading = true;
  String userId , username , email , mobb;

  TextEditingController priceController = TextEditingController();
  TextEditingController commentController = TextEditingController();





  @override
  void initState() {
    super.initState();

   getFaultType();



  }


  getFaultType() async{

    _locations = await FaultService.getFaultList();

    _selectedLocation = _locations[0];
    priceController.text = _locations[0].fault_price;

    await getSharedPreferences();

    isLoading = false;
    setState(() {
    });

  }


  getSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await json.decode( prefs.getString("user"));

    print(user.toString());
    username = user["user_name"];
    mobb = user["mobile"];
    userId = user["user_id"];
    email = user["emailid"];
  }

  @override
  Widget build(BuildContext context) {


    var headingTextStyle = TextStyle(
        color: Colors.white,
        fontSize: 22
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(' Fault Request' , style: headingTextStyle,)),
        backgroundColor: ColorConstants.APP_THEME_COLOR,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('images/car_img.png'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile' , style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Package' , style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PackageScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Service History' , style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text('Privacy Policy' , style: TextStyle(color: Colors.black)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout' , style: TextStyle(color: Colors.black)),
              onTap: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );

              },
            ),

          ],
        ),
      ),
      body: (isLoading) ?
          Center(
            child: CircularProgressIndicator(),
          )
          : SafeArea( child: Stack(
          children: [
            Container(
              color: ColorConstants.APP_THEME_COLOR,
            ),
            detailLayout()
          ],
        ),
      ),
    );
  }

  detailLayout(){

    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30 , right: 30 , top: 30),
          padding: EdgeInsets.only(top : 20),
          height: MediaQuery.of(context).size.height/1.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fill Auto Details' , style: TextStyle(color: ColorConstants.APP_THEME_COLOR , fontSize: 22),),
              SizedBox(height: 30,),
              dropDown(),
              priceLayout(),
              commentLayout(),
              requestButton()
            ],
          ),
        ),
      ],
    );

  }

  dropDown() {
    return DropdownButtonHideUnderline(child : 
     Container(
      margin: const EdgeInsets.only(left: 20 ,right: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButton<FaultModel>(
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Select Type' , style: TextStyle(color: Colors.black),),
        ),
        value: _selectedLocation,
        items: _locations.map((FaultModel value) {
          return new DropdownMenuItem<FaultModel>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(value.fault_type , style: TextStyle(color: Colors.black),),
            ),
          );
        }).toList(),
        onChanged: (FaultModel newValue) {
          setState(() {
           _selectedLocation = newValue;
           priceController.text = _selectedLocation.fault_price;
          });
        },
      ),
    )
    );
  }

  priceLayout() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
          borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          controller: priceController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black , fontSize: 17),
            decoration: InputDecoration(
              prefix: Padding(
                padding: const EdgeInsets.only(left : 4 , right : 8.0),
                child: Text('\u20B9' , style: TextStyle(color: Colors.black),),
              ),
              hintText: 'Price',
              border: InputBorder.none
            ),
        ),
      )
    );
  }

  requestButton(){

    return GestureDetector(
      onTap: (){
        getLocation();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30 , right: 30),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Request Engineer' , style: TextStyle(fontSize: 18),),
            SizedBox(width: 10,),
            Icon(Icons.arrow_right_alt_sharp ,color: Colors.white,)
          ],
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorConstants.APP_THEME_COLOR
        ),
      ),
    );

  }

  commentLayout(){
    return Container(
      margin: const EdgeInsets.only(left: 20 , right: 20 ,bottom: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all()
      ),
      child: TextField(
        maxLines: 6,
        controller: commentController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black , fontSize: 17),
        decoration: InputDecoration(
            hintText: 'Your comments',
            prefix: Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            border: InputBorder.none
        ),
      ),
    );
  }

   getLocation() async{

     isLoading = true;
     setState(() {
     });

    LocationData data = await LocationHandler.getLocation();

    double lat = await data.latitude;
    double long = await data.longitude;


    final coordinates = new Coordinates(lat, long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    sendFault(lat , long , first.addressLine);

   }

   sendFault(double lat, double long, String addressLine) async{

     var body;

     if(commentController.text != ""){
       body = {
         "token" : "9306488494",
         "comments" : commentController.text,
         "latt" : lat,
         "longg" : long,
         "user_name" : username,
         "user_id" : userId,
         "mobb" : mobb,
         "email" : email,
         "breakdown_loc" : addressLine,
         "fault_problem" : _selectedLocation.fault_type
       };
     }
     else{
       body = {
         "token" : "9306488494",
         "latt" : lat,
         "longg" : long,
         "user_name" : username,
         "user_id" : userId,
         "mobb" : mobb,
         "email" : email,
         "breakdown_loc" : addressLine,
         "fault_problem" : _selectedLocation.fault_type
       };
     }

     var response = await FaultService.saveComplaint(body);

     print("-----------${response}");
     if(response != null){



       isLoading  = false;
       setState(() {
       });

       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => PaymentScreenRequestEng("token=9306488494&uuid=" + response.toString() +"&phone="+ mobb +"&user_name="+ username +"&user_email=" + email +"&price=" + priceController.text
         )),
       );


     }
     else{
       isLoading  = false;
       setState(() {
       });
       Fluttertoast.showToast(msg: "Error sending request!" , textColor: Colors.white , backgroundColor: Colors.black);
     }



   }

}
