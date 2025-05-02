import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 136, 169, 236),
          centerTitle: true,
          title: Text(
            'Lets Play!!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 57, 77),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 108, 126, 162),
        body: Column(
          children: [
            SizedBox(height: 40),
            PlayerPanel(),
            SizedBox(height: 60),
            GameGrid(),
          ],
        ),
      ),
    ),
  );
}

// playernamepanel text playernamepanel

class PlayerPanel extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Container(
      child: Card(
        color: Color.fromARGB(255, 7, 155, 223),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayerNamePanel('PlayerA', 'X'),
            SizedBox(width: 16),
            Text(
              'TicTacToe',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16),
            PlayerNamePanel('PlayerB', '0'),
          ],
        ),
      ),
    );
  }
}

class PlayerNamePanel extends StatefulWidget {
  String initialName = '';
  String initalSymbol = '';

  PlayerNamePanel(String Name, String Symbol) {
    initialName = Name;
    initalSymbol = Symbol;
  }
  @override
  State<StatefulWidget> createState() {
    return PlayerNamePanelState();
  }
}

class PlayerNamePanelState extends State<PlayerNamePanel> {
  String playerName = 'PlayerA';
  String buttonText = 'edit';
  String playerSymbol = 'X';

  @override
  initState() {
    super.initState();
    playerName = widget.initialName;
    playerSymbol = widget.initalSymbol;
  }

  TextEditingController textController = TextEditingController();
  onEditName() {
    setState(() {
      if (buttonText == 'edit') {
        buttonText = 'save';
        textController.text = playerName;
      } else {
        playerName = textController.text;
        buttonText = 'edit';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: 130,
      //height: 110,
      child: Card(
        elevation: 10,
        shadowColor: Color.fromARGB(255, 1, 0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color.fromARGB(255, 7, 155, 223),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonText == 'edit'
                ? Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 251, 251, 251),
                    fontWeight: FontWeight.bold,
                  ),
                )
                : TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 146, 155, 225),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 139, 171, 196),
                  ),
                ),
            //Text(playerName),
            Text(
              playerSymbol,
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 251, 251, 251),
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                foregroundColor: Color.fromARGB(255, 164, 186, 227),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 3,
                shadowColor: Color.fromARGB(255, 108, 107, 107),
              ),

              onPressed: onEditName,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 104, 109, 246),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameGridState();
  }
}

class GameGridState extends State<GameGrid> {
  List<String> gameState = ["", "", "", "", "", "", "", "", "", ""];
  String turnSymbol = "X";
  String turnText = "Turn:X";
  List<int> winningIndices = [];
  onGameGridButtonClick(int index) {
    setState(() {
      if (gameState[index] != "") {
        if (gameState[index] != "") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Cell already filled!"),
              duration: Duration(milliseconds: 800),
            ),
          );
          return;
        }
      }
      gameState[index] = turnSymbol;

      String result = checkWin();
      if (result == "WIN") {
        turnText = "WIN :" + turnSymbol;
      } else if (result == "DRAW!") {
        turnText = "DRAW!";
      } else {
        turnSymbol = turnSymbol == 'X' ? '0' : 'X';
        turnText = "Turn :" + turnSymbol;
      }
    });
  }

  String checkWin() {
  List<List<int>> winPatterns = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7],
  ];

  for (var pattern in winPatterns) {
    if (gameState[pattern[0]] == turnSymbol &&
        gameState[pattern[1]] == turnSymbol &&
        gameState[pattern[2]] == turnSymbol) {
      winningIndices = pattern;  //  This highlights the winning tiles
      return "WIN";
    }
  }

  if (gameState.sublist(1).every((e) => e != "")) {
    return "DRAW!";
  }

  return "GameON";
}


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 130),
              Center(
                child: Text(
                  turnText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
            ],
          ),
          Row(children: [buildButton(1), buildButton(2), buildButton(3)]),
          Row(children: [buildButton(4), buildButton(5), buildButton(6)]),
          Row(children: [buildButton(7), buildButton(8), buildButton(9)]),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                gameState = [
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                ]; // reset all 10
                turnSymbol = "X";
                turnText = "Turn:X";
                winningIndices=[];
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Restart Game",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(int index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 125,
        height: 120,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                winningIndices.contains(index)
                    ? Colors
                        .yellow // Highlight winner
                    : Color.fromARGB(255, 136, 169, 236),

            //backgroundColor: Color.fromARGB(255, 136, 169, 236),
            foregroundColor: Color.fromARGB(255, 0, 0, 0),
            elevation: 10,
            shadowColor: Color.fromARGB(255, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onGameGridButtonClick(index),
          child: Text(
            gameState[index],
            style: TextStyle(
              color: Color.fromARGB(255, 67, 67, 181),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
