import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:geocoding/geocoding.dart';

class TodayVisit extends StatefulWidget {

  const TodayVisit({super.key});

  @override
  State<TodayVisit> createState() => _TodayVisitState();
}

class _TodayVisitState extends State<TodayVisit> {
  String selectedLocation = 'Pune-Mumbai';
  late Position _currentPosition;
  String Address = 'Location';

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
      // Handle any exceptions or errors here
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

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedTime = DateFormat('yyyy HH:mm:ss').format(currentDate);
    String formattedDate = DateFormat('EEEE, d MMM yyyy').format(currentDate);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text("Today Visit",),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white30
            ),
            child: DropdownButton<String>(
              value: selectedLocation,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              elevation: 2, // Control the shadow appearance
              items: <String>['Pune-Mumbai','Noida-Delhi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black), // Text color of dropdown items
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(formattedTime,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Center(
                  child: Text(formattedDate)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text:TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.location_on,color: Colors.blue,)),
                        TextSpan(
                          text: "Longitude:",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                            text: "\n    ${_currentPosition.longitude.toStringAsFixed(4)?? "--"}",
                            style: TextStyle(
                                color: textLightColor,
                            )
                        )
                      ]
                    ),
                  ),
                  RichText(
                    text:TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.location_on,color: Colors.blue,)),
                          TextSpan(
                              text: "Latitiude:",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          TextSpan(
                              text: "\n    ${_currentPosition.latitude.toStringAsFixed(4)??"--"}",
                              style: TextStyle(
                                color: textLightColor,
                              )
                          )
                        ]
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}