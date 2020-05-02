import 'package:flutter/material.dart';
import 'package:mini_game/models/card_model.dart';

class CardImage extends StatelessWidget {
  final CardModel card;
  final double width;
  final double height;
  CardImage({this.card, this.width = 100, this.height = 120});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      //constraints: BoxConstraints(),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.red[100],
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              1.0, // vertical, move down 10
            ),
          )
        ],
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          image: AssetImage(card.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
