import 'package:exam_capit/Model/movie_model.dart';
import 'package:exam_capit/Screen/Movie_Details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<List<Movie>> fetchMovies() async {
  final response =
      await http.get(Uri.parse('https://trackerteer.com/exam/exam.php'));

  if (response.statusCode == 200) {
    List<Movie> movies = [];
    List<dynamic> data = json.decode(response.body)['data'];

    data.forEach((movieJson) {
      movies.add(Movie.fromJson(movieJson));
    });

    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Movie movie = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(movie.title),
                      subtitle: movie.shouldShowDescription
                          ? Text(movie.description)
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(movie: movie),
                          ),
                        );
                      },
                    ),
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
