// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/Provider/Api_provider.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/view/expanse_management.dart';

import '../model/previous_model.dart';

class ShowPreviousClaimsView extends StatefulWidget {
  String? id;
  ShowPreviousClaimsView({super.key, required this.id});

  @override
  State<ShowPreviousClaimsView> createState() => _ShowPreviousClaimsViewState();
}

class _ShowPreviousClaimsViewState extends State<ShowPreviousClaimsView> {
  @override
  void initState() {
    // TODO: implement initState
    getClaims(id: widget.id);
    print(widget.id);
    super.initState();
  }

  bool loding = true;
  ClaimsModel? claimsModel;
  List<bool>? visibleList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Previous Claims',
          style: TextStyle(color: secondaryColor),
        ),
      ),
      body: loding
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: claimsModel?.dataCount,
                itemBuilder: (context, index) {
                  final data = claimsModel?.data?.claimDetails?[index];

                  String? date = '';
                  String? time = '';

                  if (data?.createdAt.toString() != "null") {
                    String dateTimeString = data?.createdAt.toString() ?? '';

                    // Parse the string into a DateTime object
                    DateTime dateTime = DateTime.parse(dateTimeString);

                    // Extract date and time components
                    date =
                        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                    time =
                        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}.${dateTime.millisecond}";
                  }
                  List<Color> colors = generateLightColors();
                  return Card(
                    color: !visibleList![index] ? Colors.red : colors[index],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date: $date",
                                style: TextStyle(
                                    color: !visibleList![index]
                                        ? Colors.white
                                        : darkColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibleList![index] = !visibleList![index];
                                  });
                                },
                                icon: Icon(visibleList![index]
                                    ? Icons.keyboard_arrow_down_sharp
                                    : Icons.keyboard_arrow_up),
                                color: !visibleList![index]
                                    ? Colors.white
                                    : darkColor,
                              )
                            ],
                          ),
                          Visibility(
                            visible: visibleList![index],
                            child: Column(
                              children: [
                                dd("VisitPurpose",
                                    data?.visitPurpose.toString()),
                                dd("From", data?.visitFrom.toString()),
                                dd("To", data?.visitTo.toString()),
                                dd("ExpDesc", data?.expModeDesc.toString()),
                                dd("ConvModeDesc",
                                    data?.convModeDesc.toString()),
                                dd("Rate", data?.rate.toString()),
                                // dd("Distance",
                                //     data..toString()),
                                dd("Amount", data?.amount.toString()),

                                data?.expenseDoc.toString() == 'null'
                                    ? const SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                            child: Text("▶️"),
                                          ),
                                          const SizedBox(
                                            width: 150,
                                            child: Text(
                                              "Doc : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return FullPageImageDialog(
                                                      imageUrl:
                                                          "$ImageURL${data?.expenseDoc.toString()}");
                                                },
                                              );
                                            },
                                            child: const SizedBox(
                                                width: 150,
                                                child: Text(
                                                  "view ",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 17,
                                                      color: appbarColor),
                                                )),
                                          ),
                                        ],
                                      ),
                                dd("Status", data?.description.toString()),
                                dd("Submit", time),
                                const SizedBox(
                                  height: 10,
                                ),
                                data?.createdAt.toString() == "null"
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Please fill Your Claim",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ExpanseManagementView(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                        Icons.arrow_forward),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget dd(text, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
          child: Text("▶️"),
        ),
        SizedBox(
          width: 150,
          child: Text(
            "$text : ",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
            width: 150,
            child: Text(
              text2 == "null" ? '-:-' : text2,
              style: const TextStyle(fontSize: 17, color: appbarColor),
            )),
      ],
    );
  }

  Color getColorByIndex(int index) {
    // Replace this logic with your own color assignment
    Color baseColor = Colors.red; // Change this to your base color

    // Calculate the percentage based on the index (adjust the factor as needed)
    double percentage = (index + 1) * 10.0; // For example, 10% increments

    // Create a color with the adjusted opacity
    Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

    return adjustedColor;
  }

  List<Color> generateLightColors() {
    List<Color> lightColors = [];

    // Add all light shades of primary colors
    for (MaterialColor color in Colors.primaries) {
      lightColors.add(color.shade300);
      // lightColors.add(color.shade900);
      // lightColors.add(color.shade100);
      // lightColors.add(color.shade500);
    }

    return lightColors;
  }

  Future getClaims({String? id}) async {
    setState(() {
      loding = false;
    });
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "$BASEURL/v1/application/expense/get-expense?VisitSummaryId=$id");
      print(jsonDecode(res));
      setState(() {
        loding = true;
        claimsModel = claimsModelFromJson(res);
        visibleList =
            List.generate(claimsModel?.dataCount ?? 0, (index) => false);
      });

      if (kDebugMode) {
        print(res);
      }
    } catch (e) {
      if (kDebugMode) {
        setState(() {
          loding = true;
        });
        print(e.toString());
      }
    }
  }
}

class FullPageImageDialog extends StatelessWidget {
  final String imageUrl;

  const FullPageImageDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: double.infinity, maxHeight: 400),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
