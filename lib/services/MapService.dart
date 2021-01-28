import 'package:gomechanic/utils/ApiConstants.dart';
import 'package:gomechanic/utils/request_handler.dart';

class MapService {

  static const String TOKEN = "9306488494";

  static getMechanicLocation(userId) async {

    var response = await RequestHandler.GET(ApiConstants.CUSTOMER_MAP, {
      "token": TOKEN,
      "user_id": userId
    });


    print(response);

    if(response["status"] == "1" && response["data"].length > 0){
      var obj = {
        'latitude' : response['data'][0]['latitude'],
        'longitude' : response['data'][0]['longitude']
      };
      return obj;
    }

    return null;
  }
}
