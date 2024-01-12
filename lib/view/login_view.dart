import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/login_controller.dart';


class LoginViewPage extends StatefulWidget {
  const LoginViewPage({super.key});

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => AuthController(),
    );
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/bg.png",
                  ))),
          child: GetBuilder<AuthController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 100, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/applogo.png",
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Welcome back",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey)),
                                child: TextFormField(
                                  controller: controller.phoneController,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: "Enter Mobile Number"),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const HomePageView(),
                                  //     ));
                                  controller.loginUser();
                                },
                                color: const Color.fromARGB(255, 14, 124, 213),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: controller.isLoading.value
                                    ? Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Center(child: CircularProgressIndicator(color: Colors.white,)),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
