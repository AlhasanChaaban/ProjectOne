import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;
  Random random = Random();

  double circleSize = 25.0;
  double circlePositionX = 0.0;
  double circlePositionY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score: $score'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                    // Set new random position
                    circlePositionX = random.nextDouble() * 2 -1;
                    circlePositionY = random.nextDouble() * 2 -1;
                  });
                },
                child: Container(
                  alignment: Alignment(circlePositionX,circlePositionY),
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
