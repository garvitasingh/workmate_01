import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/visit_controller.dart';
import 'package:workmate_01/utils/colors.dart';

class VisitScreen extends StatelessWidget {
  VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VisitController controller = Get.put(VisitController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: secondaryColor,
            )),
        backgroundColor: darkColor,
        title: const Text(
          "Visits",
          style: TextStyle(color: secondaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: secondaryColor,
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Obx(() => controller.isLoading.isFalse
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.visitData.length,
                      itemBuilder: (context, index) {
                        print(controller.visitData[index]['VisitTo']);
                        var data = controller.visitData[index];
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: getColorByIndex(index),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              dd("VisitPurpose", data['VisitPurpose']),
                              dd("VisitDate", data['VisitDate']),
                              dd("VisitFrom", data['VisitFrom']),
                              dd("VisitTo", data['VisitTo']),
                              dd("VisitRemarks",
                                  data['VisitRemarks'].toString()),
                              data['FillRemarks'] == 0
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          //height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          width: 100,
                                          child: TextFormField(
                                            controller: controller.remarkCo,
                                            maxLines: 12,
                                            minLines: 1,
                                            //cursorHeight: 12,
                                            decoration: const InputDecoration(
                                                hintText: "Feedback",
                                                border: InputBorder.none),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 35,
                                            color: darkColor,
                                            onPressed: () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.question,
                                                animType: AnimType.rightSlide,
                                                title: 'Feedback Confirmation',
                                                desc: 'Are you sure?',
                                                btnCancelOnPress: () {
                                                  Get.back();
                                                },
                                                btnOkOnPress: () async {
                                                  controller.updateFeedback(
                                                      id: data['ExpenseId']);
                                                },
                                              ).show();
                                            },
                                            child: const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            )),
    );
  }

  Widget dd(text, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 150,
          child: Text(
            "${text} : ",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Container(width: 150, child: Text(text2)),
      ],
    );
  }

  Color getColorByIndex(int index) {
    // Replace this logic with your own color assignment
    Color baseColor = Colors.red; // Change this to your base color

    // Calculate the percentage based on the index (adjust the factor as needed)
    double percentage = (index + 1) * 30.0; // For example, 10% increments

    // Create a color with the adjusted opacity
    Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

    return adjustedColor;
  }

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.brown,
    Colors.teal,
    Colors.pink,
  ];
}
