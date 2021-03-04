import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomechanic/services/MechanicTasksService.dart';
import 'package:gomechanic/utils/ColorConstants.dart';
class CompleteTaskMessageScreen extends StatefulWidget {

  var fault_sr , userId;

  CompleteTaskMessageScreen(this.fault_sr, this.userId);

  @override
  _CompleteTaskMessageScreenState createState() => _CompleteTaskMessageScreenState();
}

class _CompleteTaskMessageScreenState extends State<CompleteTaskMessageScreen> {

  TextEditingController  reachTimeController = TextEditingController();
  TextEditingController  finishTimeController = TextEditingController();
  TextEditingController  extraServiceController = TextEditingController();
  TextEditingController  amountController = TextEditingController();
  TextEditingController  remarkController = TextEditingController();


  var headingTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 22
  );

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Complete Task' , style: headingTextStyle,)),
        backgroundColor: ColorConstants.APP_THEME_COLOR,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
      children: [
        Container(
          color: ColorConstants.APP_THEME_COLOR,
        ),
        Container(
          padding: EdgeInsets.only(left: 40 , top: 30 , right: 40),
          child: ListView(
            children: [
              Text('Reach Time' , style: TextStyle(fontSize: 17),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: TextField(
                  controller: reachTimeController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: '11:30 AM',
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

              Text('Finish Time' , style: TextStyle(fontSize: 17),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: TextField(
                  controller: finishTimeController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: '12:30 AM',
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

              Text('Extra Service' , style: TextStyle(fontSize: 17),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: TextField(
                  controller: extraServiceController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Extra Service',
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

              Text('Amount' , style: TextStyle(fontSize: 17),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: '2000/-',
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

              Text('Remark' , style: TextStyle(fontSize: 17),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 150,
                child: TextField(
                  controller: remarkController,
                  maxLines: 6,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Remark',
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

              GestureDetector(
                onTap: () async {
                  bool task = await completeTask();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left : 10 , top: 20 , bottom: 20 ,  right: 10),
                  height: 50,
                  child: Text('COMPLETE TASK' ,style: TextStyle(fontSize: 20  , fontWeight: FontWeight.w500),),
                  decoration: BoxDecoration(
                      color : Color.fromRGBO(92, 181, 179, 1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),

            ],
          ),
        ),
        (isLoading) ? Center(child: CircularProgressIndicator(),) : Container()
      ],
    ),
    ),
    );
  }

  completeTask() async {

    if(amountController.text!=""){

      isLoading = true;
      setState(() {
      });

      var query = {
        "token" : "9306488494",
        "engg_id" : widget.userId,
        "complain_id" : widget.fault_sr,
        "reach_time" : reachTimeController.text,
        "finish_time" : finishTimeController.text,
        "extra_service" : extraServiceController.text,
        "amount" : amountController.text,
        "remark" : remarkController.text
      };

      var res = await MechanicTasksService.completeTask(query);

      if(res == true){

        var q = {
          "token" : "9306488494",
          "engg_id" : widget.userId,
          "service_id" : widget.fault_sr
        };
        var result = await MechanicTasksService.completeTaskStatus(q);
        if(result == true){
          Navigator.pop(context , true);
        }

      }

      isLoading = false;
      setState(() {
      });
    }
    else
      Fluttertoast.showToast(msg: "Please fill details!");



  }


}
