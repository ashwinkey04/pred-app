import 'package:flutter/material.dart';

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
      left: 167,
      child: GestureDetector(
          onTap: () {},
          child: Container(
              width: 83,
              height: 83,
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
              child: const Center(
                  child: Text(
                "logo",
                style: TextStyle(fontSize: 20),
              )))),
    );
  }

  Widget _buildImageBackground(context) {
    return Container();
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
          children: const [
            Text(
              "Title goes here",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsum",
              style: TextStyle(color: Color(0xFF787575), height: 1.5),
            ),
            SizedBox(
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
          Navigator.pushReplacementNamed(context, "/2", arguments: 3);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: const Color(0xFF6464FF),
              borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }
}
