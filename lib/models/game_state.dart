import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/enums.dart';
import '../utils/constants.dart';
import '../utils/game_logic.dart';

class GameState extends ChangeNotifier {
  List<List<String>> board = [];
  String currentPlayer = 'X';
  String? winner;
  int xScore = 0;
  int oScore = 0;

  GameState() {
    resetGame();
  }

  get difficulty => null;

  void resetGame() {
    board = List.generate(
      BOARD_SIZE,
      (_) => List.filled(BOARD_SIZE, ''),
    );
    currentPlayer = 'X';
    winner = null;
    notifyListeners();
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && winner == null) {
      board[row][col] = currentPlayer;
      winner = checkWinner(board, row, col);

      if (winner != null) {
        if (winner == 'X') xScore++;
        if (winner == 'O') oScore++;
      }

      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      notifyListeners();
    }
  }

  void setDifficulty(GameDifficulty newValue) {}
}
