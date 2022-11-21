import 'package:flutter/material.dart';

class OnboardingScreen5 extends StatelessWidget {
  const OnboardingScreen5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        backgroundColor: const Color(0xFF00928C),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text(
                  "yourlogo",
                  style: TextStyle(
                      color: Color(0xFFAFBCCB),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "Your Title Goes Here!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                _buildButtonNext(context),
                const SizedBox(
                  height: 16,
                ),
                _buildDots(context, currentIndex),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildButtonNext(BuildContext context) => GestureDetector(
        onTap: () =>
            Navigator.pushReplacementNamed(context, "/6", arguments: 5),
        child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Text(
              "NEXT",
              style: TextStyle(
                  color: Color(0xFF0E0F0F),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );

  Widget _buildDots(context, currentIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(9, (index) => _buildDot(currentIndex, index: index)),
      );

  AnimatedContainer _buildDot(currentIndex, {int? index}) {
    if (currentIndex == index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        margin: const EdgeInsets.only(right: 10),
        height: 12,
        width: 12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              )),
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: const EdgeInsets.only(right: 10),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
