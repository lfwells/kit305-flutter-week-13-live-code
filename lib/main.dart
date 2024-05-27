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
      create: (BuildContext context) { return MovieModel(); },
      child: MaterialApp(
        title: 'Database Tutorial',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Week 13 Lecture')
      ),
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
  //TODO: consume the model

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const MovieDetails(id: -1);
                  }));
            },
          )
        ]
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            Expanded(
              child: Consumer<MovieModel>(
                builder: (context, movieModelInstance, _)
                {
                  return ListView.builder(
                    itemBuilder: buildTile,
                    itemCount: movieModelInstance.items.length
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget? buildTile(context, index)
  {
    return Consumer<MovieModel>(
      builder: (context, movieModelInstance, _)
      {
        //get the movie for the index
        var movies = movieModelInstance.items;
        var movie = movies[index];

        //return a list tile
        var image = movie.image;
        //return Text(movie.title);
        return Dismissible(
          key: Key(index.toString()),
          onDismissed: (direction) {
            movieModelInstance.delete(movie);
          },
          background: Container(color: Colors.red),
          child: ListTile(
            title: Text(movie.title),
            subtitle: Text("${movie.year} - ${movie.duration} Minutes"),
            leading: image != null ? Image.network(image) : null,

            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails(id: index);
                  }));
            },
          ),
        );
      },
    );
  }
}