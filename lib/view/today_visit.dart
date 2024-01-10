import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/component/check_in_button.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

class TodayVisit extends StatefulWidget {
  const TodayVisit({super.key});

  @override
  State<TodayVisit> createState() => _TodayVisitState();
}

class _TodayVisitState extends State<TodayVisit> {
  String selectedLocation = 'Pune-Mumbai';
  late Position _currentPosition;
  String Address = 'Location';
  File? _capturedImage;
  bool temp = false;
  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      _currentPosition = await _getGeoLocationPosition();
      await GetAddressFromLatLong(_currentPosition);
    } catch (e) {
      print('Error initializing location: $e');
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')));
      // return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')));
        // return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  Future<void> _openCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _capturedImage = File(pickedFile.path);
        _initializeLocation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedTime = DateFormat('yyyy HH:mm:ss').format(currentDate);
    String formattedDate = DateFormat('EEEE, d MMM yyyy').format(currentDate);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: const Text(
          "Today Visit",
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(color: Colors.white30),
            child: DropdownButton<String>(
              value: selectedLocation,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              elevation: 2,
              items: <String>['Pune-Mumbai', 'Noida-Delhi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
      body: Address == "Location"
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        formattedTime,
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(child: Text(formattedDate)),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: CheckInButton(checkIn: true),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            const WidgetSpan(
                                child: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            )),
                            const TextSpan(
                                text: "Longitude:",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "\n    ${_currentPosition.longitude.toStringAsFixed(4) ?? "--"}",
                                style: const TextStyle(
                                  color: textLightColor,
                                ))
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            const WidgetSpan(
                                child: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            )),
                            const TextSpan(
                                text: "Latitiude:",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "\n    ${_currentPosition.latitude.toStringAsFixed(4) ?? "--"}",
                                style: const TextStyle(
                                  color: textLightColor,
                                ))
                          ]),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildRow("11:45 AM", "Check-in"),
                              _buildRow("--:--", "Check-out"),
                              _buildRow("Process", "Status")
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Today's Punch Logs",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                _punchBuild("Photo"),
                                _punchBuild("Punch Time"),
                                _punchBuild("Location")
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 100,
                                  child: _capturedImage != null
                                      ? Image.file(
                                          _capturedImage!,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                          ),
                                          onPressed: _openCamera,
                                          iconSize: 20,
                                          color: Colors.white,
                                        ),
                                ),
                                Container(
                                    width: 100, child: const Text("11:30 AM")),
                                Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              temp = !temp;
                                            });
                                          },
                                          icon: !temp
                                              ? Icon(Icons.keyboard_arrow_down)
                                              : Icon(Icons.keyboard_arrow_up))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: temp ? 5 : 0,
                            ),
                            temp
                                ? Text(
                                    Address,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(""),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _punchBuild(text) {
    return Container(width: 100, child: Text(text));
  }

  Widget _buildRow(text, text2) {
    return Column(
      children: [
        const Icon(Icons.watch_later_outlined),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(text2)
      ],
    );
  }
}
