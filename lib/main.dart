import 'package:flutter/material.dart';
import 'package:mini_game/screens/home_screen.dart';

void main() => runApp(MiniGame());

class MiniGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set landscape orientation
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
