import 'package:flutter/material.dart';
import 'screen/onboarding_screen.dart';
import 'screen/onboarding_screen2.dart';
import 'screen/onboarding_screen3.dart';
import 'screen/onboarding_screen4.dart';
import 'screen/onboarding_screen5.dart';
import 'screen/onboarding_screen6.dart';
import 'screen/onboarding_screen7.dart';
import 'screen/onboarding_screen8.dart';
import 'screen/onboarding_screen9.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/2': (context) => const OnboardingScreen2(),
          '/3': (context) => const OnboardingScreen3(),
          '/4': (context) => const OnboardingScreen4(),
          '/5': (context) => const OnboardingScreen5(),
          '/6': (context) => const OnboardingScreen6(),
          '/7': (context) => const OnboardingScreen7(),
          '/8': (context) => const OnboardingScreen8(),
          '/9': (context) => const OnboardingScreen9(),
        });
  }
}
