import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pred/screens/home.dart';
import 'package:pred/utils/numeric_pad.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants.dart';

class VerifyPhone extends StatefulWidget {
  final String phonenumber;
  const VerifyPhone({Key? key, required this.phonenumber}) : super(key: key);
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String? _verificationCode;

  bool isLoading = true;
  bool codeSent = false;
  String otpText = "Sending OTP to\n";
  int time = 60;
  bool resendOTPButton = true;

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  _verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phonenumber.replaceAll(' ', ''),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
          Alert(
            context: context,
            type: AlertType.error,
            title: "Failed",
            desc: "Sending OTP failed",
          ).show();
          Navigator.of(context).pop();
        },
        codeSent: (String verficationID, int? resendToken) {
          _verificationCode = verficationID;
          otpText = 'Code is sent to\n';
          isLoading = false;
          codeSent = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 15),
      );
    } catch (e) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: "OTP Invalid",
      ).show();
    }
  }

  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: upButtonWidget(context),
        title: const Text(
          "Verify phone",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    otpText + widget.phonenumber,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNumberr(otp, 0),
                    buildNumberr(otp, 1),
                    buildNumberr(otp, 2),
                    buildNumberr(otp, 3),
                    buildNumberr(otp, 4),
                    buildNumberr(otp, 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (codeSent) {
                                // Verify
                                if (otp.length == 6) {
                                  setState(() {
                                    isLoading = true;
                                    otpText = 'Verifying\n';
                                  });
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithCredential(
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    _verificationCode!,
                                                smsCode: otp))
                                        .then((value) async {
                                      if (value.user != null) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const Home(),
                                            ),
                                            (route) => false);
                                      }
                                    });
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    FocusScope.of(context).unfocus();

                                    Alert(
                                      context: context,
                                      type: AlertType.error,
                                      title: "Failed",
                                      desc: 'OTP Verification failed.',
                                    ).show();
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            child: isLoading
                                ? Shimmer.fromColors(
                                    baseColor: gradientList[0],
                                    highlightColor: gradientList[2],
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: codeSent
                                            ? primaryColor
                                            : Colors.grey[500],
                                        // gradient: const LinearGradient(
                                        //   begin: Alignment.topLeft,
                                        //   end: Alignment.bottomRight,
                                        //   colors: gradientList,
                                        // )
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Verify Code",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: codeSent
                                          ? primaryColor
                                          : Colors.grey[500],
                                      // gradient: const LinearGradient(
                                      //   begin: Alignment.topLeft,
                                      //   end: Alignment.bottomRight,
                                      //   colors: gradientList,
                                      // )
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Verify Code",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: NumericPad(onNumberSelected: (value) {
                    if (value >= 0 && otp.length < 6) {
                      otp += value.toString();
                    } else if (value == -1 && otp.isNotEmpty) {
                      otp = otp.substring(0, otp.length - 1);
                    }
                    setState(() {});
                  }))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberr(String number, int position) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 0),
                  blurRadius: 8,
                )
              ]),
          child: Center(
            child: Text(
              number.length >= (position + 1) ? number[position] : ' ',
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 106, 106, 106)),
            ),
          ),
        ),
      ),
    );
  }
}
