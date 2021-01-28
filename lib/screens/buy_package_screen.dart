import 'package:flutter/material.dart';
import 'package:gomechanic/screens/package_screen.dart';
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

  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getServiceType();


  }



  getServiceType() async{
    List res = await PackageService.getServiceType();

    await res.forEach((element) {
      serviceTypeList.add(element["service_type"]);
    });

    await getYears();


  }

  getBrand() async{
    List res = await PackageService.getBrand();

    await res.forEach((element) {
      brandList.add(element["service_type"]);
    });

//    await getBrand();
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
              leading: Icon(Icons.shopping_bag),
              title: Text('Package' , style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
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
              leading: Icon(Icons.cancel),
              title: Text('Fault Request' , style: TextStyle(color: Colors.black)),
              onTap: () async {

                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FaultRequestScreen()),
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
                  Text('Discount Coupon' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Coupon code',
                        suffixIcon: Container(
                          height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(92, 181, 179, 1),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomRight: Radius.circular(20))
                            ),
                            child: Icon(Icons.done , color: Colors.white,)),
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

                  Text('Registration Number' , style: TextStyle(fontSize: 17),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    child: TextField(
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
                          setState(() {
                            _brandLocation = newValue;
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

                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left : 20 , top: 20 , bottom: 20 ,  right: 20),
                    height: 50,
                    child: Text('Buy Now' ,style: TextStyle(fontSize: 20  , fontWeight: FontWeight.w500),),
                    decoration: BoxDecoration(
                        color : Color.fromRGBO(92, 181, 179, 1),
                        borderRadius: BorderRadius.circular(20)
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
}
