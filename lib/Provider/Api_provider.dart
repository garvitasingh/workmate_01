import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../utils/constants.dart';
import '../view/login_view.dart';

class ApiProvider {
  var box = GetStorage();

  Future<dynamic> getRequest({required apiUrl}) async {
    var token = box.read("token");

    var res = await http
        .get(Uri.parse('$apiUrl'), headers: {'Authorization': 'Bearer $token'});

    if (res.statusCode == 200) {
      return res.body;
      // var decodedBody = json.decode(res.body);
      // return decodedBody;
    } else if (res.statusCode == 401) {
      var re = jsonDecode(res.body);
      GetStorage().erase();
      Get.offAll(LoginViewPage());

      return Future.error(res.body);
    } else if (res.statusCode == 404) {
      return Future.error(res.body);
    } else if (res.statusCode == 500) {
      return Future.error(res.body);
    } else {
      return Future.error('Network Problem');
    }
  }

  Future<dynamic> markAtt({data, file}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$BASEURL/Attendance/MarkAttendance'));
    request.fields.addAll({'value': data});
    print(data);
    print(file);
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'Image',
        file.path,
        contentType: MediaType('Image', 'png'),
      ));

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  // Future<dynamic> postRequest({required apiUrl, data}) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request('POST', Uri.parse('$BASEURL$apiUrl'));
  //   request.body = json.encode(data);
  //   request.headers.addAll(headers);
  //   http.StreamedResponse res = await request.send();
  //   print(res.statusCode);
  //   if (res.statusCode == 200) {
  //     var decode = jsonDecode(await res.stream.bytesToString());
  //     print("result is ====  ${decode}");
  //     return decode;
  //     // print(await response.stream.bytesToString());
  //   } else {
  //     return res.reasonPhrase;
  //   }
  // }

  Future<dynamic> postRequestToken({required apiUrl, data}) async {
    var token = box.read("token");
    var res = await http.post(body: data, Uri.parse('$apiUrl'), headers: {
      'Authorization': 'Bearer $token'
    }).timeout(const Duration(seconds: 20));
    print(res.body);
    return jsonDecode(res.body);
    // if (res.statusCode == 200) {
    //   return res;
    // } else if (res.statusCode == 400) {
    //   return Future.error(res.body);
    // } else if (res.statusCode == 404) {
    //   return Future.error(res.body);
    // } else if (res.statusCode == 500) {
    //   return Future.error(res.body);
    // } else {
    //   return Future.error('Network Problem');
    // }
  }

  // Future<dynamic> postRequestRegister(
  //     {required apiUrl, data, token, email, mobile, name}) async {
  //   var request = http.Request(
  //       'POST', Uri.parse('http://209.38.239.249:8080/app/register'));
  //   request.bodyFields = {
  //     'token': token,
  //     'registerData':
  //         '{"email":"${email}","name":"${name}","mobile_number":"${mobile}"}'
  //   };
  //
  //   http.StreamedResponse res = await request.send();
  //   var response = res.stream.bytesToString();
  //   if (res.statusCode == 200) {
  //     return res;
  //   } else if (res.statusCode == 401) {
  //     return Future.error(response);
  //   } else if (res.statusCode == 404) {
  //     return Future.error(response);
  //   } else if (res.statusCode == 500) {
  //     return Future.error(response);
  //   } else {
  //     return Future.error('Network Problem');
  //   }
  // }
  //
  // Future<dynamic> patchRequest({required apiUrl, data}) async {
  //   var token = box.read("token");
  //   // print(token);
  //   var res = await http.patch(
  //       body: data,
  //       Uri.parse('$BASEURL$apiUrl'),
  //       headers: {'Authorization': 'Bearer $token'});
  //   print(res.body);
  //   if (res.statusCode == 200) {
  //     return res;
  //   } else if (res.statusCode == 401) {
  //     return Future.error(res.body);
  //   } else if (res.statusCode == 404) {
  //     return Future.error(res.body);
  //   } else if (res.statusCode == 500) {
  //     return Future.error(res.body);
  //   } else {
  //     return Future.error('Network Problem');
  //   }
  // }
}
