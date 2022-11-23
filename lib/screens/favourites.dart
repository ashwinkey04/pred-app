import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pred/screens/home.dart';
import 'package:pred/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:pred/utils/constants.dart';
import 'package:pred/utils/firestore_helper.dart';
import 'package:pred/utils/nav_helper.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class ChooseFavorites extends StatefulWidget {
  final userData;
  const ChooseFavorites({Key? key, @required this.userData}) : super(key: key);

  @override
  State<ChooseFavorites> createState() => _ChooseFavoritesState();
}

class _ChooseFavoritesState extends State<ChooseFavorites> {
  Future? shareList;
  List? loadedShareList;
  int _focusedIndex = 8;
  bool buttonLoading = false;

  @override
  void initState() {
    super.initState();
    shareList = FirestoreHelper.fetchStocksList();
  }

  Widget _buildShareList(BuildContext context, int index) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 180,
                height: 270,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 3),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 20),
                          blurRadius: 30,
                          color: const Color.fromARGB(255, 111, 111, 111)
                              .withOpacity(0.4))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        loadedShareList![index]['logo'],
                        width: 140,
                      ),
                    ),
                    Text(loadedShareList![index]['name']),
                  ],
                ),
              ),
              Positioned(
                  right: 8,
                  top: 8,
                  child: Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      activeColor: primaryColor,
                      value: loadedShareList![index]['isFav'] ?? false,
                      onChanged: (bool? value) {
                        loadedShareList![index]['isFav'] = value;
                        setState(() {});
                      },
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Color.fromARGB(255, 77, 77, 255),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTextContent(),
            Expanded(
                child: FutureBuilder(
                    future: shareList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        loadedShareList = snapshot.data as List;
                        return ScrollSnapList(
                          listController:
                              ScrollController(initialScrollOffset: 270 * 9),
                          onItemFocus: (p0) => setState(() {
                            _focusedIndex = p0;
                          }),
                          itemBuilder: _buildShareList,
                          itemSize: 180,
                          dynamicItemSize: true,
                          onReachEnd: () {},
                          itemCount: loadedShareList!.length,
                        );
                      } else {
                        return LoadingAnimationWidget.inkDrop(
                            color: primaryColor, size: 64);
                      }
                    })),
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
          children: const [
            SizedBox(
              height: 74,
            ),
            Text(
              "Pick your favorites",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF6464FF),
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "These will always be in your home screen",
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
          onTap: () async {
            setState(() {
              buttonLoading = true;
            });
            var favStocks = [];
            loadedShareList?.forEach((element) {
              if (element['isFav'] == true) {
                favStocks.add(element['code']);
              }
            });
            await FirestoreHelper.updateUserDocument(
                {'favoriteStocks': favStocks});
            Map newUserData = widget.userData;
            newUserData['favoriteStocks'] = favStocks;
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              buttonLoading = false;
            });
            nativePushUntil(
                context,
                HomeScreen(
                  userData: newUserData,
                ));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(35)),
            child: Center(
                child: buttonLoading
                    ? LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white, size: 32)
                    : const Text(
                        "Choose",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
          ),
        ),
      );

  Widget _buildDots(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => buildDot(index: index)),
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
