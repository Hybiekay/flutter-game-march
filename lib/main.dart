import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  List boards = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int player = 1;
  int computer = 2;

  runComputer() async {
    Future.delayed(Duration(microseconds: 500), () {
      int? blocking;
      int? winning;
      int? normalMove;
      List boardsFrom = List.from(boards);
      for (int i = 0; i < boardsFrom.length; i++) {
        if (boardsFrom[i] != 0) {
          continue;
        }
        boardsFrom[i] = computer;
        if (isWin(computer, boardsFrom)) {}
      }
    });
  }

  isWin(int user, List boards) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          Text("Coin: 200"),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 15,
              child: Icon(Icons.play_arrow, color: Colors.white),
              backgroundColor: Colors.green,
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                boards = List.filled(9, 0);
              });
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.red,
              child: Icon(Icons.restart_alt, color: Colors.white),
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.all(10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                for (int i = 0; i < boards.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        boards[i] = player;
                      });
                      runComputer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            boards[i] == player
                                ? Colors.green
                                : boards[i] == computer
                                ? Colors.red
                                : Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
