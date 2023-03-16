import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pred/screens/favourites.dart';
import 'package:pred/screens/onboarding_screen.dart';
import 'package:pred/utils/constants.dart';
import 'package:pred/utils/firestore_helper.dart';
import 'package:pred/utils/nav_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  final Map? userData;
  const HomeScreen({Key? key, this.userData}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? senti;

  @override
  void initState() {
    super.initState();
    fillFav();
  }

  fillFav() async {
    var fav = widget.userData!['favoriteStocks'][0];
    senti = FirestoreHelper.fetchSentiments(fav);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0.0),
                padding: const EdgeInsets.only(top: 48),
                height: 116,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  // borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 12),
                        blurRadius: 16,
                        color: const Color.fromARGB(255, 0, 0, 0)
                            .withOpacity(0.14))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24.0),
                child: const Text(
                  'Today\'s Picks',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800),
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: FutureBuilder(
                    future: senti,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var senti = snapshot.data as DocumentSnapshot;
                        Map s = senti.data() as Map;
                        Map t = senti.data() as Map;
                        return picksTile(
                            context,
                            'https://assets-netstorage.groww.in/stock-assets/logos/GSTK500325.png',
                            'Reliance',
                            true,
                            (s['sentiment_score']
                                        [s['sentiment_score'].keys.first] *
                                    100)
                                .toString(),
                            t['title'][t['title'].keys.first]);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 98.0),
                          child: Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: Colors.white, size: 64),
                          ),
                        );
                      }
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container picksTile(BuildContext context, String image, String name, bool buy,
      String score, String title) {
    return Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        height: 128,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 12),
                blurRadius: 12,
                color: Color.fromARGB(255, 56, 56, 56).withOpacity(0.14))
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(6, 6, 16, 6),
              padding: const EdgeInsets.all(14.0),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.network(
                image,
                width: 64,
                height: 64,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${buy ? 'BUY' : 'SELL'} : ${score.substring(0, 5)}%',
                  style: TextStyle(
                      color: buy
                          ? Color.fromARGB(255, 0, 255, 8)
                          : Color.fromARGB(255, 189, 29, 29),
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ));
  }

  logout(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    nativePushUntil(context, const OnboardingScreen());
  }
}
