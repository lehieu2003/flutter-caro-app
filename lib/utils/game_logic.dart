import 'constants.dart';

String? checkWinner(List<List<String>> board, int row, int col) {
  final player = board[row][col];
  const winCount = 3;

  // Check hàng ngang
  if (checkLine(board, row, 0, 0, 1, player, winCount)) return player;

  // Check hàng dọc
  if (checkLine(board, 0, col, 1, 0, player, winCount)) return player;

  // Check đường chéo chính
  if (row == col && checkLine(board, 0, 0, 1, 1, player, winCount))
    return player;

  // Check đường chéo phụ
  if (row + col == BOARD_SIZE - 1 &&
      checkLine(board, 0, BOARD_SIZE - 1, 1, -1, player, winCount)) {
    return player;
  }

  // Check hòa
  if (board.every((row) => row.every((cell) => cell.isNotEmpty))) return 'Draw';

  return null;
}

bool checkLine(
  List<List<String>> board,
  int startRow,
  int startCol,
  int rowIncrement,
  int colIncrement,
  String player,
  int winCount,
) {
  var count = 0;
  for (var i = 0; i < BOARD_SIZE; i++) {
    final r = startRow + i * rowIncrement;
    final c = startCol + i * colIncrement;
    if (r >= BOARD_SIZE || c >= BOARD_SIZE) break;
    if (board[r][c] == player) {
      count++;
      if (count == winCount) return true;
    } else {
      count = 0;
    }
  }
  return false;
}
