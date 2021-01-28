import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/main.dart';
import 'package:gomechanic/services/AuthService.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 250,
                      child: Image.asset("images/logo.png",  scale: 1,)),
                  SizedBox(height: 0,),
                  loginPanel()
                ],
              ),
            ),
            (isLoading) ? Center(
              child: CircularProgressIndicator(),
            ) : Container()
          ],
        ) /* add child content here */,
      ),
    );
  }

  loginPanel()
  {
    return Opacity(
      opacity: 0.8,
      child: Container(
        margin: const EdgeInsets.only(left: 30 , right: 30),
        decoration: BoxDecoration(
            color: Colors.black
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2,
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Email",
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){

            resetPass();

          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30 , right: 30 , top: 20),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: Text('Reset Password' , style: TextStyle(color : Colors.black , fontSize: 20 ,fontWeight: FontWeight.bold),),
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Proceed To' , style: TextStyle(color: Colors.white70 , fontWeight: FontWeight.w600),),
            SizedBox(width: 10,),
            GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text('Sign in' , style: TextStyle(color: Colors.blue)))
          ],
        )
      ],
    );
  }

  resetPass() async {



    String phone = phoneController.text;

    if(phone!="")
    {
      isLoading = true;
      setState(() {

      });
      bool res = await AuthService.reset(phone);
      if(res == true)
      {
        isLoading = false;
        setState(() {
        });

        Fluttertoast.showToast(msg: "Reset email has been sen\'t to your mail id" ,  textColor: Colors.black,
            backgroundColor: Colors.white);

      }
      else
      {
        isLoading = false;
        setState(() {
        });

        Fluttertoast.showToast(msg: "Error!" ,  textColor: Colors.black,
            backgroundColor: Colors.white);

      }
    }
    else
    {
      Fluttertoast.showToast(msg: "Empty Fields !" ,  textColor: Colors.black,
          backgroundColor: Colors.white);

      isLoading = false;
      setState(() {
      });
    }


  }
}
