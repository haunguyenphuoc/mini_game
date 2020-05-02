import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String level;
  final int score;
  final bool isClose;
  CustomDialog({this.title, this.isClose, this.level, this.score});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 200.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // title
                    Text(
                      '$title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // body
                    Expanded(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$level: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              score < 0 ? '0000' : score.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context, 'replay');
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(40.0)),
                            child: Icon(
                              Icons.update,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (!isClose)
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context, 'next');
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 40.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
