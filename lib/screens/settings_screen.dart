import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../utils/enums.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.read<GameState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kích thước bàn cờ:', style: TextStyle(fontSize: 18)),
            DropdownButton<int>(
              value: gameState.boardSize,
              items: const [
                DropdownMenuItem(value: 3, child: Text('3x3')),
                DropdownMenuItem(value: 5, child: Text('5x5')),
                DropdownMenuItem(value: 7, child: Text('7x7')),
              ],
              onChanged: (value) {
                gameState.changeBoardSize(value!);
              },
            ),
            const SizedBox(height: 20),
            const Text('Chế độ chơi:', style: TextStyle(fontSize: 18)),
            DropdownButton<GameMode>(
              value: gameState.gameMode,
              items: const [
                DropdownMenuItem(
                  value: GameMode.PvP,
                  child: Text('Người vs Người'),
                ),
                DropdownMenuItem(
                  value: GameMode.PvE,
                  child: Text('Người vs Máy'),
                ),
              ],
              onChanged: (mode) {
                gameState.changeGameMode(mode!);
              },
            ),
            const SizedBox(height: 20),
            const Text('Độ khó:', style: TextStyle(fontSize: 18)),
            DropdownButton<Difficulty>(
              value: gameState.difficulty,
              items: const [
                DropdownMenuItem(
                  value: Difficulty.easy,
                  child: Text('Dễ'),
                ),
                DropdownMenuItem(
                  value: Difficulty.medium,
                  child: Text('Trung bình'),
                ),
                DropdownMenuItem(
                  value: Difficulty.hard,
                  child: Text('Khó'),
                ),
              ],
              onChanged: (difficulty) {
                gameState.changeDifficulty(difficulty!);
              },
            ),
            SwitchListTile(
              title: const Text('Âm thanh'),
              value: gameState.soundEnabled,
              onChanged: (value) {
                gameState.toggleSound(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
