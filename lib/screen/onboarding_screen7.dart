import 'package:flutter/material.dart';

class OnboardingScreen7 extends StatelessWidget {
  const OnboardingScreen7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 1.0833333333333334)
                      .toDouble()),
              painter: RPSCustomPainter3(),
            ),
            Expanded(child: Container()),
            const Text(
              "Your Title Goes",
              style: TextStyle(
                  color: Color(0xFF3F3849),
                  fontSize: 32,
                  fontWeight: FontWeight.w800),
            ),
            const Text("Here",
                style: TextStyle(
                    color: Color(0xFF6464FF),
                    fontSize: 32,
                    fontWeight: FontWeight.w800)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "You can schedule your work with us more easily",
              style: TextStyle(
                  color: Color(0xFF3F3849),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            _buildDots(context, currentIndex),
            const SizedBox(
              height: 40,
            ),
            _buildButtonNext(context),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots(context, currentIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(9, (index) => _buildDot(currentIndex, index: index)),
      );

  AnimatedContainer _buildDot(currentIndex, {int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: const EdgeInsets.only(right: 10),
      height: 10,
      width: currentIndex == index ? 33 : 10,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? const Color(0xFF9F9FFE)
              : const Color(0xFFE9E8EC),
          borderRadius: BorderRadius.circular(50)),
    );
  }

  Widget _buildButtonNext(context) => GestureDetector(
        onTap: () =>
            Navigator.pushReplacementNamed(context, "/8", arguments: 7),
        child: Container(
          height: 45,
          width: 200,
          decoration: BoxDecoration(
              color: const Color(0xFF6464FF),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Text(
              "Next",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color(0xFF4A4A4A)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.9155250);
    path0.quadraticBezierTo(size.width * 0.0286667, size.height * 1.1778625,
        size.width, size.height * 0.5880875);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.quadraticBezierTo(size.width * -0.0011083, size.height * 0.2433500, 0,
        size.height * 0.9155250);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color(0xFF4A4A4A)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * -0.0212833, size.height * 0.5815875,
        size.width * 0.0003917, size.height * 0.7362750);
    path0.quadraticBezierTo(size.width * -0.0016833, size.height * 1.2112375,
        size.width, size.height * 0.8273375);
    path0.lineTo(size.width * 0.9998917, 0);
    path0.lineTo(size.width * 0.4622833, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color(0xFF4A4A4A)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * -0.0841250, size.height * 0.6364375,
        size.width * 0.0001333, size.height * 0.7911125);
    path0.quadraticBezierTo(size.width * -0.0645250, size.height * 1.2660750,
        size.width, size.height * 0.8273375);
    path0.lineTo(size.width * 0.9998917, 0);
    path0.lineTo(size.width * 0.4622833, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
