import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ai/friday_ai.dart';
import 'package:tic_tac_toe/screens/game_play/field.dart';
import 'package:tic_tac_toe/screens/game_play/game_presenter.dart';
import 'package:tic_tac_toe/constants.dart';
import 'package:tic_tac_toe/screens/game_play/home_page.dart';

class GamePage extends StatefulWidget {



  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {

  List<int> board;
  int _currentPlayer;
  String player = "Please Play Your Move" ;
  GamePresenter _presenter;
  bool isTouchApplicable = false;

  GamePageState() {
    this._presenter = GamePresenter(_movePlayed, _onGameEnd);

  }

  void _onGameEnd(int winner) {

    var title = "";
    var content = "";
    var screentext = "";
    Color colour = Colors.white;
    switch(winner) {
      case Ai.HUMAN: // will never happen :)
        title = "Wohoooo!!!!";
        content = "assets/images/win.png";
        screentext = "Congratulations!!!!";
        colour = wincolor;
        break;
      case Ai.AI_PLAYER:
        title = "Better Luck Next Time";
        content = "assets/images/lose.png";
        screentext = "AI Wins";
        colour = losecolor;
        break;
      default:
        title = "It's a Tie";
        content = "assets/images/draw.png";
        screentext = "Better Luck Next Time";
        colour = bgcolor;
    }

    setState(() {
      player = screentext;
    });
    showDialog(
        barrierDismissible: false,
           context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.asset(content),
            title: Center(child: Text(title)),
            actions: <Widget>[
              RaisedButton(
                    color: colour,
                    shape: CircleBorder(side: BorderSide(color: Colors.white, width: 0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Icon(Icons.home),textColor: Colors.white,),
              SizedBox(
                width: MediaQuery.of(context).size.width/3,
              ),
               RaisedButton(
                 color: colour,
                    shape: CircleBorder(side: BorderSide(color: Colors.white, width: 0),
                    ),
                  onPressed: () {
                    setState(() {
                      reinitialize();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Icon(Icons.refresh),textColor: Colors.white,),
                  
            ],
          );
    });
  }

  void _movePlayed(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      if (_currentPlayer == Ai.HUMAN) {
        // switch to AI player
        _currentPlayer = Ai.AI_PLAYER;
        isTouchApplicable = true;
        player = "Friday's Turn...";
        _presenter.onHumanPlayed(board);

      } else {
        _currentPlayer = Ai.HUMAN;
        isTouchApplicable = false;
        player = "Please Play Your Move";
      }
    });
  }


  String getSymbolForIdx(int idx) {
    return Ai.SYMBOLS[board[idx]];
  }

  @override
  void initState() {
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    _currentPlayer = Ai.HUMAN;
    isTouchApplicable = false;
    player = "Please Play Your Move";
    // generate the initial board
    board = List.generate(9, (idx) => 0);
  }

  @override
  Widget build(BuildContext context) {

  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
            },
                  child: SingleChildScrollView(
            
            child: Container(
            height: height,
            color: Colors.white,
            child: Stack(
                children: [
                  Positioned(child: Container(height: height,color:bgcolor)),
                  Positioned(
                    top: height/12,
                    child: Container(
                      height: 50,
                      width: width,
                      child: Center(child: Text("You are playing as X", style: TextStyle(fontSize: 25,fontFamily: 'lilita',fontWeight:FontWeight.normal),))),
                  ),
                  // Positioned(
                  //   top: height/5.5,
                  //   left: width/10,
                  //   right: width/10,
                  //   height: height/1.8,
                  //   // width: width - 20,
                  //   child: Image.asset('assets/images/square.png')),
                   Positioned(
                      top: height/5,
                      left: width/8,
                      right: width/8,
                      bottom: height/3,
                      child: Container(
                        height: height/2,
                        decoration: BoxDecoration(
                          image:DecorationImage(image: AssetImage('assets/images/square.png'),fit: BoxFit.fill)
                        ),
                        child: AbsorbPointer(
                            absorbing: isTouchApplicable,
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width - 20,
                                        child: GridView.count(
                                       crossAxisCount: 3,
                                       // generate the widgets that will display the board
                                       children: List.generate(9, (idx) {
                                         return BoardField(idx: idx, onTap: _movePlayed, playerSymbol: getSymbolForIdx(idx));
                                       },
                                       ),
                                   ),
                            ),
                          ),
                        ),
                      ),
                   ),
                   Positioned(
                     left: width/8,
                     right: width/8,
                     height: height/4,
                     bottom: 0,
                     child: Image.asset('assets/images/monitor.png'),
                   ),
                   Positioned(
                    left: width/4,
                    bottom: height/8,
                    child: Text("$player",style: TextStyle(fontFamily: 'lilita',fontSize: 20),))
                ],
              ),
      ),
          ),
        ),
    );
    
  }
}


