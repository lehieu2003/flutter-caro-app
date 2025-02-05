import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../utils/enums.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          return Column(
            children: [
              ListTile(
                title: const Text('Game Difficulty'),
                trailing: DropdownButton<GameDifficulty>(
                  value: gameState
                      .difficulty, // Ensure 'difficulty' getter exists in GameState
                  onChanged: (GameDifficulty? newValue) {
                    if (newValue != null) {
                      gameState.setDifficulty(newValue);
                    }
                  },
                  items: GameDifficulty.values.map((GameDifficulty difficulty) {
                    return DropdownMenuItem<GameDifficulty>(
                      value: difficulty,
                      child: Text(difficulty.toString().split('.').last),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
