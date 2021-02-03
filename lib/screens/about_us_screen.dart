import 'package:flutter/material.dart';
import 'package:gomechanic/services/MechanicTasksService.dart';
import 'package:gomechanic/utils/MechanicDrawerElements.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List aboutList=[];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAbout();


  }

  getAbout() async{
    aboutList = await MechanicTasksService.about();
    isLoading = false;
    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.white),
          elevation: 2,
          // title: Center(child: Text('Apna Thanda' , style: TextStyle(color: Colors.white),)),
          actions : <Widget>[
          ]
      ),
      body: SafeArea(
        child: Center(
          child: (!isLoading) ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 230,
                  width: 230,
                  child: Image.asset("images/logo.png"  , fit: BoxFit.contain,)),
              Container(
                  width  : MediaQuery.of(context).size.width/1.2
                  ,child: Text(aboutList[0]["about"]
                , style: TextStyle(fontSize: 20 ,color: Colors.black),)),
              SizedBox(height: 14,),
              Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(7 , 116 , 78 , 1),)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Address : ' ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500 ,color: Colors.black),),
                          Text(aboutList[0]["address"] ,style: TextStyle(fontSize: 16 ,color: Colors.black))
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mobile : ' ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500 ,color: Colors.black),),
                          Text(aboutList[0]["mobile"] ,style: TextStyle(fontSize: 16 ,color: Colors.black))
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Support Email : ' ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500 ,color: Colors.black),),
                          Text(aboutList[0]["support_email"] ,style: TextStyle(fontSize: 16 ,color: Colors.black))
                        ],
                      ),
                      SizedBox(height: 20,),
                    ],
                  )
              )
            ],
          ) : CircularProgressIndicator(),

        ),
      ),
    );
  }
}
