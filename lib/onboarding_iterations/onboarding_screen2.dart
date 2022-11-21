import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      backgroundColor: const Color(0xFF6464FF),
      body: GestureDetector(
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {
            Navigator.pushReplacementNamed(context, "/3", arguments: 2);
          }

          // Swiping in left direction.
          if (details.delta.dx < 0) {
            Navigator.pushReplacementNamed(context, "/", arguments: 1);
          }
        },
        child: Column(
          children: [
            Expanded(child: Container()),
            const Text(
              "Your Long Title Goes Here",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 34),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsumLorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsum",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 38,
            ),
            _buildDots(context, currentIndex),
            const SizedBox(
              height: 55,
            ),
            Image.asset('assets/imgs/phone.png')
          ],
        ),
      ),
    );
  }

  Widget _buildDots(context, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          List.generate(9, (index) => buildDot(currentIndex, index: index)),
    );
  }

  AnimatedContainer buildDot(currentIndex, {int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
