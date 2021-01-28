class CompletedTaskModel {

  var fault_prob;
  var client_name;
  var client_mobile;
  var breakdown_loc;
  var fault_date;
  var fault_time;
  var lat , lng;
  var fault_sr;


  CompletedTaskModel(obj) {
    breakdown_loc = obj["breakdown_loc"];
    fault_prob = obj["fault_prob"];
    client_name = obj["client_name"];
    client_mobile = obj["client_mobile"];
    fault_date = obj["fault_date"];
    fault_time = obj["fault_time"];
    lat = obj["latt"];
    lng = obj["longg"];
    fault_sr = obj["fault_sr"];
  }

  static fromJSONList(list) {
    List<CompletedTaskModel> newList = [];
    for (var item in list) {
      newList.add(CompletedTaskModel(item));
    }
    return newList;
  }

}

