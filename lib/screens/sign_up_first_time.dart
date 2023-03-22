import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pred/screens/favourites.dart';
import 'package:pred/utils/constants.dart';
import 'package:pred/utils/firestore_helper.dart';
import 'package:pred/utils/nav_helper.dart';

class SignUpFirstTime extends StatefulWidget {
  const SignUpFirstTime({Key? key}) : super(key: key);

  @override
  State<SignUpFirstTime> createState() => _SignUpFirstTimeState();
}

class _SignUpFirstTimeState extends State<SignUpFirstTime> {
  bool visible = false;
  bool entered = false;
  @override
  void initState() {
    super.initState();
    anim();
  }

  void anim() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: gradientList,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
        )),
        child: entered
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white, size: 64),
              )
            : AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: visible ? 1.0 : 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 38, vertical: 16),
                      child: Text(
                        'How do we call you?',
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * .85,
                        height: MediaQuery.of(context).size.height * .1,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(left: 36),
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 30,
                                offset: const Offset(0, 4),
                              ),
                            ]),
                        child: TextField(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                          textInputAction: TextInputAction.go,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            hintText: 'Enter Full Name',
                          ),
                          onSubmitted: (value) async {
                            debugPrint(value);
                            setState(() {
                              visible = false;
                            });
                            await FirestoreHelper.updateUserDocument(
                                {'name': value});
                            await Future.delayed(
                                const Duration(milliseconds: 400));
                            setState(() {
                              entered = true;
                            });
                            nativePushReplacement(
                                context,
                                ChooseFavorites(userData: {
                                  'name': value,
                                  'favoriteStocks': const []
                                }));
                          },
                        )),
                    const SizedBox(
                      height: 1,
                      width: 1,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
