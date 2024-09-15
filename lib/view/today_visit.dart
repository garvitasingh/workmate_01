// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/component/check_in_button.dart';
import 'package:workmate_01/controller/attendance_controller.dart';
import 'package:workmate_01/swimmer_widget/today_widget_swimmer.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmate_01/utils/constants.dart';

import '../Provider/Api_provider.dart';

class TodayVisit extends StatefulWidget {
  const TodayVisit({super.key});

  @override
  State<TodayVisit> createState() => _TodayVisitState();
}

class _TodayVisitState extends State<TodayVisit> {
  // AttendanceController controller = Get.put(AttendanceController());
  late String formattedTime;

  late Position _currentPosition;

  String Address = 'Location';
  File? _capturedImage;
  String image = '';
  bool temp = false;
  bool _load = false;
  @override
  void initState() {
    super.initState();
    _initializeLocation();
    updateFormattedTime();

    // Set up a timer to refresh the time every second
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        // Check if the widget is still mounted before updating the state
        updateFormattedTime();
        // controller.getAttendanceLogs();
      }
    });
  }

  void updateFormattedTime() {
    setState(() {
      DateTime currentDate = DateTime.now();
      formattedTime = DateFormat('yyyy HH:mm:ss').format(currentDate);
    });
  }

  Future<void> _initializeLocation() async {
    try {
      _currentPosition = await _getGeoLocationPosition();
      await GetAddressFromLatLong(_currentPosition);
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing location: $e');
      }
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
    if (kDebugMode) {
      print(placemarks);
    }
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  Future<void> _openCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: Platform.isIOS?ImageSource.gallery: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _capturedImage = File(pickedFile.path);
        _initializeLocation();
        _storeImage();
      });
    }
  }

  _storeImage() async {
    setState(() {
      _load = true;
    });
    image = await ApiProvider().uploadImage(file: _capturedImage);
    setState(() {
      _load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMM yyyy').format(currentDate);

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: secondaryColor,
              )),
          centerTitle: false,
          backgroundColor: appbarColor,
          title: const Text(
            "Today Visit",
            style: TextStyle(color: secondaryColor),
          ),
          actions: [
            //  Text(controller.visits[0].toString()),

            GetBuilder<AttendanceController>(
              init: AttendanceController(),
              builder: (controller) {
                // return Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   margin: const EdgeInsets.all(8.0),
                //   decoration: BoxDecoration(
                //     color: Colors.green,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: DropdownButton<String>(
                //     value: controller.selectedLocation,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         controller.selectedLocation = newValue!;
                //         controller.getvisitId();
                //       });
                //     },
                //     elevation: 2,
                //     items: controller.visits
                //         .toList()
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(
                //           value.toString(),
                //           style: const TextStyle(color: Colors.black),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // );
                return DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: controller.visits
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: controller.selectedLocation,
                    onChanged: (String? value) {
                      setState(() {
                        controller.selectedLocation = value;
                        controller.getvisitId();
                        controller.getAttendanceMonthly();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 40,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.redAccent,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.yellow,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: appbarColor,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all<double>(6),
                        thumbVisibility: WidgetStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: _load
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Address == "Location"
                ? const Center(child: TodayWidgetSwimmer())
                : GetBuilder<AttendanceController>(
                    init: AttendanceController(),
                    builder: (controller) {
                      return controller.attendancLoad == true
                          ? const TodayWidgetSwimmer()
                          : SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  formattedTime,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Center(
                                                  child: Text(
                                                formattedDate,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          controller.unplaned.isTrue ? 10 : 0,
                                    ),
                                    controller.unplaned.isTrue
                                        ? Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: TextFormField(
                                                  controller: controller.from,
                                                  decoration:
                                                      const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(5),
                                                          border:
                                                              InputBorder.none,
                                                          hintText: "From"),
                                                ),
                                              )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: TextFormField(
                                                  controller: controller.to,
                                                  decoration:
                                                      const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(5),
                                                          border:
                                                              InputBorder.none,
                                                          hintText: "To"),
                                                ),
                                              )),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    controller.unplaned.isTrue
                                        ? Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: TextFormField(
                                              controller:
                                                  controller.visitPurpose,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(5),
                                                  border: InputBorder.none,
                                                  hintText: "Purpose"),
                                            ),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    controller.attendancLoad
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : controller.dataPresent.isFalse
                                            ? Container(
                                                alignment: Alignment.center,
                                                child: CheckInButton(
                                                    checkOut: false,
                                                    checkIn: true,
                                                    onPressed: () {
                                                      controller.markAttendance(
                                                          add: Address,
                                                          log: _currentPosition
                                                              .longitude
                                                              .toStringAsFixed(
                                                                  4),
                                                          lat: _currentPosition
                                                              .latitude
                                                              .toStringAsFixed(
                                                                  4),
                                                          attType: 'in',
                                                          img: image);
                                                    }),
                                              )
                                            : Container(
                                                alignment: Alignment.center,
                                                height: 200,
                                                child: CheckInButton(
                                                    checkOut: controller
                                                                .visitAttendanceModel!
                                                                .data!
                                                                .visitAttendance![
                                                                    0]
                                                                .checkOut ==
                                                            0
                                                        ? false
                                                        : true,
                                                    checkIn: controller
                                                                .visitAttendanceModel!
                                                                .data!
                                                                .visitAttendance![
                                                                    0]
                                                                .checkIn ==
                                                            1
                                                        ? false
                                                        : true,
                                                    onPressed: () {
                                                      controller
                                                                  .visitAttendanceModel!
                                                                  .data!
                                                                  .visitAttendance![
                                                                      0]
                                                                  .checkOut ==
                                                              1
                                                          ? constToast(
                                                              "Attendance Completed!")
                                                          : controller.markAttendance(
                                                              add: Address,
                                                              log: _currentPosition
                                                                  .longitude
                                                                  .toStringAsFixed(
                                                                      4),
                                                              lat: _currentPosition
                                                                  .latitude
                                                                  .toStringAsFixed(
                                                                      4),
                                                              attType: controller
                                                                          .visitAttendanceModel!
                                                                          .data!
                                                                          .visitAttendance![
                                                                              0]
                                                                          .presentTimeOut !=
                                                                      'null'
                                                                  ? 'out'
                                                                  : 'in',
                                                              img: image);
                                                    }),
                                              ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Longitude",
                                            style: TextStyle(
                                                color: darkColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text("Latitude  ",
                                            style: TextStyle(
                                                color: darkColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fitHeight,
                                                    image: AssetImage(
                                                      "assets/map.png",
                                                    ))),
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.blue,
                                                ),
                                                Text(
                                                    "   ${_currentPosition.longitude.toStringAsFixed(4)}",
                                                    style: const TextStyle(
                                                        color: textLightColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            )),
                                        Container(
                                            height: 50,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fitHeight,
                                                    image: AssetImage(
                                                      "assets/map.png",
                                                    ))),
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.blue,
                                                ),
                                                Text(
                                                    "   ${_currentPosition.latitude.toStringAsFixed(4)}",
                                                    style: const TextStyle(
                                                        color: textLightColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    controller.dataPresent.isTrue
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    _buildRow(
                                                        controller
                                                                    .visitAttendanceModel!
                                                                    .data!
                                                                    .visitAttendance![
                                                                        0]
                                                                    .presentTimeIn
                                                                    .toString() ==
                                                                "null"
                                                            ? '-:-'
                                                            : (convertTimestampToTime(controller
                                                                .visitAttendanceModel!
                                                                .data!
                                                                .visitAttendance![
                                                                    0]
                                                                .presentTimeIn
                                                                .toString())),
                                                        "Check-in"),
                                                    _buildRow(
                                                        controller
                                                                    .visitAttendanceModel!
                                                                    .data!
                                                                    .visitAttendance![
                                                                        0]
                                                                    .presentTimeOut
                                                                    .toString() ==
                                                                "null"
                                                            ? '-:-'
                                                            : (convertTimestampToTime(controller
                                                                .visitAttendanceModel!
                                                                .data!
                                                                .visitAttendance![
                                                                    0]
                                                                .presentTimeOut
                                                                .toString())),
                                                        "Check-out"),
                                                    _buildRow(
                                                        controller
                                                                        .visitAttendanceModel!
                                                                        .data!
                                                                        .visitAttendance![
                                                                            0]
                                                                        .presentTimeOut
                                                                        .toString() ==
                                                                    "null" ||
                                                                controller
                                                                        .visitAttendanceModel!
                                                                        .data!
                                                                        .visitAttendance![
                                                                            0]
                                                                        .presentTimeOut
                                                                        .toString() ==
                                                                    'null'
                                                            ? controller
                                                                        .visitAttendanceModel!
                                                                        .data!
                                                                        .visitAttendance![
                                                                            0]
                                                                        .presentTimeIn
                                                                        .toString() !=
                                                                    "null"
                                                                ? "process"
                                                                : '-:-'
                                                            : "Done",
                                                        "Status")
                                                  ]),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    _buildRow(
                                                        '-:-', "Check-in"),
                                                    _buildRow(
                                                        '-:-', "Check-out"),
                                                    _buildRow('-:-', "Status")
                                                  ]),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Today's Punch Logs",
                                                style: TextStyle(
                                                    color: darkColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                _punchBuild("Photo"),
                                                _punchBuild("Punch Time"),
                                                _punchBuild("Location")
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                controller.dataPresent.value
                                                    ? controller
                                                                .visitAttendanceModel!
                                                                .data!
                                                                .visitAttendance![
                                                                    0]
                                                                .checkOutAddressImage
                                                                .toString() !=
                                                            "null"
                                                        ? Image.network(
                                                            ImageURL +
                                                                controller
                                                                    .visitAttendanceModel!
                                                                    .data!
                                                                    .visitAttendance![
                                                                        0]
                                                                    .checkInAddressImage
                                                                    .toString(),
                                                            height: 100,
                                                          )
                                                        : SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child:
                                                                _capturedImage !=
                                                                        null
                                                                    ? InkWell(
                                                                        onTap:
                                                                            _openCamera,
                                                                        child: Image
                                                                            .file(
                                                                          _capturedImage!,
                                                                          height:
                                                                              50,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      )
                                                                    : IconButton(
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          color:
                                                                              Colors.red,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                        onPressed:
                                                                            _openCamera,
                                                                        iconSize:
                                                                            20,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                          )
                                                    : SizedBox(
                                                        height: 100,
                                                        width: 100,
                                                        child: _capturedImage !=
                                                                null
                                                            ? InkWell(
                                                                onTap:
                                                                    _openCamera,
                                                                child:
                                                                    Image.file(
                                                                  _capturedImage!,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            : IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 40,
                                                                ),
                                                                onPressed:
                                                                    _openCamera,
                                                                iconSize: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      ),
                                                controller.dataPresent.isTrue
                                                    ? SizedBox(
                                                        width: 100,
                                                        child: Text(
                                                          controller
                                                                      .visitAttendanceModel!
                                                                      .data!
                                                                      .visitAttendance![
                                                                          0]
                                                                      .presentTimeIn
                                                                      .toString() ==
                                                                  "null"
                                                              ? '-:-'
                                                              : controller
                                                                          .visitAttendanceModel!
                                                                          .data!
                                                                          .visitAttendance![
                                                                              0]
                                                                          .presentTimeOut
                                                                          .toString() ==
                                                                      "null"
                                                                  ? convertTimestampToTime(controller
                                                                      .visitAttendanceModel!
                                                                      .data!
                                                                      .visitAttendance![
                                                                          0]
                                                                      .presentTimeIn
                                                                      .toString())
                                                                  : convertTimestampToTime(controller
                                                                      .visitAttendanceModel!
                                                                      .data!
                                                                      .visitAttendance![
                                                                          0]
                                                                      .presentTimeOut
                                                                      .toString()),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ))
                                                    : const SizedBox(
                                                        width: 100,
                                                        child: Text(
                                                          '-:-',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                SizedBox(
                                                  width: 100,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        size: 40,
                                                        color: Colors.blue,
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              temp = !temp;
                                                            });
                                                          },
                                                          icon: !temp
                                                              ? const Icon(Icons
                                                                  .keyboard_arrow_down)
                                                              : const Icon(Icons
                                                                  .keyboard_arrow_up))
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
                                                    controller.dataPresent.value
                                                        ? controller
                                                                    .visitAttendanceModel!
                                                                    .data!
                                                                    .visitAttendance![
                                                                        0]
                                                                    .checkOutAddress
                                                                    .toString() !=
                                                                "null"
                                                            ? controller
                                                                .visitAttendanceModel!
                                                                .data!
                                                                .visitAttendance![
                                                                    0]
                                                                .checkOutAddress
                                                                .toString()
                                                            : Address
                                                        : Address,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ));
  }

  Widget _punchBuild(text) {
    return SizedBox(
        width: 100,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }

  Widget _buildRow(text, text2) {
    return Column(
      children: [
        const Icon(
          Icons.watch_later_outlined,
          size: 25,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          text2,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
