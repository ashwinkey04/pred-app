import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class OnboardingScreen9 extends StatefulWidget {
  const OnboardingScreen9({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen9> createState() => _OnboardingScreen9State();
}

class _OnboardingScreen9State extends State<OnboardingScreen9> {
  List<int> data = List.generate(9, (index) => index);
  int _focusedIndex = 8;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildItemList(BuildContext context, int index) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            height: 270,
            decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4),
                borderRadius: BorderRadius.circular(32)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTextContent(),
            Expanded(
                child: ScrollSnapList(
              listController: ScrollController(initialScrollOffset: 270 * 9),
              onItemFocus: (p0) => setState(() {
                _focusedIndex = p0;
              }),
              itemBuilder: _buildItemList,
              itemSize: 180,
              dynamicItemSize: true,
              onReachEnd: () {},
              itemCount: data.length,
            )),
            _buildDots(context),
            const SizedBox(
              height: 50,
            ),
            _buildButtonGetStarted(context),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent() => Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 74,
            ),
            RichText(
              text: const TextSpan(
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(text: "Your Long Title "),
                    TextSpan(
                        text: "Goes",
                        style: TextStyle(color: Color(0xFF5397FD))),
                  ]),
            ),
            const Text(
              "Here",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF6464FF),
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Create and sell your own collectible and become hte richest NFT in the world ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF828282), fontWeight: FontWeight.w500),
            )
          ],
        ),
      );

  Widget _buildButtonGetStarted(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, "/", arguments: 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(35)),
            child: const Center(
                child: Text(
              "Get Started",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            )),
          ),
        ),
      );

  Widget _buildDots(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(9, (index) => buildDot(index: index)),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: _focusedIndex == index
            ? const Color(0xFF333333)
            : const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
