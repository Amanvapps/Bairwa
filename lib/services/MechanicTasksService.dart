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

    print(res);
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
    var res = await RequestHandler.GET(ApiConstants.COMPLETE_TASK_MESSAGE , query);
    print(res);
    if(res["status"] == "1"){
      return true;
    }
    return false;
  }

  static completeTaskStatus(query) async {
    var res = await RequestHandler.GET(ApiConstants.COMPLETE_TASK_MESSAGE , query);
    print(res);
    if(res["status"] == "1"){
      return true;
    }
    return false;
  }



}