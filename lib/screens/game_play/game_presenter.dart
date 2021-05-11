import 'dart:async';
import 'package:tic_tac_toe/constants.dart';


import 'package:tic_tac_toe/ai/friday_ai.dart';
import 'package:tic_tac_toe/ai/friday_functions.dart';

class GamePresenter {

  // callbacks into our UI
  void Function(int idx) showMoveOnUi;
  void Function(int winningPlayer) showGameEnd;

  Ai _aiPlayer;

  GamePresenter(this.showMoveOnUi, this.showGameEnd) {
    _aiPlayer = Ai();
  }

  void onHumanPlayed(List<int> board) async {

    // evaluate the board after the human player
    int evaluation = Utils.evaluateBoard(board);
    if (evaluation != Ai.NO_WINNERS_YET) {
      onGameEnd(evaluation);
      return;
    }

    // calculate the next move, could be an expensive operation
    int aiMove = await Future.delayed(const Duration(seconds: 1) ,()=> _aiPlayer.play(board, Ai.AI_PLAYER));

    // do the next move
    board[aiMove] = Ai.AI_PLAYER;
    
    // evaluate the board after the AI player move
    evaluation = Utils.evaluateBoard(board);
    if (evaluation != Ai.NO_WINNERS_YET)
      onGameEnd(evaluation);
    else
      showMoveOnUi(aiMove);
  }

  void onGameEnd(int winner) async{
    if (winner == Ai.AI_PLAYER) {

      String current_wins = await storage.read(key: 'wins');
      await storage.write(key: 'wins', value: (int.parse(current_wins)+ 1).toString());
    }

    showGameEnd(winner);
  }




}