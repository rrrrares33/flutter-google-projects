import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NonePage(),
    );
  }
}

class NonePage extends StatefulWidget {
  const NonePage({Key? key}) : super(key: key);

  @override
  NonePageState createState() => NonePageState();
}

class NonePageState extends State<NonePage> {
  // Play Field
  List<List<String>> gameTable = <List<String>>[
    <String>['white', 'white', 'white'],
    <String>['white', 'white', 'white'],
    <String>['white', 'white', 'white'],
  ];

  final List<Color> colors = <Color>[
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  // Remembers if the "Play Again button should be displayed or not.
  bool displayPlayAgain = false;

  // Remembers the color of the player who moves now.
  String colorTurn = 'red';

  // Checks if the game table is full or not.
  bool tableFull(List<List<String>> table) {
    for (int i = 0; i < table.length; i++) {
      for (int j = 0; j < table[i].length; j++) {
        if (table[i][j] == 'white') {
          return false;
        }
      }
    }
    return true;
  }

  List<List<String>> clearTable(){
    return <List<String>>[
      <String>['white', 'white', 'white'],
      <String>['white', 'white', 'white'],
      <String>['white', 'white', 'white'],
    ];
  }

  // Checks if a game is in final state or not.
  bool checkFinalState(List<List<String>> table) {
    return (table[0][0] == table[1][1] && table[1][1] == table[2][2] && table[0][0] != 'white') ||
        (table[0][2] == table[1][1] && table[1][1] == table[2][0] && table[0][2] != 'white') ||
        (table[0][0] == table[0][1] && table[0][1] == table[0][2] && table[0][0] != 'white') ||
        (table[0][0] == table[1][0] && table[1][0] == table[2][0] && table[0][0] != 'white') ||
        (table[2][2] == table[1][2] && table[1][2] == table[0][2] && table[2][2] != 'white') ||
        (table[2][2] == table[2][1] && table[2][1] == table[2][0] && table[2][2] != 'white') ||
        (table[1][0] == table[1][1] && table[1][1] == table[1][2] && table[1][0] != 'white') ||
        (table[0][1] == table[1][1] && table[1][1] == table[2][1] && table[0][1] != 'white') ||
        tableFull(table);
  }

  int convertIndexToMatrix(int index) {
    int line = 0;
    int col = 0;
    if (index == 0 || index == 1 || index == 2) {
      line = 0;
    } else if (index == 3 || index == 4 || index == 5) {
      line = 1;
    } else {
      line = 2;
    }
    if (index == 0 || index == 3 || index == 6) {
      col = 0;
    } else if (index == 1 || index == 4 || index == 7) {
      col = 1;
    } else {
      col = 2;
    }
    return (line + 1) * 10 + col + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: const Text('X - 0'),
        ),
        body: Column(children: <Widget>[
          GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!displayPlayAgain) {
                        final int pos = convertIndexToMatrix(index);
                        final int line = pos ~/ 10 - 1;
                        final int col = pos % 10 - 1;
                        if (gameTable[line][col] != 'white') {
                        } else {
                          if (colorTurn == 'red') {
                            gameTable[line][col] = colorTurn;
                            colors[index] = Colors.red;
                            colorTurn = 'green';
                          } else {
                            gameTable[line][col] = colorTurn;
                            colors[index] = Colors.green;
                            colorTurn = 'red';
                          }
                        }
                        if (checkFinalState(gameTable)) {
                          displayPlayAgain = true;
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black87,
                      width: 0.5,
                    ),
                        color: colors[index]),
                  ),
                );
              }),
          Visibility(
              visible: displayPlayAgain,
              child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey.shade300),
                    elevation: MaterialStateProperty.all(5),
                    padding: MaterialStateProperty.all(
                        const EdgeInsetsDirectional.all(10)),
                  ),
                  onPressed: () {
                    setState(() {
                      displayPlayAgain = false;
                      gameTable = clearTable();
                      for(int i = 0; i < 9; i++) {
                        colors[i] = Colors.white;
                      }
                    });
                  },
                  child: const Text('Play Again')))
        ]));
  }
}
