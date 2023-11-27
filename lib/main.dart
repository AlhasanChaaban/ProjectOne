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
        primarySwatch: createMaterialColor(Colors.blue),
      ),
      home: GameHomePage(),
    );
  }
}

class GameHomePage extends StatefulWidget {
  @override
  _GameHomePageState createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  Color appThemeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaxIT',
      theme: ThemeData(
        primarySwatch: createMaterialColor(appThemeColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MaxIT'),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen(themeColor: appThemeColor,)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: appThemeColor, // Set the button color dynamically
                  ),
                  child: const Text('Start Game'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    Color? selectedColor = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );

                    if (selectedColor != null) {
                      setState(() {
                        appThemeColor = selectedColor;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: appThemeColor, // Set the button color dynamically
                  ),
                  child: const Text('Settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
