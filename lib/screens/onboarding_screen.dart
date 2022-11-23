import 'package:flutter/material.dart';
import 'package:pred/screens/login.dart';
import 'package:pred/utils/nav_helper.dart';

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
          buildLogoIcon(),
          _buildBottomCard(context),
          _buildButtonNext(context)
        ],
      ),
    );
  }

  Widget _buildImageBackground(context) {
    return Container(
      // Add box decoration
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
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
          nativePush(context, const LoginScreen());
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }
}
