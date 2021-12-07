import 'package:flutter/material.dart';

class OnboardingScreen8 extends StatelessWidget {
  const OnboardingScreen8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))))),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Your Long Title Goes",
                  style: TextStyle(
                      color: Color(0xFF3F3849),
                      fontSize: 28,
                      fontWeight: FontWeight.w800),
                ),
                const Text("Here",
                    style: TextStyle(
                        color: Color(0xFF6464FF),
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce et lorem a mauris dictum pulvinar id non erat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF343674),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                _buildButtonNext(context),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonNext(context) => GestureDetector(
        onTap: () =>
            Navigator.pushReplacementNamed(context, "/9", arguments: 8),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(Icons.arrow_forward_ios_outlined, size: 14),
              )
            ],
          ),
        ),
      );
}
