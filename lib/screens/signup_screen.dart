import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/main.dart';
import 'package:gomechanic/services/AuthService.dart';
import 'package:gomechanic/utils/LocationHandler.dart';
import 'package:location/location.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool isObscure = true , isConfirmObscure = true;
  bool isLoading = false , isMechanic = false;


  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var type = "" , latt = "" , long = "" , state = "";

  Location location = new Location();
  LocationData _locationData;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/back.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Center(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Image.asset("images/logo.png" , scale: 1.7,),
                      SizedBox(height: 30,),
                      loginPanel()
                    ],
                  ),
                ),
              ],
            ) /* add child content here */,
          ),
          (isLoading) ? Center(
            child: CircularProgressIndicator(),
          ) : Container()
        ],
      ),
    );
  }

  loginPanel()
  {
    return Opacity(
      opacity: 0.8,
      child: Container(
        padding: const EdgeInsets.only(top: 30 , bottom: 50),
        margin: const EdgeInsets.only(left: 30 , right: 30),
        decoration: BoxDecoration(
            color: Colors.black
        ),
        width: MediaQuery.of(context).size.width,
        child: loginElements(),
      ),
    );
  }

  loginElements()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10 , top: 5),
          margin: const EdgeInsets.all(20),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
          ),
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Phone",
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10 , top: 5),
          margin: const EdgeInsets.all(20),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Email",
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10 , top: 5),
          margin: const EdgeInsets.all(20),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
          ),
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Username",
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10 , top: 5),
          margin: const EdgeInsets.all(20),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
          ),
          child: TextField(
            controller: passwordController,
            obscureText: isObscure,
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: (){
                    isObscure = !isObscure;

                    setState(() {
                    });
                  },
                    child: Icon((!isObscure) ? Icons.visibility : Icons.visibility_off , color: Colors.white)),
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10 , top: 5),
          margin: const EdgeInsets.all(20),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
          ),
          child: TextField(
            controller: confirmPasswordController,
            obscureText: isConfirmObscure,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: (){
                    isConfirmObscure = !isConfirmObscure;

                    setState(() {
                    });
                  },
                  child: Icon((!isConfirmObscure) ? Icons.visibility : Icons.visibility_off , color: Colors.white)),
              border: InputBorder.none,
              hintText: "Confirm Password",
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 0 , top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  isMechanic = !isMechanic;

                  setState(() {
                  });

                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 25,
                  width: 25,
                  child: Padding(
                    padding: const EdgeInsets.only(left : 0 , right: 2),
                    child: (isMechanic) ? Icon(Icons.done , color: Colors.white,) : Container(),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text('I am a mechanic')
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            doSignup();
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30 , right: 30 , top: 20),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: Text('Sign up' , style: TextStyle(color : Colors.black , fontSize: 20 ,fontWeight: FontWeight.bold),),
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account?' , style: TextStyle(color: Colors.white70 , fontWeight: FontWeight.w600),),
            SizedBox(width: 10,),
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text('Sign in' , style: TextStyle(color: Colors.blue)))
          ],
        )
      ],
    );
  }

  doSignup() async{


    if(passwordController.text == confirmPasswordController.text && passwordController.text!="")
    {
      isLoading = true;
      setState(() {

      });


      await getLatLng();

      String username = usernameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String pass = passwordController.text;


      if (pass != "" && username != "" && phone != "" && type != "" &&
          email != "" && latt != "" && long != "") {
        var res = await AuthService.register(
            username,
            email,
            latt,
            long,
            phone,
            pass,
            state,
            type
        );

        if (res != null) {
          Fluttertoast.showToast(msg: "Successfully signed up !",
              textColor: Colors.black,
              backgroundColor: Colors.white);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }


        isLoading = false;
        setState(() {

        });
      }
      else {
        Fluttertoast.showToast(msg: 'Empty Fields!',
            textColor: Colors.black,
            backgroundColor: Colors.white);
      }
    }
    else{
      Fluttertoast.showToast(msg: "Password different !",
          textColor: Colors.black,
          backgroundColor: Colors.white);
    }

  }

  getLatLng() async{

    LocationData data = await LocationHandler.getLocation();

    latt = data.latitude.toString();
    long = data.longitude.toString();


    if(isMechanic)
      type = "2";
    else
      type = "1";

  }

}
