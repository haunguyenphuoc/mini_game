import 'package:flutter/material.dart';
import 'package:mini_game/animation/test_card_animation.dart';
import 'package:mini_game/models/card_model.dart';

class CardGird extends StatefulWidget {
  final List<CardModel> cards;
  final Function(CardModel) onPressCard;
  CardGird({Key key, this.cards, this.onPressCard}) : super(key: key);
  @override
  _CardGirdState createState() => _CardGirdState();
}

class _CardGirdState extends State<CardGird> {
  @override
  void initState() {
    super.initState();
  }

  void _onCardPress(CardModel model) {
    widget.onPressCard.call(model);
  }

  _buildCardItem(int index) {
    return CardAnimation(cardModel: widget.cards[index], onPress: _onCardPress);
  }

  Widget _buildRow(int start, int end) {
    List<Widget> items = [];
    for (int i = start; i < end; i++) {
      items.add(_buildCardItem(i));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ...items,
      ],
    );
  }

  Widget _buildGridView(int lenght) {
    if (lenght <= 0) {
      return Container();
    }
    List<Widget> widgets = [];
    int r = 3;
    int c = 4;
    for (int i = 0; i < c; i++) {
      widgets.add(_buildRow(i * r, i * r + r));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ...widgets,
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        child: _buildGridView(widget.cards.length),
      );
}
