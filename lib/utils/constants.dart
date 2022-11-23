import 'package:flutter/material.dart';

const primaryColor = Color(0xFF6464FF);
const welcomeLine = "Welcome to";
const tagline = "Your Intelligent, In-pocket trading advisor";

const gradientList = [
  Color.fromARGB(255, 100, 100, 255),
  Color.fromARGB(255, 125, 125, 252),
  Color.fromARGB(255, 148, 148, 254),
  Color.fromARGB(255, 170, 170, 255),
];

Widget upButtonWidget(BuildContext context) => IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.close,
      size: 30,
      color: Colors.black,
    ));

Widget buildButtonNext(context) => GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, "/9", arguments: 8),
      child: Container(
        width: 216,
        height: 71,
        decoration: BoxDecoration(
            color: const Color(0xFF3F4A64),
            borderRadius: BorderRadius.circular(80),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 36),
                  blurRadius: 60,
                  color: const Color(0xFF7e828d).withOpacity(0.7))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Next",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Container(
              width: 60,
              height: 37,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.arrow_forward_ios_outlined, size: 14),
            )
          ],
        ),
      ),
    );

Widget buildLogoIcon() {
  return Hero(tag: "logo",
    child: Center(
      child: GestureDetector(
          onTap: () {},
          child: Container(
              margin: const EdgeInsets.only(bottom: 160),
              width: 340,
              height: 340,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: Center(child: Image.asset('assets/imgs/onboard.png')))),
    ),
  );
}
