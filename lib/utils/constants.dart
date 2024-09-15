import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

const BASEURL = "https://wsn2.workgateway.in";
const ImageURL = 'https://wsn2.workgateway.in/public/application_img/';
//var BoxToken = "wMGDszgnauH29GKkmiefEm8pEf4onsDJw_i8csmwzZ5FxC0CWoYAi5692Gr0MW28pbjzuC5ISE6Gw--4u2lKc4GUzO2u5MO-VQNgfxxFNDslClZaht-DQIoz2iDWyDCVH5Cl08OMfilpqCoYmbaqzvKAw5ikUHtufBU5KqqhQSGeVzC07JxT_rgBYLpWA2EqzCbXYbMBasxqKmV81zaFHVFXd-quXjIhnu8T568_fFVG1IjEOhj1ILtQLmN9uPwuPkv8J6pbrZqiWIu_czRyeoF1MoViVvKVkOJcfB2SrSFUBy0emAH9gnhWtPu9KIcwpDt-TG-FRfyaWOglfJr3bQuIJCz7V5jLTjXex431g0k";

constToast(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

String convertTimestampToTime(String timestamp) {
  
  if (timestamp.trim().isEmpty) {
    return '-:-'; 
  }
  
  try {
    // Parse the timestamp to DateTime
    DateTime dateTime = DateTime.parse(timestamp);
    // Format the DateTime to a 12-hour time format with AM/PM
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  } catch (e) {
    // Handle parsing errors
    return '-:-'; 
  }
}

String visitID ='';
