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
  String status = '';
  int playerWinning = 0;
  int computerWinning = 0;

  runComputer() async {
    Future.delayed(Duration(milliseconds: 500), () async {
      if (isWin(player, boards)) {
        setState(() {
          playerWinning += 1;
          boards = List.filled(9, 0);
        });
      }

      if (boards.every((b) => b != 0)) {
        setState(() {
          boards = List.filled(9, 0);
        });
      }
      int? blocking;
      int? winning;
      int? normalMove;

      for (int i = 0; i < boards.length; i++) {
        List boardsFrom = List.from(boards);
        if (boardsFrom[i] != 0) {
          continue;
        }
        boardsFrom[i] = computer;
        if (isWin(computer, boardsFrom)) {
          winning = i;
        }

        boardsFrom[i] = player;

        if (isWin(player, boardsFrom)) {
          blocking = i;
        }
        normalMove = i;
      } // looping

      var mainMove = winning ?? blocking ?? normalMove;

      await Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          boards[mainMove!] = computer;
        });
      });

      if (isWin(computer, boards)) {
        setState(() {
          computerWinning++;
          boards = List.filled(9, 0);
        });
      }
      if (boards.every((b) => b != 0)) {
        setState(() {
          boards = List.filled(9, 0);
        });
      }
    });
  }

  bool isWin(int user, List boards) {
    //012
    //345
    //678
    //036
    //147
    //258
    // 048
    //246
    return boards[0] == user && boards[1] == user && boards[2] == user ||
        boards[3] == user && boards[4] == user && boards[5] == user ||
        boards[6] == user && boards[7] == user && boards[8] == user ||
        boards[0] == user && boards[3] == user && boards[6] == user ||
        boards[1] == user && boards[4] == user && boards[7] == user ||
        boards[2] == user && boards[5] == user && boards[8] == user ||
        boards[0] == user && boards[4] == user && boards[4] == user ||
        boards[2] == user && boards[4] == user && boards[6] == user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          spacing: 10,
          children: [
            Text("60"),
            Text("C: $computerWinning"),
            Text("P: $playerWinning"),
          ],
        ),
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
                      if (boards[i] != 0) {
                        setState(() {
                          status =
                              boards[i] == 1
                                  ? "You already played here"
                                  : "Computer has played there";
                        });

                        return;
                      }
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
                      child: Center(
                        child: Text(
                          boards[i] == player
                              ? "O"
                              : boards[i] == computer
                              ? "X"
                              : "",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Center(child: Text(status, style: TextStyle(fontSize: 17))),
        ],
      ),
    );
  }
}
