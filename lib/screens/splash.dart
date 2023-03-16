import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pred/screens/home.dart';
import 'package:pred/screens/onboarding_screen.dart';
import 'package:pred/screens/sign_up_first_time.dart';
import 'package:pred/utils/constants.dart';
import 'package:pred/utils/nav_helper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool hasError = false;

  @override
  void initState() {
    chooseScreen();
    super.initState();
  }

  initialiseFirebase() async {
    DocumentSnapshot? userData;
    try {
      await _initialization;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      debugPrint('UID ${FirebaseAuth.instance.currentUser?.uid}');
      userData = await users.doc(FirebaseAuth.instance.currentUser?.uid).get();
    } catch (e) {
      setState(() {
        hasError = true;
      });
      print("error getting user data $e");
      return "error";
    }
    return userData.exists == true ? userData.data() : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: gradientList,
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.1, 0.5, 0.7, 0.9],
      )),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLogoIcon(),
              hasError
                  ? const Text(
                      "Error occurred",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )
                  : LoadingAnimationWidget.inkDrop(
                      color: Colors.white, size: 64),
            ],
          ),
        ),
      ),
    ));
  }

  void chooseScreen() async {
    if (FirebaseAuth.instance.currentUser == null) {
      nativePushReplacement(context, const OnboardingScreen());
    } else {
      var firebaseData = await initialiseFirebase();
      debugPrint('FBDATA $firebaseData');
      if (firebaseData == false) {
        nativePushUntil(context, const SignUpFirstTime());
      } else if (firebaseData != "error") {
        debugPrint('Dataa: $firebaseData');
        nativePushUntil(context, HomeScreen(userData: firebaseData));
      } else {
        setState(() {
          hasError = true;
        });
        nativePushUntil(context, const OnboardingScreen());
      }
    }
  }
}
