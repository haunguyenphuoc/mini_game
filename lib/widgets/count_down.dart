import 'package:flutter/material.dart';

class CountDown extends StatelessWidget {
  final double seconds;
  final double countDown;
  CountDown({this.seconds, this.countDown});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CountDownPainter(seconds: seconds, countDown: countDown),
      child: Container(),
    );
  }
}

class CountDownPainter extends CustomPainter {
  final Paint trackPaint;
  final double seconds;
  final double countDown;
  CountDownPainter({this.seconds, this.countDown})
      : trackPaint = new Paint()
          ..color = Colors.red[900]
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    double temp = (size.width * countDown) / seconds;
    // Draw track
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            0.0,
            0.0,
            size.width - temp,
            size.height,
          ),
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        trackPaint);
  }

  @override
  bool shouldRepaint(CountDownPainter oldDelegate) => true;
}
