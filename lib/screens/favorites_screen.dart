import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Joke> favoriteJokes;
  final Function(Joke) onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favoriteJokes,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Jokes"),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text("No favorite jokes yet!"))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return ListTile(
            title: Text(joke.setup),
            subtitle: Text(joke.punchline),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                onFavoriteToggle(joke);
              },
            ),
          );
        },
      ),
    );
  }
}
