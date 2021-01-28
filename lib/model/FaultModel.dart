class FaultModel{

  var fault_type;
  var fault_price;

  FaultModel(obj){
    fault_type = obj["fault_name"];
    fault_price = obj["fault_price"];
  }

  static fromJSONList(list) {
    List<FaultModel> newList = [];
    for(var item in list) {
      newList.add(FaultModel(item));
    }
    return newList;
  }


}