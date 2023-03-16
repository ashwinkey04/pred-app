import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pred/screens/favourites.dart';
import 'package:pred/screens/news_list.dart';
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
  @override
  void initState() {
    super.initState();
    getStockDetails();
    getSentimentList();
  }

  getSentimentList() async {
    var fav = widget.userData!['favoriteStocks'];
    var staticSentimentList = [];
    for (var i = 0; i < fav.length; i++) {
      staticSentimentList.add(await FirestoreHelper.fetchSentiments(fav[i]));
    }
    return (staticSentimentList);
  }

  getStockDetails() async {
    return FirestoreHelper.fetchStocksList();
  }

  stockNameAndLogo(List<Map<String, dynamic>> stockDetails, String code) {
    for (Map element in stockDetails) {
      if (element['code'] == code) return element;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        backgroundWidget(context),
        topBar(context),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 164, 0, 0),
              child: const Text(
                'Today\'s Picks',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800),
              ),
            ),
            FutureBuilder(
                future: Future.wait(
                    Iterable.castFrom([getSentimentList(), getStockDetails()])),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    var sentiList = data[0] as List;
                    var stockList = data[1];
                    List? s = [];
                    for (var i = 0; i < sentiList.length; i++) {
                      s.add(sentiList[i].data());
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width * .98,
                      child: ListView.builder(
                        itemCount: s.length,
                        itemBuilder: (context, index) {
                          var nameAndLogo = stockNameAndLogo(stockList,
                              widget.userData!['favoriteStocks'][index]);
                          Map scores = {
                            'neutral': {
                              'count': 0.0,
                              'total': 0.0,
                              'average': 0.0
                            },
                            'positive': {
                              'count': 0.0,
                              'total': 0.0,
                              'average': 0.0
                            },
                            'negative': {
                              'count': 0.0,
                              'total': 0.0,
                              'average': 0.0
                            }
                          };
                          for (int i = 0;
                              i < s[index]['news_sentiments'].length;
                              i++) {
                            var sentiment =
                                s[index]['news_sentiments'][i]['sentiment'];
                            scores[sentiment]['count'] += 1;
                            scores[sentiment]['total'] += s[index]
                                ['news_sentiments'][i]['sentiment_score'];
                          }
                          // Calculate average for each score
                          for (String i in scores.keys) {
                            scores[i]['average'] =
                                scores[i]['total'] / scores[i]['count'];
                          }

                          String highestSentiment = scores.keys.first;
                          double highestCount = 0.0;

                          scores.forEach((key, value) {
                            if (value['count'] > highestCount) {
                              highestCount = value['count'];
                              highestSentiment = key;
                            }
                          });
                          return InkWell(
                              onTap: () {
                                nativePush(
                                    context,
                                    NewsList(
                                      userData: widget.userData,
                                      nameAndLogo: nameAndLogo,
                                      newsList: s[index]['news_sentiments'],
                                    ));
                              },
                              child: picksTile(
                                  context,
                                  nameAndLogo['logo'],
                                  nameAndLogo['name'],
                                  sentimentToRating(s[index]['news_sentiments']
                                      [0]['sentiment']),
                                  (scores[highestSentiment]['average'] * 100)
                                      .toString(),
                                  (s[index]['news_sentiments'][0]['title'])));
                        },
                      ),
                    );
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
          ],
        ),
      ],
    ));
  }

  Container backgroundWidget(BuildContext context) {
    return Container(
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
    );
  }

  Column topBar(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.14))
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
                    nativePush(
                        context, ChooseFavorites(userData: widget.userData));
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
    ]);
  }

  Container picksTile(BuildContext context, String image, String name,
      Rating rating, String score, String title) {
    return Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(8.0),
        height: 108,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 12),
                blurRadius: 12,
                color: const Color.fromARGB(255, 56, 56, 56).withOpacity(0.14))
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
                  '${rating == Rating.buy ? 'BUY' : rating == Rating.sell ? 'SELL' : 'HOLD'} : ${score.substring(0, 5)}%',
                  style: TextStyle(
                      color: rating == Rating.buy
                          ? const Color.fromARGB(255, 0, 255, 8)
                          : rating == Rating.sell
                              ? const Color.fromARGB(255, 189, 29, 29)
                              : const Color.fromARGB(255, 231, 239, 7),
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
