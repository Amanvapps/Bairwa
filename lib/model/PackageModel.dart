class PackageModel{

  var pack_name;
  var pack_price;
  var pack_date;
  var uuid;
  var package_expire_date;
  var ispackage_expire;
  var car_type;
  var car_model;
  var car;


  PackageModel(obj){
    pack_name = obj["pack_name"];
    pack_price = obj["pack_price"];
    pack_date = obj["pack_date"];
    uuid = obj["uuid"];
    package_expire_date = obj["package_expire_date"];
    ispackage_expire = obj["ispackage_expire"];
    car_type = obj["car_type"];
    car_model = obj["car_model"];
    car = obj["car"];
  }


  static fromJSONList(list) {
    List<PackageModel> newList = [];
    for(var item in list) {
      newList.add(PackageModel(item));
    }
    return newList;
  }

}