import 'package:flutter/material.dart';

class OnboardingScreen6 extends StatelessWidget {
  const OnboardingScreen6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4D4D4D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Text(
                "your logo",
                style: TextStyle(color: Color(0xFFAFBCCB), fontSize: 24),
              ),
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const Text(
                      "Title goes here!",
                      style: TextStyle(
                          color: Color(0xFF6871BC),
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta ipsumLorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          color: Color(0xFF756F6F),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    _buildButtonsControl(context),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsControl(context) => Row(
        children: [_buildButtonNext(context), _buildButtonSkip(context)],
      );

  Widget _buildButtonNext(context) => Flexible(
        child: GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, "/7", arguments: 6),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            decoration: BoxDecoration(
                color: const Color(0xFF00ACA1),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 17,
                      offset: const Offset(0, 18),
                      color: const Color(0xFF7A5F87).withOpacity(0.4))
                ]),
            child: const Center(
                child: Text(
              "Next",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
          ),
        ),
      );

  Widget _buildButtonSkip(context) => Flexible(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: const Center(
          child: Text(
            "Skip",
            style: TextStyle(
                color: Color(0xFF6871BC), fontWeight: FontWeight.w500),
          ),
        ),
      ));
}
