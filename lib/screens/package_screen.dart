import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/screens/buy_package_screen.dart';
import 'package:gomechanic/screens/customer_home_screen.dart';
import 'package:gomechanic/screens/fault_request_screen.dart';
import 'package:gomechanic/screens/service_history_screen.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
import 'package:gomechanic/utils/CompanyDrawerElements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';


import '../main.dart';


class PackageScreen extends StatefulWidget {
  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  DateTime currentBackPressTime;

  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: new Scaffold(
         appBar: AppBar(
           elevation: 0,
           automaticallyImplyLeading: false,
           title: Center(child: Text('    Package' , style: headingTextStyle,)),
           backgroundColor: ColorConstants.APP_THEME_COLOR,
           iconTheme: IconThemeData(
            color: Colors.white,
           ),
          ),
          endDrawer: Drawer(
              child : CompanyDrawerElements('package')
          ),
           body: Stack(
            children: [
              Container(
                color: ColorConstants.APP_THEME_COLOR,
              ),
//            new Swiper(
//              itemBuilder: (BuildContext context, int index) {
//                return Container(
//                 child: Card(
//                   child: packageDesc(index),
//                   color: Colors.white,
//                  elevation: 14,
//                ),
//                  margin: EdgeInsets.only(top: 40 , bottom: 80),
//                );
//              },
//              itemCount: 4,
//              itemWidth: 360.0,
//              pagination: new SwiperPagination(),
//              layout: SwiperLayout.STACK,
//            ),

              Container(
                width: MediaQuery.of(context).size.width,
                 child:  CarouselSlider.builder(
                  options: CarouselOptions(height: MediaQuery.of(context).size.height/1),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int itemIndex) =>

                      Column(
                        children: [
                          GestureDetector(
                             onTap: (){

                               String type="";
                               int amount = 0;

                               if(itemIndex==0){
                                 type="Silver";
                                 amount = 1249;
                               }
                               else if(itemIndex == 1){
                                 type="Gold";
                                 amount = 1599;
                               }
                               else if(itemIndex == 2){
                                 type="Diamond";
                                 amount = 2599;
                               }
                               else if(itemIndex == 3){
                                 type="Platinum";
                                 amount = 5249;
                               }



                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => BuyPackageScreen(type , amount)),
                               );
                             },
                            child: Container(
                              margin : EdgeInsets.only(top: 15) ,
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.center,
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10))
                              ),
                              child: Text('Buy' , style: TextStyle(color: Colors.black , fontSize: 25 , fontWeight: FontWeight.w500),),
                            ),
                          ),
                          Container(
                            child: Card(
                              child: packageDesc(itemIndex),
                              color: Colors.white,
                              elevation: 14,
                            ),
                            margin: EdgeInsets.only(bottom: 40),
                          ),
                        ],
                      )
                ),
              )
            ],
          )
      ),
    );
  }

  packageDesc(int index)
  {

    print(index);

    if(index==0){
      return silverPackageLayout();
    }
    else if(index == 1){
      return goldPackageLayout();
    }
    else if(index == 2){
      return diamondPackageLayout();
    }
    else if(index == 3){
      return platinumPackageLayout();
    }


  }


  silverPackageLayout(){
    return  Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Silver Package' , style: TextStyle(fontSize: 20 , color: ColorConstants.APP_THEME_COLOR , fontWeight: FontWeight.bold),),
                  Text('\u{20B9} 1249' , style: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.normal),)
                ],
              )),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: MediaQuery.of(context).size.height/1.5,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Vehicle Type - All Passengers Cars' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coverage - Delhi NCR' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Number of Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cooling Period - 72 hours' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
                , SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('First hand assistance of technical problem over phone' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Towing Services' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Free Towing' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Repair on Site Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Rubbing Polish and Dry Cleaning' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Battery jump start' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Key Assist - Locked Keys, Lost Keys or Broken Vehicle Key' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Tyre Assist - Tyre Replacement' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Assist - Out of Fuel, Incorrect Fuel, Contiminated Fuel' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Delivery' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coolent' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Relay On Urgent Messages' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Medical Assist - Only Coordination and First Aid' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cab Assist' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Hotel Coordination' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  goldPackageLayout(){
    return  Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gold Package' , style: TextStyle(fontSize: 20 , color: ColorConstants.APP_THEME_COLOR , fontWeight: FontWeight.bold),),
                  Text('\u{20B9} 1599' , style: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.normal),)
                ],
              )),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: MediaQuery.of(context).size.height/1.5,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Vehicle Type - All Passengers Cars' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coverage - Delhi NCR' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Number of Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cooling Period - 72 hours' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
                , SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('First hand assistance of technical problem over phone' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Towing Services' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Free Towing' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Repair on Site Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Rubbing Polish and Dry Cleaning' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Battery jump start' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Key Assist - Locked Keys, Lost Keys or Broken Vehicle Key' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Tyre Assist - Tyre Replacement' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Assist - Out of Fuel, Incorrect Fuel, Contiminated Fuel' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Delivery' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coolent' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Relay On Urgent Messages' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Medical Assist - Only Coordination and First Aid' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cab Assist' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Hotel Coordination' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  diamondPackageLayout(){
    return  Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Diamond Package' , style: TextStyle(fontSize: 20 , color: ColorConstants.APP_THEME_COLOR , fontWeight: FontWeight.bold),),
                  Text('\u{20B9} 2599' , style: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.normal),)
                ],
              )),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: MediaQuery.of(context).size.height/1.5,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Vehicle Type - All Passengers Cars' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coverage - Delhi NCR' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Number of Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cooling Period - 72 hours' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
                , SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('First hand assistance of technical problem over phone' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Towing Services' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Free Towing' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Repair on Site Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Rubbing Polish and Dry Cleaning' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Battery jump start' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Key Assist - Locked Keys, Lost Keys or Broken Vehicle Key' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Tyre Assist - Tyre Replacement' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Assist - Out of Fuel, Incorrect Fuel, Contiminated Fuel' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Delivery' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coolent' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Relay On Urgent Messages' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Medical Assist - Only Coordination and First Aid' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cab Assist' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.cancel , color: Colors.red,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Hotel Coordination' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }



  platinumPackageLayout(){
    return  Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Platinum Package' , style: TextStyle(fontSize: 20 , color: ColorConstants.APP_THEME_COLOR , fontWeight: FontWeight.bold),),
                  Text('\u{20B9} 5249' , style: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.normal),)
                ],
              )),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: MediaQuery.of(context).size.height/1.5,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Vehicle Type - All Passengers Cars' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coverage - Delhi NCR' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Number of Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cooling Period - 72 hours' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
                , SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('First hand assistance of technical problem over phone' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Towing Services' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Free Towing' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('No of Repair on Site Services - 4' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Rubbing Polish and Dry Cleaning' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Battery jump start' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Key Assist - Locked Keys, Lost Keys or Broken Vehicle Key' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Tyre Assist - Tyre Replacement' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Assist - Out of Fuel, Incorrect Fuel, Contiminated Fuel' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Fuel Delivery' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Coolent' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Relay On Urgent Messages' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Medical Assist - Only Coordination and First Aid' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Cab Assist' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.done_outline , color: Colors.green,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('Hotel Coordination' , style: TextStyle(fontSize: 17 , color: Colors.black , fontWeight: FontWeight.normal),)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
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
