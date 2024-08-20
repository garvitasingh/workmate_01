import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/controller/expense_controller.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/view/previous_claims.dart';

class ExpanseManagementView extends StatefulWidget {
  const ExpanseManagementView({super.key});

  @override
  State<ExpanseManagementView> createState() => _ExpanseManagementViewState();
}

class _ExpanseManagementViewState extends State<ExpanseManagementView> {
  //ExpenseController controller = Get.put(ExpenseController());
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Future.delayed(Duration.zero, () {
                Get.back();
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: secondaryColor,
            ),
          ),
          centerTitle: false,
          backgroundColor: darkColor,
          title: const Text(
            "Expense Management",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: secondaryColor,
            ),
          ),
          actions: [
            GetBuilder<ExpenseController>(
              init: ExpenseController(),
              builder: (controller) {
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
                        controller.getVisitLocation();
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
        body: GetBuilder<ExpenseController>(
          init: ExpenseController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FormBuilder(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                FormBuilderDateTimePicker(
                                  name: 'Date',
                                  inputType: InputType.date,
                                  format: DateFormat('yyyy-MM-dd'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                    labelText: 'Date',
                                  ),
                                  initialValue: fromDate,
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 1)),
                                  lastDate: DateTime.now(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Date is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value != null) {
                                      fromDate = value;
                                      controller.dateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(fromDate);
                                      if (kDebugMode) {
                                        print(DateFormat('yyyy-MM-dd')
                                            .format(fromDate));
                                      }
                                    }
                                  },
                                ),
                                // : FormBuilderTextField(
                                //     readOnly: true,
                                //     controller: controller.dateController,
                                //     name: 'Date',
                                //     decoration: InputDecoration(
                                //       labelText: 'Date',
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10.0),
                                //         borderSide: const BorderSide(
                                //           color: Colors.blue,
                                //           width: 1.0,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                const SizedBox(height: 10),
                                FormBuilderTextField(
                                  readOnly: controller.unplaned.isFalse
                                      ? true
                                      : false,
                                  controller: controller.fromdistanse,
                                  name: 'From',
                                  decoration: InputDecoration(
                                    labelText: 'From',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                FormBuilderTextField(
                                  readOnly: controller.unplaned.isFalse
                                      ? true
                                      : false,
                                  controller: controller.todistanse,
                                  name: 'To',
                                  decoration: InputDecoration(
                                    labelText: 'To',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                ),
                                // const SizedBox(height: 10),
                                // FormBuilderTextField(
                                //     controller:
                                //         controller.visitPurposeController,
                                //     name: 'Purpose',
                                //     decoration: InputDecoration(
                                //       labelText: 'Purpose',
                                //       border: OutlineInputBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(10.0),
                                //         borderSide: const BorderSide(
                                //           color: Colors.blue,
                                //           width: 1.0,
                                //         ),
                                //       ),
                                //     ),
                                //     // validator: (value) {
                                //     //   if (value == '') {
                                //     //     return 'required';
                                //     //   }
                                //     //   return null;
                                //     // },
                                //     autofocus: false),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => FormBuilderDropdown(
                                    onChanged: (value) {
                                      controller.seleExpLocation.value = value!;

                                      controller.expIdGet();
                                      controller.update();
                                    },
                                    name: controller.expModeIdText.value,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                            )),
                                        labelText: 'Exp Mode ID'),
                                    items: controller.convExpMode
                                        .map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                controller.seleExpLocation.value == 'Vehicle'
                                    ? Column(
                                        children: [
                                          FormBuilderDropdown(
                                            onChanged: (value) {
                                              controller.convModeString = value;
                                              controller.calculateAmount();
                                              double rate = double.tryParse(
                                                      controller.rateController
                                                          .text) ??
                                                  0.0;
                                              double distance = double.tryParse(
                                                      controller
                                                          .locationDistanceController
                                                          .text) ??
                                                  0.0;

                                              double amount = rate * distance;

                                              controller.amountController.text =
                                                  amount.toString();
                                              controller.update();
                                            },
                                            name: 'ConvModeId',
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.blue,
                                                      width: 1.0,
                                                    )),
                                                labelText: 'Conv Mode ID'),
                                            items: controller.convMode
                                                .map<DropdownMenuItem<String>>(
                                              (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                          const SizedBox(height: 10),
                                          FormBuilderTextField(
                                            readOnly: true,
                                            controller:
                                                controller.rateController,
                                            name: 'Rate per (km)',
                                            decoration: InputDecoration(
                                              labelText: 'Rate',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            // validator: (value) {
                                            //   if (value == '') {
                                            //     return 'required';
                                            //   }
                                            //   return null;
                                            // },
                                          ),
                                          const SizedBox(height: 10),
                                          FormBuilderTextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                double rate = double.tryParse(
                                                        controller
                                                            .rateController
                                                            .text) ??
                                                    0.0;
                                                double distance =
                                                    double.tryParse(controller
                                                            .locationDistanceController
                                                            .text) ??
                                                        0.0;

                                                double amount = rate * distance;

                                                controller.amountController
                                                    .text = amount.toString();
                                                controller.update();
                                                if (kDebugMode) {
                                                  print(amount);
                                                }
                                              },
                                              controller: controller
                                                  .locationDistanceController,
                                              name: 'Dis in (Km)',
                                              decoration: InputDecoration(
                                                labelText: 'Distance',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.blue,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              // validator: (value) {
                                              //   if (value == '') {
                                              //     return 'required';
                                              //   }
                                              //   return null;
                                              // },
                                              autofocus: false),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                FormBuilderTextField(
                                  readOnly: controller.seleExpLocation.value ==
                                          'Vehicle'
                                      ? true
                                      : false,
                                  controller: controller.amountController,
                                  name: 'Amount in (Rs)',
                                  decoration: InputDecoration(
                                    labelText: 'Amount',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == '') {
                                  //     return 'required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(height: 10),
                                FormBuilderTextField(
                                    controller: controller.remarksController,
                                    name: 'Remarks',
                                    decoration: InputDecoration(
                                      labelText: 'Remarks',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    // validator: (value) {
                                    //   if (value == '') {
                                    //     return 'required';
                                    //   }
                                    //   return null;
                                    // },
                                    autofocus: false),
                                const SizedBox(height: 10),
                                const Row(
                                  children: [
                                    Text(
                                      "Attachment",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: darkColor),
                                    ),
                                  ],
                                ),
                                GetBuilder<ExpenseController>(
                                  builder: (contrr) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        width: w,
                                        child: contrr.capturedImage != null
                                            ? InkWell(
                                                onTap: () {
                                                  controller.openSheet(context);
                                                },
                                                child: Image.file(
                                                  contrr.capturedImage!,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : IconButton(
                                                icon: const Icon(
                                                  Icons.file_copy,
                                                  color: Colors.red,
                                                  size: 40,
                                                ),
                                                onPressed: () {
                                                  controller.openSheet(context);
                                                },
                                                iconSize: 20,
                                                color: Colors.white,
                                              ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                MaterialButton(
                                    minWidth: 200,
                                    height: 50,
                                    color: darkColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () {
                                      if (_formKey.currentState!
                                          .saveAndValidate()) {
                                        // Form data is valid, process it here
                                        if (controller.seleExpLocation.value ==
                                            'Vehicle') {
                                          if (controller.visitPurposeController
                                              .text.isNotEmpty) {
                                            constToast("Purpose Required!");
                                          } else if (controller
                                              .locationDistanceController
                                              .text
                                              .isEmpty) {
                                            constToast("Distance Required!");
                                          } else if (controller
                                              .remarksController.text.isEmpty) {
                                            constToast("Remarks Required!");
                                          } else {
                                            controller.addClaim();
                                          }
                                        } else if (controller
                                            .amountController.text.isEmpty) {
                                          constToast("Amount Required!");
                                        } else {
                                          controller.addClaim();
                                        }
                                      }
                                    },
                                    child: Obx(
                                      () => controller.isSubmit.isTrue
                                          ? const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 20),
                                            )
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(ShowPreviousClaimsView(
                                          id: controller.expenseId!,
                                        ));
                                      },
                                      child: const Text(
                                        "Previous Claims",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.blue,
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
