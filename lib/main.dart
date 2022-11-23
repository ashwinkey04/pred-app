import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pred/screens/login.dart';
import 'package:pred/screens/splash.dart';
import 'package:pred/screens/verify_phone.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pred',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/splash',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/splash': (context) => const Splash(),
          '/login': (context) => const LoginScreen(),
        });
  }
}
