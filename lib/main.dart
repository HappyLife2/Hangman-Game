import 'package:flutter/material.dart';
import 'package:hangman/ui/colors.dart';
import 'package:hangman/utils/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  // Choosing the game word
  String word = "Flutter".toUpperCase();
  // Create a list that contains the Alphabet
  List<String> alphabets =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  List<String> selectedChar = [];
  int tries = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text("Hangman"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                // Let's make the figure widget
                // Let's add the images to the asset folder
                // Okey now we will create a Game class
                // Now the figure will be built according to the number of tries
                figureImage(tries >= 0, "assets/hang.png"),
                figureImage(tries >= 1, "assets/head.png"),
                figureImage(tries >= 2, "assets/body.png"),
                figureImage(tries >= 3, "assets/ra.png"),
                figureImage(tries >= 4, "assets/la.png"),
                figureImage(tries >= 5, "assets/rl.png"),
                figureImage(tries >= 6, "assets/ll.png"),
              ],
            ),
          ),

          // Now we will build the Hidden word widget
          // now let's go back to the Game class and add
          // a new variable to store the selected character
          /* and check if it's on the word */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),

          // Now let's build the Game keyboard
          SizedBox(
            width: double.infinity,
            height: 350.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
                      ? null // we first check that we didn't select the button before
                      : () {
                          setState(() {
                            Game.selectedChar.add(e);
                            print(Game.selectedChar);
                            if (!word.split('').contains(e.toUpperCase())) {
                              Game.tries++;
                            }
                          });
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  fillColor:
                      selectedChar.contains(e) ? Colors.black87 : Colors.blue,
                  child: Text(
                    e,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget figureImage(bool visible, String imagePath) {
    return Visibility(
      visible: visible,
      child: Image.asset(
        imagePath,
        width: 200.0,
        height: 200.0,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget letter(String text, bool visible) {
    return Visibility(
      visible: visible,
      child: Container(
        alignment: Alignment.center,
        width: 40.0,
        height: 40.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
