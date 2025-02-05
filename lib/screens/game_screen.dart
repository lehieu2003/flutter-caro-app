import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/game_board.dart';
import '../widgets/score_board.dart';
import '../models/game_state.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<GameState>().resetGame(),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScoreBoard(),
            SizedBox(height: 20),
            Expanded(child: GameBoard()),
          ],
        ),
      ),
    );
  }
}
