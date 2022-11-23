import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pred/screens/favourites.dart';
import 'package:pred/screens/onboarding_screen.dart';
import 'package:pred/utils/constants.dart';
import 'package:pred/utils/nav_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  final Map? userData;
  const HomeScreen({Key? key, this.userData}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Color.fromARGB(255, 77, 77, 255),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color.fromARGB(255, 77, 77, 255),
                  Color.fromARGB(255, 100, 100, 255),
                  Color.fromARGB(255, 125, 125, 252),
                  Color.fromARGB(255, 148, 148, 254),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.userData!['name'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 32,
                          color: Colors.white,
                          icon: const Icon(Icons.favorite),
                          onPressed: () {
                            nativePush(context,
                                ChooseFavorites(userData: widget.userData));
                          },
                        ),
                        IconButton(
                          iconSize: 32,
                          color: Colors.white,
                          onPressed: () {
                            Alert(
                                image: const Icon(
                                  Icons.logout_rounded,
                                  size: 64,
                                  color: Colors.black,
                                ),
                                context: context,
                                desc: 'Do you want to log out?',
                                buttons: [
                                  DialogButton(
                                      color: primaryColor,
                                      child: const Text(
                                        'Log out',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        logout(context);
                                      }),
                                  DialogButton(
                                      color: Colors.black,
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ]).show();
                          },
                          icon: const Icon(
                            Icons.logout_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
          )
        ],
      ),
    );
  }

  logout(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    nativePushUntil(context, const OnboardingScreen());
  }
}
