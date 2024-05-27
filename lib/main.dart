import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'movie_details.dart';
import 'movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //BEGIN: the old MyApp builder from last week
    return ChangeNotifierProvider(
        create: (context) => MovieModel(),
        child: MaterialApp(
            title: 'Database Tutorial',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'Database Tutorial')
        )
    );
    //END: the old MyApp builder from last week
  }
}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
{
  @override
  Widget build(BuildContext context)
  {
    var movies = [
      Movie(title:"Lord of the Rings", year:2001, duration:9001, image:"https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg"),
      Movie(title:"The Matrix", year:1999, duration:150, image:"https://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg")
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    var movie = movies[index];
                    var image = movie.image;
                    return ListTile(
                      title: Text(movie.title),
                      subtitle: Text("${movie.year} - ${movie.duration} Minutes"),
                      leading: image != null ? Image.network(image) : null,

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(id: index);
                            }));
                      },
                    );
                  },
                  itemCount: movies.length
              ),
            )
          ],
        ),
      ),
    );
  }
}