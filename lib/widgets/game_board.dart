import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../utils/constants.dart';
import 'cell_widget.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: BOARD_SIZE,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: BOARD_SIZE * BOARD_SIZE,
        itemBuilder: (context, index) {
          final row = index ~/ BOARD_SIZE;
          final col = index % BOARD_SIZE;
          return CellWidget(
            value: gameState.board[row][col],
            onTap: () => gameState.makeMove(row, col),
          );
        },
      ),
    );
  }
}
