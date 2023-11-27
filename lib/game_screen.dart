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
        title: const Text('Game Screen'),
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
              left: circlePositionX,
              top: circlePositionY,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                    // Set new random position
                    circlePositionX = random.nextDouble() * 350;
                    circlePositionY = random.nextDouble() * 500;
                  });
                },
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
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width * 0.5 - 50,
              child: Text(
                'Score: $score',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
