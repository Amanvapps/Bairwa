import 'package:gomechanic/model/completed_task_model.dart';
import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/request_handler.dart';

class MechanicTasksService{

  static const String TOKEN = "9306488494";

  static getCompletedTasks(userId)async{
    var res = await RequestHandler.GET(ApiConstants.COMPLETED_TASKS , {
      "token" : TOKEN,
      "user_id" : userId
    });


    List<CompletedTaskModel> completedTaskList = CompletedTaskModel.fromJSONList(res["data"]);
    //8878676288

    print("this" +res.toString());
    return completedTaskList;
  }

  static getNewTasks(userId)async{
    var res = await RequestHandler.GET(ApiConstants.NEW_TASKS , {
      "token" : TOKEN,
      "user_id" : userId
    });


   List<CompletedTaskModel> newTaskList = CompletedTaskModel.fromJSONList(res["data"]);
    //8878676288

    print(res);
   return newTaskList;
  }

  static completeTask(query) async {
    print("query--" + query.toString());
    var res = await RequestHandler.GET(ApiConstants.COMPLETE_TASK_MESSAGE , query);
    print(res);
    if(res["status"] == "1"){
      return true;
    }
    return false;
  }

  static completeTaskStatus(query) async {
    var res = await RequestHandler.GET(ApiConstants.COMPLETE_TASKS , query);
    print("here--" + res.toString());
    if(res["status"] == "1"){
      return true;
    }
    return false;
  }

  static getDutyStatus(id) async {
    var res = await RequestHandler.GET(ApiConstants.DUTY_STATUS , {
      "token" : TOKEN,
      "user_id" : id
    });

    print(res);
    return res["data"][0]["duty_status"];
  }


  static changeDutyStatus(id , ops) async {
    var res = await RequestHandler.GET(ApiConstants.SWITCH_DUTY , {
      "token" : TOKEN,
      "user_id" : id,
      "ops" : ops
    });

   if(res["status"] == "1")
    return true;
  }

  static about() async {
    var res = await RequestHandler.GET(ApiConstants.ABOUT_US , {
      "token" : TOKEN
    });

    print(res);
    if(res["status"] == "1")
      return res["data"];
  }



}