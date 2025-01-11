import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class JokesScreen extends StatelessWidget {
  final String type;
  final Function(Joke) onFavoriteToggle;
  final List<Joke> favoriteJokes;

  const JokesScreen({
    super.key,
    required this.type,
    required this.onFavoriteToggle,
    required this.favoriteJokes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$type Jokes"),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiServices.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFavorite = favoriteJokes.contains(joke);

                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => onFavoriteToggle(joke),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
