import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(ClickCircleGame());
}

class ClickCircleGame extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameHomePage(),
    );
  }
}

class GameHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Navigate to start game screen
                },
                child: const Text('Start Game'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to settings screen
                },
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
