import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_game/models/card_model.dart';
import 'package:mini_game/widgets/card_grid.dart';
import 'package:mini_game/widgets/count_down.dart';
import 'package:mini_game/widgets/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardModel> openCards = [];
  int checkWin = 0;
  List<CardModel> listTemp = new List<CardModel>();
  String level = "LEVEL1";
  Timer timer;
  int seconds = 60;
  int countDown = 0;
  bool isPause = false;

  void _startTimer() {
    const onsec = const Duration(seconds: 1);
    timer = new Timer.periodic(onsec, (timer) {
      setState(() {
        if (countDown == seconds) {
          timer.cancel();
          debugPrint('YOU CLOSE');
        } else {
          countDown++;
        }
      });
    });
  }

  Future<List<CardModel>> readJsonFile(String level) async {
    if (listTemp.length == 0) {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/config/config.json");
      final jsonResult = json.decode(data);

      var rest = jsonResult["$level"]["models"] as List;

      listTemp =
          rest.map<CardModel>((json) => CardModel.fromJson(json)).toList();
    }

    return listTemp;
  }

  void onPressCard(CardModel model) {
    if (model.getState == CardState.close && openCards.length <= 2) {
      openCards.add(model);
    }
    if (openCards.length == 2) {
      if (openCards[0].getTag == openCards[1].getTag &&
          openCards[0].index != openCards[1].index) {
        setState(() {
          listTemp[openCards[0].index].setState = CardState.open;
          listTemp[openCards[1].index].setState = CardState.open;
          checkWin++;
        });
      }
      openCards.clear();
    }

    if (checkWin == listTemp.length / 2) {
      _showCustomDialog();
    }
  }

  Future<Null> _showCustomDialog() async {
    String result = await showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dialog from closing on outside touch
        builder: (BuildContext context) {
          return CustomDialog();
        });
    if (result == 'replay') {
      refresh();
      setState(() {});
    }

    if (result == 'next') {
      refresh();
      setState(() {
        level = "LEVEL2";
      });
    }
  }

  void refresh() {
    checkWin = 0;
    openCards.clear();
    listTemp.clear();
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return FutureBuilder<List<CardModel>>(
      future: readJsonFile(level),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // Back ground
                Container(
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: <Widget>[
                    // App bar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.black.withOpacity(0.3),
                        border: Border.all(width: 1.5, color: Colors.white),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    "assets/images/pokemon_ball.png",
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  '0000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Level 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (timer != null) {
                                if (isPause) {
                                  _startTimer();
                                } else {
                                  timer.cancel();
                                }
                              }
                              setState(() {
                                isPause = !isPause;
                              });
                            },
                            child: Container(
                              child: Icon(
                                isPause
                                    ? Icons.play_circle_outline
                                    : Icons.pause_circle_outline,
                                color: Colors.white,
                                size: 50.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Body
                    if (snapshot.hasData)
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black.withOpacity(0.3),
                              border:
                                  Border.all(width: 1.5, color: Colors.white),
                            ),
                            child: CardGird(
                              cards: listTemp ?? [],
                              onPressCard: onPressCard,
                            ),
                          ),
                        ),
                      ),
                    if (!snapshot.hasData)
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    // Bottom bar
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 5.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.black.withOpacity(0.3),
                        border: Border.all(width: 1.5, color: Colors.white),
                      ),
                      width: double.infinity,
                      height: 25.0,
                      child: CountDown(
                        seconds: seconds.toDouble(),
                        countDown: countDown.toDouble(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
