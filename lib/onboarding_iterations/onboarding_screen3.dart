import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: const Color(0xFF5A5757),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Row(
              children: [
                _buildTextColumn(),
                _buildControlElementsColumn(context, currentIndex)
              ],
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn() {
    return Flexible(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Text(
          "Your Title Goes Here",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsum",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        )
      ]),
    );
  }

  Widget _buildControlElementsColumn(context, currentIndex) {
    return Column(
      children: [
        _buildButtonNext(context),
        const SizedBox(
          height: 30,
        ),
        _buildDots(context, currentIndex)
      ],
    );
  }

  Widget _buildButtonNext(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, "/4", arguments: 3);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white)),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white)),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDots(context, currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          List.generate(9, (index) => _buildDot(currentIndex, index: index)),
    );
  }

  AnimatedContainer _buildDot(currentIndex, {int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? Colors.white
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
