import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:workmate_01/controller/leave_controller.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/local_data.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  LeaveController controller = Get.put(LeaveController());
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  DateTime dateTime = DateTime.parse("2024-01-15 00:00:00.000");
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  Map<String, double> dataMap = {
    "Total Leave": 5,
    "SL": 3,
    "EL": 2,
    "CL": 2,
    "Approve Leave": 5,
    "Pending Leave": 3,
    "Rejected Leave": 2,
    "Pending": 2,
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var h = MediaQuery.of(context).size.height;
    // var w = MediaQuery.of(context).size.width;
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
          backgroundColor: darkColor,
          title: const Text(
            "Leave",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: secondaryColor),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_rounded))
          ],
        ),
        body: Obx(() => Center(
              child: controller.isLoading.isTrue
                  ? CircularProgressIndicator.adaptive()
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Leave Count Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            PieChart(
                              dataMap: {
                                "Total Leave": double.parse(controller
                                    .leaveData!.data!.visitPlan![0].totalLeave
                                    .toString()),
                                "SL": double.parse(controller
                                    .leaveData!.data!.visitPlan![0].totalSl
                                    .toString()),
                                "EL": double.parse(controller
                                    .leaveData!.data!.visitPlan![0].totalEl
                                    .toString()),
                                "CL": double.parse(controller
                                    .leaveData!.data!.visitPlan![0].totalCl
                                    .toString()),
                                "Approve Leave": double.parse(controller
                                    .leaveData!
                                    .data!
                                    .visitPlan![0]
                                    .totalApproved
                                    .toString()),
                                "Pending Leave": double.parse(controller
                                    .leaveData!.data!.visitPlan![0].pending
                                    .toString()),
                                "Rejected Leave": double.parse(controller
                                    .leaveData!.data!.visitPlan![0].rejected
                                    .toString()),
                              },
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 4,
                              colorList: colorList,
                              initialAngleInDegree: 0,

                              chartType: ChartType.ring,
                              ringStrokeWidth: 32,
                              centerText: "Leave",
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.rectangle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: false,
                                decimalPlaces: 1,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: true,
                              ),
                              // gradientList: ---To add gradient colors---
                              // emptyColorGradient: ---Empty Color gradient---
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Apply Leave Form",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Obx(() => controller.isLoading.isFalse
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                // FormBuilderTextField(
                                                //   readOnly: true,
                                                //   controller:
                                                //       controller.employeeId,
                                                //   name: 'EMPCode',
                                                //   decoration: InputDecoration(
                                                //       border:
                                                //           OutlineInputBorder(
                                                //         borderRadius:
                                                //             BorderRadius
                                                //                 .circular(
                                                //                     10.0),
                                                //         borderSide:
                                                //             const BorderSide(
                                                //           color: Colors.blue,
                                                //           width: 1.0,
                                                //         ),
                                                //       ),
                                                //       hintText: LocalData()
                                                //           .getEmpCode()
                                                //           .toString(),
                                                //       labelText:
                                                //           'Employee Code'),
                                                //   validator: (value) {
                                                //     if (value == null) {
                                                //       return 'required';
                                                //     }
                                                //     // You can add more custom validation logic here if needed
                                                //     return null;
                                                //   },
                                                // ),

                                                FormBuilderDropdown(
                                                  onChanged: (value) {
                                                    if (value == '1') {
                                                      controller.leaveType
                                                          .text = "CL";
                                                    }
                                                    if (value == '2') {
                                                      controller.leaveType
                                                          .text = "SL";
                                                    } else {
                                                      controller.leaveType
                                                          .text = "EL";
                                                    }
                                                    controller.update();
                                                  },
                                                  name: 'LeaveType',
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.blue,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      labelText: 'Leave Type'),
                                                  items: ['1', '2', '3']
                                                      .map((type) =>
                                                          DropdownMenuItem(
                                                            value: type,
                                                            child: Text(type ==
                                                                    '1'
                                                                ? 'CL'
                                                                : type == '2'
                                                                    ? 'SL'
                                                                    : 'EL'),
                                                          ))
                                                      .toList(),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Leave Type is required';
                                                    }
                                                    // You can add more custom validation logic here if needed
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                FormBuilderDateTimePicker(
                                                  firstDate: DateTime.now(),
                                                  name: 'FromDate',
                                                  inputType: InputType.date,
                                                  format:
                                                      DateFormat('yyyy-MM-dd'),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.blue,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    labelText: 'From Date',
                                                  ),
                                                  initialValue: fromDate,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'From Date is required';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value) {
                                                    if (value != null &&
                                                        value is DateTime) {
                                                      fromDate = value;
                                                      if (kDebugMode) {
                                                        print(DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(fromDate));
                                                      }
                                                    }
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                FormBuilderDateTimePicker(
                                                  name: 'ToDate',
                                                  inputType: InputType.date,
                                                  format:
                                                      DateFormat('yyyy-MM-dd'),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.blue,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    labelText: 'To Date',
                                                  ),
                                                  initialValue: toDate,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'To Date is required';
                                                    }

                                                    if (value is DateTime &&
                                                        value.isBefore(
                                                            fromDate)) {
                                                      return 'To Date must be after From Date';
                                                    }

                                                    return null;
                                                  },
                                                  firstDate: fromDate,
                                                  onChanged: (value) {
                                                    if (value != null &&
                                                        value is DateTime) {
                                                      toDate = value;
                                                      if (kDebugMode) {
                                                        print(DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(toDate));
                                                      }
                                                    }
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                FormBuilderTextField(
                                                  name: 'Remarks',
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.blue,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      labelText: 'Remarks'),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Remarks is required';
                                                    }
                                                    // You can add more custom validation logic here if needed
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(height: 20),
                                                MaterialButton(
                                                  minWidth: 200,
                                                  height: 50,
                                                  color: darkColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .saveAndValidate()) {
                                                      // Form data is valid, process it here
                                                      var formData = _formKey
                                                          .currentState!.value;
                                                      controller.applyLeave(
                                                          fomData: formData);
                                                      if (kDebugMode) {
                                                        print(formData);
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: secondaryColor,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()))
                          ]),
                    ),
            )));
  }

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
    const Color(0xff00cec9), // Add color
    const Color(0xffff7675), // Add color
    const Color(0xffa29bfe), // Add color
    const Color(0xff55efc4), // Add color
  ];

  Color getColorByIndex(int index) {
    // Replace this logic with your own color assignment
    Color baseColor = Colors.redAccent; // Change this to your base color

    // Calculate the percentage based on the index (adjust the factor as needed)
    double percentage = (index + 1) * 10.0; // For example, 10% increments

    // Create a color with the adjusted opacity
    Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

    return adjustedColor;
  }

  Widget _leaveCard(String title, int? count, color) {
    return InkWell(
      onTap: () {
        //
      },
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            count == null
                ? const Text(
                    "#0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: darkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                : Text(
                    "#$count",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: darkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
          ],
        ),
      ),
    );
  }
}
