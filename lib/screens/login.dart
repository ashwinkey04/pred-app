import 'package:flutter/material.dart';
import 'package:pred/screens/verify_phone.dart';
import 'package:pred/utils/numeric_pad.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phonenumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: upButtonWidget(context),
        title: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SizedBox(
                    height: 130,
                    child: Image.asset("assets/imgs/login.png"),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        width: 260,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              phonenumber.isNotEmpty
                                  ? phonenumber
                                  : "Enter your phone",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (phonenumber.length == 10) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyPhone(
                                            phonenumber: '+91 $phonenumber',
                                          )));
                            } else {
                              Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "Try again",
                                  desc: "Enter Valid Phone Number",
                                  style: const AlertStyle(
                                    titleStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  buttons: [
                                    DialogButton(
                                      onPressed: () => Navigator.pop(context),
                                      color: primaryColor,
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ]).show();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: primaryColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                              // child: Text(
                              //   "Continue",
                              //   style: TextStyle(
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              // ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              NumericPad(
                onNumberSelected: (value) {
                  if (value != -1 && phonenumber.length < 10) {
                    phonenumber = phonenumber + value.toString();
                    setState(() {});
                  } else if (value == -1) {
                    phonenumber =
                        phonenumber.substring(0, phonenumber.length - 1);
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
