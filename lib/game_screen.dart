import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'settings_screen.dart';


class GameScreen extends StatefulWidget {
  final Color themeColor;

  GameScreen({required this.themeColor});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  int score = 0;
  Random random = Random();

  double circleSize = 25.0;
  double circlePositionX = 0.0;
  double circlePositionY = 0.0;

  int timerSeconds = 30;
  late Timer timer;

  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timerSeconds > 0) {
          timerSeconds--;
        } else {
          timer.cancel();
          showGameOverDialog();
        }
      });
    });
  }

  void showGameOverDialog() {
    setState(() {
      isGameOver = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false, // Set to false to prevent closing on outside tap
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your score is: $score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                resetGame(); // Restart the game
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      timerSeconds = 30;
      isGameOver = false;
      startTimer(); // Restart the timer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score: $score | Time: $timerSeconds seconds'),
        centerTitle: true,
        backgroundColor: createMaterialColor(widget.themeColor),
      ),
      body: GestureDetector(
        onTap: () {
          if (isGameOver) {
            return;
          }
        },
        child: Container(
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
                    if (isGameOver) {
                      return;
                    }
                    setState(() {
                      score++;
                      // Set new random position
                      circlePositionX = random.nextDouble() * 2 - 1;
                      circlePositionY = random.nextDouble() * 2 - 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment(circlePositionX, circlePositionY),
                    child: Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Dispose the timer when the widget is disposed to avoid memory leaks
    super.dispose();
  }
}

MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    final double ds = 0.5 - ((strength / 1000.0) / 2.0);
    swatch[strength] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
