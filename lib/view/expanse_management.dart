import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/utils/colors.dart';

class ExpanseManagementView extends StatefulWidget {
  const ExpanseManagementView({super.key});

  @override
  State<ExpanseManagementView> createState() => _ExpanseManagementViewState();
}

class _ExpanseManagementViewState extends State<ExpanseManagementView> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
          "Expense Management",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: secondaryColor),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: w,
                child: Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Expanse Form:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("03 Jan 2024"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("From Location"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("To Location"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("visit purpose"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("Conventience mode"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("Distanse (in km)"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("Rate Per km"),
                        const SizedBox(
                          height: 20,
                        ),
                        commonTextField("Amount (in Rs)"),
                        const SizedBox(
                          height: 50,
                        ),
                        MaterialButton(
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {},
                          color: const Color.fromARGB(255, 14, 124, 213),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget commonTextField(text) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            border: InputBorder.none,
            hintText: text),
      ),
    );
  }
}
