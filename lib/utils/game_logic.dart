String? checkWinner(
  List<List<String>> board,
  int row,
  int col,
  int boardSize,
) {
  final player = board[row][col];
  final winCount = boardSize == 3 ? 3 : 5;

  // Check hàng ngang
  if (checkLine(board, row, 0, 0, 1, player, winCount, boardSize))
    return player;

  // Check hàng dọc
  if (checkLine(board, 0, col, 1, 0, player, winCount, boardSize))
    return player;

  // Check đường chéo chính
  if (checkLine(board, 0, 0, 1, 1, player, winCount, boardSize)) return player;

  // Check đường chéo phụ
  if (checkLine(board, 0, boardSize - 1, 1, -1, player, winCount, boardSize)) {
    return player;
  }

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
  int boardSize,
) {
  var count = 0;
  var r = startRow;
  var c = startCol;

  while (r >= 0 && r < boardSize && c >= 0 && c < boardSize) {
    if (board[r][c] == player) {
      count++;
      if (count == winCount) return true;
    } else {
      count = 0;
    }
    r += rowIncrement;
    c += colIncrement;
  }
  return false;
}
