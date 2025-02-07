import 'package:flutter/material.dart';
import '../utils/enums.dart';
import 'player.dart';
import '../utils/game_logic.dart';

class GameState extends ChangeNotifier {
  late List<List<String>> board;
  late List<Player> players;
  int boardSize = 3;
  GameMode gameMode = GameMode.PvP;
  Difficulty difficulty = Difficulty.medium;
  bool soundEnabled = true;
  GameStatus status = GameStatus.playing;
  int currentPlayerIndex = 0;
  int xScore = 0;
  int oScore = 0;
  String? _winner;

  GameState() {
    _initializeGame();
  }

  Player get currentPlayer => players[currentPlayerIndex];

  String? get winner => _winner;

  void _initializeGame() {
    players = [
      Player(symbol: 'X', name: 'Người chơi 1'),
      Player(
          symbol: 'O', name: gameMode == GameMode.PvP ? 'Người chơi 2' : 'Máy'),
    ];
    _resetBoard();
  }

  void _resetBoard() {
    board = List.generate(boardSize, (_) => List.filled(boardSize, ''));
    status = GameStatus.playing;
    currentPlayerIndex = 0;
    _winner = null;
    notifyListeners();
  }

  void resetGame() {
    _resetBoard();
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && status == GameStatus.playing) {
      board[row][col] = currentPlayer.symbol;
      _checkGameStatus(row, col);
      _switchPlayer();
      notifyListeners();
    }
  }

  void _checkGameStatus(int row, int col) {
    final winner = checkWinner(board, row, col, boardSize);

    if (winner != null) {
      status = GameStatus.win;
      currentPlayer.incrementScore();
      _winner = currentPlayer.symbol;
      if (currentPlayer.symbol == 'X') {
        xScore++;
      } else {
        oScore++;
      }
    } else if (board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      status = GameStatus.draw;
      _winner = 'Draw';
    }
  }

  void _switchPlayer() {
    if (status == GameStatus.playing) {
      currentPlayerIndex = (currentPlayerIndex + 1) % 2;
      if (gameMode == GameMode.PvE && currentPlayerIndex == 1) {
        _makeAIMove();
      }
    }
  }

  void _makeAIMove() {
    // Implement AI logic here
  }

  // Settings-related methods
  void changeBoardSize(int newSize) {
    boardSize = newSize;
    _initializeGame();
  }

  void changeGameMode(GameMode mode) {
    gameMode = mode;
    _initializeGame();
  }

  void changeDifficulty(Difficulty newDifficulty) {
    difficulty = newDifficulty;
    notifyListeners();
  }

  void toggleSound(bool value) {
    soundEnabled = value;
    notifyListeners();
  }
}
