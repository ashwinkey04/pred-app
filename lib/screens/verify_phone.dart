import 'package:flutter/material.dart';
import 'package:pred/utils/numeric_pad.dart';

import '../utils/constants.dart';

class VerifyPhone extends StatefulWidget {
  final String phonenumber;
  const VerifyPhone({Key? key, required this.phonenumber}) : super(key: key);
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String num = '';
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
                    "Code is sent to " + widget.phonenumber,
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
                    buildNumberr(num, 0),
                    buildNumberr(num, 1),
                    buildNumberr(num, 2),
                    buildNumberr(num, 3),
                    buildNumberr(num, 4),
                    buildNumberr(num, 5),
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
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: primaryColor,
                                // gradient: const LinearGradient(
                                //   begin: Alignment.topLeft,
                                //   end: Alignment.bottomRight,
                                //   colors: gradientList,
                                // )
                              ),
                              child: const Center(
                                child: Text(
                                  "Verify and create account",
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
                    if (value >= 0) {
                      num += value.toString();
                    } else if (value == -1 && num.isNotEmpty) {
                      num = num.substring(0, num.length - 1);
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
                  color: primaryColor,
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
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
