// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/Provider/Api_provider.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/local_data.dart';

import '../model/previous_model.dart';

class ShowPreviousClaimsView extends StatefulWidget {
  int id;
  ShowPreviousClaimsView({super.key, required this.id});

  @override
  State<ShowPreviousClaimsView> createState() => _ShowPreviousClaimsViewState();
}

class _ShowPreviousClaimsViewState extends State<ShowPreviousClaimsView> {
  @override
  void initState() {
    // TODO: implement initState
    getClaims(id: widget.id);
    super.initState();
  }

  bool loding = true;
  ClaimsModel? claimsModel;

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
      body: loding? Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: claimsModel!.dataCount,
          itemBuilder: (context, index) {
            final data = claimsModel!.data!.claimDetails![index];
            print(data.submittedOn);
            String? date = '';
            String? time = '';
            if (data.submittedOn.toString() != "null") {
              String dateTimeString = data.submittedOn.toString();

              // Parse the string into a DateTime object
              DateTime dateTime = DateTime.parse(dateTimeString);

              // Extract date and time components
              date =
                  "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
              time =
                  "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}.${dateTime.millisecond}";
            }
            return Card(
              color: getColorByIndex(index),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Text(
                      "   Date: ${date}",
                      style: TextStyle(color: darkColor, fontSize: 20),
                    ),
                    dd("VisitPurpose", data.visitPurpose.toString()),
                    dd("From", data.visitFrom.toString()),
                    dd("To", data.visitTo.toString()),
                    dd("ExpDesc", data.expModeDesc.toString()),
                    dd("ConvModeDesc", data.convModeDesc.toString()),
                    dd("Rate", data.rate.toString()),
                    dd("Distance", data.locationDistance.toString()),
                    dd("Amount", data.amount.toString()),
                    dd("Remarks", data.remarks.toString()),
                    dd("Description", data.description.toString()),
                    dd("Time", time),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ):Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget dd(text, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "${text} : ",
            style: const TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
            width: 150,
            child: Text(
              text2 == "null" ? '-:-' : text2,
              style: TextStyle(fontSize: 16),
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
    Color adjustedColor = baseColor.withOpacity(percentage / 1000.0);

    return adjustedColor;
  }

  Future getClaims({int? id}) async {
    setState(() {
      loding = false;
    });
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: "Claim/GetClaim?ExpenseId=$id");
      // print(jsonDecode(res));
      setState(() {
        loding = true;
        claimsModel = claimsModelFromJson(res);
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
