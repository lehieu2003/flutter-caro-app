class Player {
  final String symbol;
  final String name;
  int score;

  Player({
    required this.symbol,
    required this.name,
    this.score = 0,
  });

  void incrementScore() => score++;
}
