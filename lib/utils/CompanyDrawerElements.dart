import 'package:flutter/material.dart';
import 'package:gomechanic/screens/MechanicHomeScreen.dart';
import 'package:gomechanic/screens/about_us_screen.dart';
import 'package:gomechanic/screens/customer_home_screen.dart';
import 'package:gomechanic/screens/fault_request_screen.dart';
import 'package:gomechanic/screens/new_task_screen.dart';
import 'package:gomechanic/screens/package_screen.dart';
import 'package:gomechanic/screens/privacy_policy_screen.dart';
import 'package:gomechanic/screens/service_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class CompanyDrawerElements extends StatefulWidget {

  var from;

  CompanyDrawerElements(this.from);

  @override
  _CompanyDrawerElementsState createState() => _CompanyDrawerElementsState();
}

class _CompanyDrawerElementsState extends State<CompanyDrawerElements> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
          leading: Icon(Icons.home),
          title: Text('Home' , style: TextStyle(color: Colors.black)),
          onTap: () {
           if(widget.from != 'home'){
             Navigator.pop(context);
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
             );
           }
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: Text('Package' , style: TextStyle(color: Colors.black)),
          onTap: () {
            if(widget.from != 'package'){
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PackageScreen()),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Service History' , style: TextStyle(color: Colors.black)),
          onTap: () {
            if(widget.from != 'history'){
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ServiceHistoryScreen()),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.cancel),
          title: Text('Fault Request' , style: TextStyle(color: Colors.black)),
          onTap: () async {

            if(widget.from!='fault'){
              Navigator.pop(context);
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FaultRequestScreen()),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.policy),
          title: Text('Privacy Policy' , style: TextStyle(color: Colors.black)),
          onTap: () {
            if(widget.from!='privacy'){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('About' , style: TextStyle(color: Colors.black)),
          onTap: () {
            if(widget.from!='about'){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            }
          },
        ),
        ListTile(
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
    );
  }
}
