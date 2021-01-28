class ServiceModel{

  var breakdown_loc;
  var comments;
  var fault_prob;
  var name;
  var payment_id;
  var price;
  var service_amount;
  var service_date;
  var service_time;
  var user_id;
  var uuid;


  ServiceModel(obj){
    breakdown_loc = obj["breakdown_loc"];
    comments = obj["comments"];
    fault_prob = obj["fault_prob"];
    name = obj["name"];
    payment_id = obj["payment_id"];
    price = obj["price"];
    service_amount = obj["service_amount"];
    service_date = obj["service_date"];
    service_time = obj["service_time"];
    user_id = obj["user_id"];
    uuid = obj["uuid"];
  }

  static fromJSONList(list) {
    List<ServiceModel> newList = [];
    for(var item in list) {
      newList.add(ServiceModel(item));
    }
    return newList;
  }

}