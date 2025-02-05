import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cờ Caro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late bool _isXTurn;
  late String _winner;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _isXTurn = true;
      _winner = '';
    });
  }

  void _onCellTap(int row, int col) {
    if (_board[row][col].isEmpty && _winner.isEmpty) {
      setState(() {
        _board[row][col] = _isXTurn ? 'X' : 'O';
        _checkWinner(row, col);
        _isXTurn = !_isXTurn;
      });
    }
  }

  void _checkWinner(int row, int col) {
    String player = _board[row][col];

    // Check hàng ngang
    if (_board[row].every((cell) => cell == player)) {
      _winner = player;
      return;
    }

    // Check hàng dọc
    if (_board.every((rowList) => rowList[col] == player)) {
      _winner = player;
      return;
    }

    // Check đường chéo chính
    if (row == col && _board.every((rowList) => rowList[_board.indexOf(rowList)] == player)) {
      _winner = player;
      return;
    }

    // Check đường chéo phụ
    if (row + col == 2 && _board.every((rowList) => rowList[2 - _board.indexOf(rowList)] == player)) {
      _winner = player;
      return;
    }

    // Check hòa
    if (_board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      _winner = 'Hòa';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cờ Caro'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _winner.isNotEmpty
                  ? _winner == 'Hòa' ? 'Hòa!' : 'Người thắng: $_winner'
                  : 'Lượt: ${_isXTurn ? 'X' : 'O'}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _onCellTap(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 40,
                            color: _board[row][col] == 'X'
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}