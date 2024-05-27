import 'package:flutter/material.dart';

class Movie
{
  String title;
  int year;
  num duration;
  String? image;

  Movie({required this.title, required this.year, required this.duration, this.image});

  Movie.fromJson(Map<String, dynamic> json)
      :
        title = json['title'],
        year = json['year'],
        duration = json['duration'];

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'year': year,
        'duration' : duration
      };
}

class MovieModel extends ChangeNotifier
{
  /// Internal, private state of the list.
  final List<Movie> items = [];

  //Normally a model would get from a database here, we are just hardcoding some data for this week
  MovieModel()
  {
    //this is where you would fetch() normally

    add(Movie(title:"Lord of the Rings", year:2001, duration:9001, image:"https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg"));
    add(Movie(title:"The Matrix", year:1999, duration:150, image:"https://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg"));

    var aMovie = items[0];

    //serialize it
    var movieToJsonString = aMovie.toJson().toString();
    print(movieToJsonString);

    //deserialize it
    var movieFromJson = Movie.fromJson({"title": "whatever", "year": 78678687678, "duration": 9001});
    print(movieFromJson);
    print(movieFromJson.year);
  }

  void add(Movie item) {
    items.add(item);
    update();
  }

  // This call tells the widgets that are listening to this model to rebuild.
  void update()
  {
    notifyListeners(); //notify all the consumers (rebuilds them)
  }

  void edit(Movie movie, { required int atIndex })
  {
    //used copilot here:
    //check if the index is valid
    if (atIndex < 0 || atIndex >= items.length) return;

    items[atIndex] = movie;
    update();
  }

  void delete(Movie movie)
  {
    items.remove(movie);
    update();
  }
}