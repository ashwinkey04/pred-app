import 'package:flutter/material.dart';

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        backgroundColor: const Color(0xFF8B8B8B),
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBackgroundCard(context),
            _buildContent(context, currentIndex)
          ],
        ));
  }

  Widget _buildContent(context, currentIndex) => Column(
        children: <Widget>[
          Expanded(flex: 5, child: Container()),
          Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                _buildMainCard(context),
                const SizedBox(
                  height: 43,
                ),
                _buildDots(context, currentIndex)
              ],
            ),
          )
        ],
      );

  Widget _buildMainCard(context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        width: 320,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Title Goes",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const Text(
              "Here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF57B97D)),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsum",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Color(0xFF756F6F)),
            ),
            const SizedBox(
              height: 25,
            ),
            _buildButtonNext(context)
          ],
        ),
      );

  Widget _buildButtonNext(context) => GestureDetector(
        onTap: () =>
            Navigator.pushReplacementNamed(context, "/5", arguments: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 250,
          decoration: const BoxDecoration(
              color: Color(0xFF0E1E22),
              borderRadius: BorderRadius.all(Radius.circular(23))),
          child: const Center(
            child: Text("Next",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
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
            borderRadius: BorderRadius.circular(19), border: Border.all()),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black,
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
        color: const Color(0xFF666666),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildBackgroundCard(BuildContext context) => Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          color: const Color(0xFFF6F6F7),
        ),
      );
}
