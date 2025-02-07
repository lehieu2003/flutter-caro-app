import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildScore('Player X', gameState.xScore, Colors.red),
        _buildGameStatus(gameState),
        _buildScore('Player O', gameState.oScore, Colors.green),
      ],
    );
  }

  Widget _buildScore(String label, int score, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$score',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildGameStatus(GameState gameState) {
    return Column(
      children: [
        Text(
          gameState.winner == null
              ? 'Current Player: ${gameState.currentPlayer}'
              : gameState.winner == 'Draw'
                  ? 'Game Draw!'
                  : 'Winner: ${gameState.winner}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (gameState.winner != null && gameState.winner != 'Draw')
          ElevatedButton(
            onPressed: gameState.resetGame,
            child: const Text('Play Again'),
          ),
      ],
    );
  }
}
