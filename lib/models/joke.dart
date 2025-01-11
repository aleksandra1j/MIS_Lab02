class Joke {
  final String type;
  final String setup;
  final String punchline;

  Joke({required this.type, required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Joke) return false;
    return type == other.type && setup == other.setup && punchline == other.punchline;
  }

  @override
  int get hashCode => Object.hash(type, setup, punchline);
}
