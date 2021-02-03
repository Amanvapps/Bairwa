import 'package:gomechanic/model/PackageModel.dart';
import 'package:gomechanic/model/ServiceModel.dart';
import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/request_handler.dart';

class PackageService{

  static const String TOKEN = "9306488494";

  static getUserPackage(userId , mob , email) async{

    var response = await RequestHandler.GET(ApiConstants.PACK_DETAILS , {
      "token" : TOKEN,
      "user_id" : userId,
      "user_mobb" : mob,
      "user_email" : email
    });

    if(response["status"] == "1" && response["data"].length > 0){
      List<PackageModel> list = PackageModel.fromJSONList(response["data"]);
      return list;
    }

    return null;


  }

  static savePackageInfo(query) async{

    var response = await RequestHandler.GET(ApiConstants.SAVE_PACKAGE , query);

    if(response["status"] == "1"){
      return response["data"][0]["uuid"];
    }
    return null;


  }


  static getUserService(userId ,  email) async{

    var response = await RequestHandler.GET(ApiConstants.SERVICE_DETAILS , {
      "token" : TOKEN,
      "user_id" : userId,
      "email" : email
    });

    if(response["status"] == "1" && response["data"].length > 0){
      List<ServiceModel> list = ServiceModel.fromJSONList(response["data"]);
      return list;
    }

    return null;


  }


  static getServiceType() async{

    var response = await RequestHandler.GET(ApiConstants.SERVICE_TYPE , {
      "token" : TOKEN,
    });

    if(response["status"] == "1" && response["data"].length > 0){
      return response["data"];
    }

    return null;


  }

  static getBrand(serviceType) async{

    var response = await RequestHandler.GET(ApiConstants.MAKE_MODEL , {
      "token" : TOKEN,
      "service_type" : serviceType
    });

    print(response);
    if(response["status"] == "1" && response["data"].length > 0){
      return response["data"];
    }

    return null;


  }


  static getYears() async{

    var response = await RequestHandler.GET(ApiConstants.YEARS , {
      "token" : TOKEN,
    });

    if(response["status"] == "1" && response["data"].length > 0){
      return response["data"];
    }

    return null;


  }

  static getModel(String selectedLocation, String brandLocation) async{
    var response = await RequestHandler.GET(ApiConstants.CAR_NAME , {
      "token" : TOKEN,
      "service_type" : selectedLocation,
      "brand_name" : brandLocation
    });

    print(response);
    if(response["status"] == "1" && response["data"].length > 0){
      return response["data"];
    }

    return null;
  }




}