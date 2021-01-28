class CompliantHistoryModel{


  var fault_type;
  var fault_price;
  var date;
  var time;
  var location;
  var mechanic;
  var mechanicId;

  CompliantHistoryModel(obj){
    fault_type = obj["fault_prob"];
    fault_price = obj["c_price"];
    date = obj["c_date"];
    time = obj["c_time"];
    location = obj["c_breakdown"];
    mechanic = obj["c_engg"];
    mechanicId = obj["c_id"];
  }

  static fromJSONList(list) {
    List<CompliantHistoryModel> newList = [];
    for(var item in list) {
      newList.add(CompliantHistoryModel(item));
    }
    return newList;
  }


}