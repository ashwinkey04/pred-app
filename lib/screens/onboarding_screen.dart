import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),
      body: Stack(
        children: [
          _buildImageBackground(context),
          _buildLogoIcon(),
          _buildBottomCard(context),
          _buildButtonNext(context)
        ],
      ),
    );
  }

  Positioned _buildLogoIcon() {
    return Positioned(
      top: 221,
      left: 44,
      child: GestureDetector(
          onTap: () {},
          child: Container(
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
    );
  }

  Widget _buildImageBackground(context) {
    return Container(
      // Add box decoration
      decoration: const BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: gradientList,
        ),
      ),
    );
  }

  Widget _buildBottomCard(context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(top: 62, left: 41, right: 41),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  welcomeLine,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  " PRED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF6464FF),
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              tagline,
              style: TextStyle(color: Color(0xFF787575), height: 1.5),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonNext(context) {
    return Positioned(
      bottom: 51,
      right: 53,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/login", arguments: 3);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }
}
