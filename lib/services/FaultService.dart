import 'package:gomechanic/model/FaultModel.dart';
import 'package:gomechanic/model/complain_history_model.dart';
import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/request_handler.dart';

class FaultService{

  static const String TOKEN = "9306488494";

  static  getFaultList() async{
     var response = await RequestHandler.GET(ApiConstants.FAULT_TYPE , {
           "token":  TOKEN
         });

     print(response);
     if(response["status"] == "1" && response["data"].length > 0){
       List<FaultModel> faultList = await FaultModel.fromJSONList(response["data"]);
       return faultList;
     }
     else
       null;
  }


  static  saveComplaint(body) async{
    var response = await RequestHandler.GET(ApiConstants.COMPLAINT , body);

    print(response);
    if(response["status"] == "1" && response["data"]!=null){
      return response["data"][0]["uuid"];
    }
    return null;
  }


  static complaintHistory(body) async{
    var response = await RequestHandler.GET(ApiConstants.COMPLAIN_HISTORY , body);

    print(response);
    if(response["status"] == "1" && response["data"]!=null){
      List<CompliantHistoryModel> list = await CompliantHistoryModel.fromJSONList(response["data"]);
      return list;
    }
    return null;
  }



}