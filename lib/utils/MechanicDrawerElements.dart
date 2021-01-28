import 'package:flutter/material.dart';
import 'package:gomechanic/screens/MechanicHomeScreen.dart';
import 'package:gomechanic/screens/new_task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicDrawerElements extends StatefulWidget {

  var from;

  MechanicDrawerElements(this.from);

  @override
  _MechanicDrawerElementsState createState() => _MechanicDrawerElementsState();
}

class _MechanicDrawerElementsState extends State<MechanicDrawerElements> {
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
          leading: Icon(Icons.shopping_bag),
          title: Text('Completed Tasks' , style: TextStyle(color: Colors.black)),
          onTap: () {
            if(widget.from!='home'){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MechanicHomeScreen()),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('New Tasks' , style: TextStyle(color: Colors.black)),
          onTap: () {
            if(widget.from!='new'){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTaskScreen()),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.cancel),
          title: Text('Off Duty' , style: TextStyle(color: Colors.black)),
          onTap: () async {

            // // Navigator.pop(context);
            // // await Navigator.push(
            // //   context,
            // //   MaterialPageRoute(builder: (context) => FaultRequestScreen()),
            // // );
            // isLoading = true;
            // setState(() {
            // });
            //
            // loadProfile();
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

            //
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyHomePage()),
            // );



          },
        ),

      ],
    );
  }
}
