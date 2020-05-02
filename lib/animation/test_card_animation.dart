import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_game/models/card_model.dart';
import 'package:mini_game/widgets/card_image.dart';

class CardAnimation extends StatefulWidget {
  final CardModel cardModel;
  final Function(CardModel) onPress;
  CardAnimation({this.cardModel, this.onPress});
  @override
  _CardAnimationState createState() => _CardAnimationState();
}

class _CardAnimationState extends State<CardAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.slowMiddle))
        .animate(animController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            animationStatus = status;
            switch (status) {
              case AnimationStatus.completed:
                if (widget.cardModel.state == CardState.close) {
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      animController.reverse();
                    });
                  });
                }
                // if (widget.cardModel.state == CardState.open) {
                //   setState(() {
                //     animController.reverse();
                //   });
                // }
                break;
              case AnimationStatus.dismissed:
                // debugPrint('do something when DISMSSED');
                break;
              case AnimationStatus.forward:
                // debugPrint('do something when FORWARD');
                break;
              case AnimationStatus.reverse:
                // debugPrint('do something when REVERSE');
                break;
              default:
              // debugPrint('$status');
            }
          });
  }

  // @override
  // void didUpdateWidget(CardAnimation oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cardModel.getState == CardState.open) {
      animController.reset();
    }
    return Center(
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(pi * animation.value),
        child: GestureDetector(
          onTap: () {
            if (!animController.isAnimating) {
              if (widget.cardModel.getState == CardState.close) {
                if (animationStatus == AnimationStatus.dismissed) {
                  animController.forward();
                }
                if (widget.onPress != null) {
                  widget.onPress(widget.cardModel);
                }
              }
            }
          },
          child:
              widget.cardModel.state == CardState.close && animation.value < 0.5
                  ? CardImage(card: unKnownCard)
                  : CardImage(card: widget.cardModel),
        ),
      ),
    );
  }
}
