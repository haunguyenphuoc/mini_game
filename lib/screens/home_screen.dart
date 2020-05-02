import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_game/models/card_model.dart';
import 'package:mini_game/widgets/card_grid.dart';
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
    super.initState();
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
                      width: double.infinity,
                      height: 50.0,
                      color: Colors.black.withOpacity(0.3),
                    ),

                    // Body
                    if (snapshot.hasData)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.3),
                            child: CardGird(
                              cards: listTemp ?? [],
                              onPressCard: onPressCard,
                            ),
                          ),
                        ),
                      ),
                    if (!snapshot.hasData)
                      Center(
                        child: CircularProgressIndicator(),
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
