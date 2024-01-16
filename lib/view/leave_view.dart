import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
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
              fontSize: 20, fontWeight: FontWeight.w600, color: secondaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Apply Leave Form",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.isLoading.isFalse
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  readOnly: true,
                                  controller: controller.employeeId,
                                  name: 'EMPCode',
                                  decoration: InputDecoration(
                                      hintText:
                                          LocalData().getEmpCode().toString(),
                                      labelText: 'Employee Code'),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'required';
                                    }
                                    // You can add more custom validation logic here if needed
                                    return null;
                                  },
                                ),
                                FormBuilderDropdown(
                                  onChanged: (value) {
                                    if (value == '1') {
                                      controller.leaveType.text = "CL";
                                    }
                                    if (value == '2') {
                                      controller.leaveType.text = "SL";
                                    } else {
                                      controller.leaveType.text = "EL";
                                    }
                                    controller.update();
                                  },
                                  name: 'LeaveType',
                                  decoration: const InputDecoration(
                                      labelText: 'Leave Type'),
                                  items: ['1', '2', '3']
                                      .map((type) => DropdownMenuItem(
                                            value: type,
                                            child: Text(type == '1'
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
                                FormBuilderDateTimePicker(
                                  name: 'FromDate',
                                  inputType: InputType.date,
                                  format: DateFormat('yyyy-MM-dd'),
                                  decoration: const InputDecoration(
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
                                    if (value != null && value is DateTime) {
                                      fromDate = value;
                                      print(DateFormat('yyyy-MM-dd')
                                          .format(fromDate));
                                    }
                                  },
                                ),
                                FormBuilderDateTimePicker(
                                  name: 'ToDate',
                                  inputType: InputType.date,
                                  format: DateFormat('yyyy-MM-dd'),
                                  decoration: const InputDecoration(
                                    labelText: 'To Date',
                                  ),
                                  initialValue: toDate,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'To Date is required';
                                    }

                                    if (value is DateTime &&
                                        value.isBefore(fromDate)) {
                                      return 'To Date must be after From Date';
                                    }

                                    return null;
                                  },
                                  firstDate: fromDate,
                                  onChanged: (value) {
                                    if (value != null && value is DateTime) {
                                      toDate = value;
                                      print(DateFormat('yyyy-MM-dd')
                                          .format(toDate));
                                    }
                                  },
                                ),
                                FormBuilderTextField(
                                  name: 'Remarks',
                                  decoration: const InputDecoration(
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
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      // Form data is valid, process it here
                                      var formData =
                                          _formKey.currentState!.value;
                                      controller.applyLeave(fomData: formData);
                                      print(formData);
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: secondaryColor, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                      GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 80),
                        children: [
                          _leaveCard(
                              "Total Leave",
                              controller
                                  .leaveData!.data.visitPlan[0].totalLeave,
                              getColorByIndex(0)),
                          _leaveCard(
                              "SL",
                              controller.leaveData!.data.visitPlan[0].totalSl,
                              getColorByIndex(1)),
                          _leaveCard(
                              "EL",
                              controller.leaveData!.data.visitPlan[0].totalEl,
                              getColorByIndex(3)),
                          _leaveCard(
                              "CL",
                              controller.leaveData!.data.visitPlan[0].totalCl,
                              getColorByIndex(4)),
                          _leaveCard(
                              "Approve Leave",
                              controller.leaveData!.data.visitPlan[0].approved,
                              getColorByIndex(5)),
                          _leaveCard(
                              "Pending Leave",
                              controller.leaveData!.data.visitPlan[0].pending,
                              getColorByIndex(6)),
                          _leaveCard(
                              "Rejected Leave",
                              controller.leaveData!.data.visitPlan[0].rejected,
                              getColorByIndex(7)),
                          _leaveCard(
                              "Pending",
                              controller.leaveData!.data.visitPlan[0].pending,
                              getColorByIndex(8))
                        ],
                      ),
                      SizedBox(height: 20,)
                      // Card(
                      //   margin: EdgeInsets.all(16.0),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(16.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Employee ID: ${controller.leaveData!.data.visitPlan[0].employeeId}',
                      //           style: TextStyle(
                      //               fontSize: 18, fontWeight: FontWeight.bold),
                      //         ),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'EMP Code: ${controller.leaveData!.data.visitPlan[0].empCode}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Total Leave: ${controller.leaveData!.data.visitPlan[0].totalLeave}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Total Approved: ${controller.leaveData!.data.visitPlan[0].totalApproved}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Total Balance: ${controller.leaveData!.data.visitPlan[0].totalBalance}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Total CL: ${controller.leaveData!.data.visitPlan[0].totalCl}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Total SL: ${controller.leaveData!.data.visitPlan[0].totalSl}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Total EL: ${controller.leaveData!.data.visitPlan[0].totalEl}'),
                      //         SizedBox(height: 16.0),
                      //         Text(
                      //             'Approved CL: ${controller.leaveData!.data.visitPlan[0].approvedCl}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Approved SL: ${controller.leaveData!.data.visitPlan[0].approvedSl}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Approved EL: ${controller.leaveData!.data.visitPlan[0].approvedEl}'),
                      //         SizedBox(height: 16.0),
                      //         Text(
                      //             'Balance CL: ${controller.leaveData!.data.visitPlan[0].balanceCl}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Balance SL: ${controller.leaveData!.data.visitPlan[0].balanceSl}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Balance EL: ${controller.leaveData!.data.visitPlan[0].balanceEl}'),
                      //         SizedBox(height: 16.0),
                      //         Text(
                      //             'Pending: ${controller.leaveData!.data.visitPlan[0].pending}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Approved: ${controller.leaveData!.data.visitPlan[0].approved}'),
                      //         SizedBox(height: 8.0),
                      //         Text(
                      //             'Rejected: ${controller.leaveData!.data.visitPlan[0].rejected}'),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  )
                : const Center(child: CircularProgressIndicator()))
          ]),
        ),
      ),
    );
  }

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
            Text(
              "#" + count.toString() ?? "0",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: darkColor, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
