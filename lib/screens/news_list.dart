import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pred/screens/favourites.dart';
import 'package:pred/screens/onboarding_screen.dart';
import 'package:pred/utils/constants.dart';
import 'package:pred/utils/firestore_helper.dart';
import 'package:pred/utils/nav_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  final Map? userData, nameAndLogo;
  final List? newsList;
  const NewsList({Key? key, this.userData, this.nameAndLogo, this.newsList})
      : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List newsList = [];
  @override
  void initState() {
    super.initState();
    newsList = widget.newsList!;
    fetchPredictedPrice();
  }

  Map<String, dynamic>? predictions;
  double? price;

  fetchPredictedPrice() async {
    predictions =
        (await FirestoreHelper.pricePrediction(widget.nameAndLogo?['code']))
            .data();
    String todayDate = predictions!.keys
        .reduce((a, b) => DateTime.parse(a).isAfter(DateTime.parse(b)) ? a : b);
    setState(() {
      price = predictions![todayDate];
    });
    debugPrint("The prediction is: ${predictions![todayDate]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 77, 77, 255),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: price == null
                  ? SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text('Prediction: ₹${price?.toStringAsFixed(2)} ',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
            ),
            expandedHeight: 130,
            backgroundColor: const Color.fromARGB(212, 0, 0, 0),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ), //IconButton
            title: Text(widget.nameAndLogo?['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                )),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Stack(
                children: [
                  Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white.withOpacity(0.25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      )),
                  InkWell(
                    onTap: () async {
                      // Open URL
                      final _url = Uri.parse(newsList[index]['url']);
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      } else {}
                    },
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          stops: const [
                            0.1,
                            0.15,
                            0.53,
                          ],
                          end: Alignment.bottomRight,
                          colors:
                              _getGradientColors(newsList[index]['sentiment']),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    newsList[index]['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    newsList[index]['description'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FutureBuilder(
                                future: _getMetadata(newsList[index]['url']),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://www.tickertape.in/blog/wp-content/uploads/2021/08/1-1-2.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ), //ListTile
              childCount: newsList.length,
            ), //SliverChildBuildDelegate
          ) //SliverList
        ],
      ),
    )
        // Stack(
        //   children: [
        //     backgroundWidget(context),
        //     topBar(context),
        //     // Get text input
        //     Padding(
        //         padding: const EdgeInsets.only(top: 128.0),
        //         child: newsListMethod())
        //   ],
        // ),
        );
  }

  Container backgroundWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   stops: [0.1, 0.5, 0.7, 0.9],
        //   colors: [
        //     Color.fromARGB(255, 77, 77, 255),
        //     Color.fromARGB(255, 100, 100, 255),
        //     Color.fromARGB(255, 125, 125, 252),
        //     Color.fromARGB(255, 148, 148, 254),
        //   ],
        // ),
        color: Color.fromARGB(255, 77, 77, 255),
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                iconSize: 28,
                color: Colors.white,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              widget.nameAndLogo?['name'],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              width: 64,
              height: 64,
            ),
          ],
        ),
      ),
    ]);
  }

  logout(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    nativePushUntil(context, const OnboardingScreen());
  }

  List<Color> _getGradientColors(String sentiment) {
    switch (sentiment) {
      case 'positive':
        return [
          const Color.fromARGB(150, 0, 200, 83),
          const Color.fromARGB(90, 0, 230, 119),
          Colors.white.withOpacity(0.15),
        ];
      case 'negative':
        return [
          const Color.fromARGB(149, 255, 55, 0),
          const Color.fromARGB(90, 255, 98, 0),
          Colors.white.withOpacity(0.15),
        ];
      default:
        return [
          const Color.fromARGB(150, 255, 213, 0),
          const Color.fromARGB(90, 255, 234, 0),
          Colors.white.withOpacity(0.15),
        ];
    }
  }

  _getMetadata(String url) async {
    final WebInfo info;
    try {
      info = await LinkPreview.scrapeFromURL(url);
    } catch (e) {
      return 'https://cdn-icons-png.flaticon.com/512/2640/2640775.png';
    }

    /// Image URL, if present any in the link.
    final String image = info.image;
    return image.isEmpty
        ? 'https://www.tickertape.in/blog/wp-content/uploads/2021/08/1-1-2.png'
        : image;
  }
}
