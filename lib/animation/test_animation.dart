import 'package:flutter/material.dart';

class TestAnimation extends StatefulWidget {
  @override
  _TestAnimationState createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    // animation = Tween<double>(
    //   begin: 0,
    //   end: 2 * pi,
    // ).animate(animController)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {
    //     switch (status) {
    //       case AnimationStatus.completed:
    //         animController.reverse();
    //         break;
    //       case AnimationStatus.dismissed:
    //         animController.forward();
    //         break;
    //       default:
    //         debugPrint('status: $status');
    //     }
    //   });
    // final curveAnimation =
    //     CurvedAnimation(parent: animController, curve: Curves.easeInOutQuint);

    animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(animController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            switch (status) {
              case AnimationStatus.completed:
                animController.reverse();
                break;
              case AnimationStatus.dismissed:
                animController.forward();
                break;
              default:
              // debugPrint('status: $status');
            }
          });

    animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Center(
        child: Container(
          //margin: EdgeInsets.all(100),
          width: 200,
          height: 200,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.yellowAccent,
        ),
      ),
    );
  }
}
