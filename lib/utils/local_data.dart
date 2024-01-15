import 'package:get_storage/get_storage.dart';
import 'package:workmate_01/model/user_model.dart';

class LocalData {
  var box = GetStorage();

  getname() {
    String name = box.read('username');
    return name;
  }

  getEmpCode() {
    String code = box.read('code');
    return code;
  }

  getMobileNo() {
    String mobile = box.read('mobile');
    return mobile;
  }

  getProductName() {
    String productname = box.read('productname');
    return productname;
  }
}