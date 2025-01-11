import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokeOfTheDayScreen extends StatelessWidget {
  const JokeOfTheDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Joke of the Day")),
      body: FutureBuilder<Joke>(
        future: ApiServices.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final joke = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(joke.setup, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(joke.punchline, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
