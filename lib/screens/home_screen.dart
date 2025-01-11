import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';
import 'jokes_screen.dart';
import 'favorites_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Joke> _favoriteJokes = [];

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Navigator.pushNamed(context, '/joke_of_the_day');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(context, '/joke_of_the_day');
    });
  }

  void _toggleFavorite(Joke joke) {
    setState(() {
      if (_favoriteJokes.contains(joke)) {
        _favoriteJokes.remove(joke);
      } else {
        _favoriteJokes.add(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke Types"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesScreen(favoriteJokes: _favoriteJokes, onFavoriteToggle: _toggleFavorite),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.pushNamed(context, '/random');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiServices.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  jokeType: jokeTypes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokesScreen(
                          type: jokeTypes[index],
                          onFavoriteToggle: _toggleFavorite,
                          favoriteJokes: _favoriteJokes,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
