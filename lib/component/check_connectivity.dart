import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:workmate_01/utils/colors.dart';

class InternetConnectionChecker extends StatefulWidget {
  @override
  _InternetConnectionCheckerState createState() =>
      _InternetConnectionCheckerState();
}

class _InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  late StreamSubscription<ConnectivityResult> _subscription;
  late StreamController<bool> _streamController;
  late bool isConnected;
  // late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<bool>();
      isConnected = false;
      _subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        _checkConnection(result);
        
      });
  

    // _checkConnection(ConnectivityResult); // Initial check
    //_initializeNotifications();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _streamController.close();
  }

  Future<void> _checkConnection(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      _streamController.add(false);
      //_showNotification();
      AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'No Internet Connection',
              desc: 'Please check your internet connection and try again.',
              btnOkOnPress: () {
                _checkConnection(result);
              },
              btnOkText: 'Try Again')
          .show();
    } else {
      Get.back();
      _streamController.add(true);
    }
  }

  // Future<void> _initializeNotifications() async {
  //   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   // ignore: prefer_const_declarations
  //   final InitializationSettings initializationSettings =
  //       const InitializationSettings(android: initializationSettingsAndroid);
  //   await _flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //   );
  // }

  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'lost_internet_channel',
  //     'Lost Internet Connection',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     playSound: true,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     'No Internet Connection',
  //     'Please check your internet connection',
  //     platformChannelSpecifics,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: StreamBuilder<bool>(
          stream: _streamController.stream,
          initialData: isConnected,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return const SizedBox(
                height: 0,
              );
            } else {
              return const Text(
                'No internet connection',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
    );
  }
}
