import 'package:flutter/material.dart';
import 'package:tictactoe/custom_dialog.dart';
import 'package:tictactoe/game_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    return List<GameButton>.generate(9, (i) => GameButton(id: i+1));
  }

  void playGame(GameButton gb) {
    setState(() {
      if(activePlayer == 1) {
        gb.text = 'X';
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = '0';
        gb.bg = Colors.blue;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      checkWinner();
    });
  }

  void checkWinner() {
    var winner = -1;
    if(isWinner(player1)) {
      winner = 1;
    }
    if(isWinner(player2)) {
      winner = 2;
    }
    if(winner != -1) {
      showDialog(context: context,
          builder: (_) => CustomDialog('Player $winner won', 'Press reset button to start again', resetGame)
      );
      return;
    }
    if(buttonsList.every((p) => !p.enabled)) {
      showDialog(context: context,
          builder: (_) => CustomDialog("It's a DRAW!", 'Press reset button to start again', resetGame)
      );
    }
  }

  bool isWinner(player) {
    final List winningPatterns = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7] ];
    for (var pattern in winningPatterns) {
      if(player.contains(pattern[0]) && player.contains(pattern[1]) && player.contains(pattern[2])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    if(Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
              ),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: buttonsList[i].enabled ? () => playGame(buttonsList[i]) : null,
                    child: Text(
                      buttonsList[i].text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    color: buttonsList[i].bg,
                    disabledColor: buttonsList[i].bg
                ),
              ),
            )
          ),
          RaisedButton(
            child: Text(
              'RESET',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0),
            ),
            color: Colors.lightBlue,
            padding: const EdgeInsets.all(20),
            onPressed: resetGame,
          )
        ]
      )
    );
  }
}