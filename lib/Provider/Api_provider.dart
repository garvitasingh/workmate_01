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

  Future<dynamic> uploadImage({file}) async {
    var token = box.read("token");
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         '$BASEURL/v1/application/file/upload-attendence-image-local'));
    // print(file.path);
    // if (file != null) {
    //   request.files.add(await http.MultipartFile.fromPath(
    //     'file',
    //     file.path,
    //     contentType: MediaType('file', 'png'),
    //   ));
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'genie_refresh_token=s%3AeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkRGF0YSI6eyJyZXF1ZXN0SVAiOiIxMDYuMjIxLjIzMi4yMzciLCJhcHBVc2VySWQiOiJJVDAwMyIsIkRlc2lnSWQiOiI0In0sImlhdCI6MTcxMjgxODQ1NiwiZXhwIjoxNzEyODYwMTk5LCJpc3MiOiJub3VyaXNoZ2VuaWUuY29tIn0.IllKbXtE9uhglb8vfAIeAScBkQPLDXUgb7AiGXkIZTw.O9aze%2BUmnb3bXw8%2FAsh2P17eGZe6NIVRMu%2FfKUQfLmw'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://3afb-14-99-179-131.ngrok-free.app/v1/application/file/upload-attendence-image-local'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      var decode = jsonDecode(await response.stream.bytesToString());
      return decode['data']['file_name'];
    } else {
      print(response.reasonPhrase);
      return null;
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
}
