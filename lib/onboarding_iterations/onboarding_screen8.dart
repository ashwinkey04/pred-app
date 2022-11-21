import 'package:pred/utils/constants.dart';
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
                buildButtonNext(context),
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
}
