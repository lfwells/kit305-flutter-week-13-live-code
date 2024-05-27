import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

//import 'package:share_plus/share_plus.dart';

class MovieDetails extends StatefulWidget
{
  final int id;

  const MovieDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final durationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    //get the movie for the index
    var movieModelInstance = Provider.of<MovieModel>(context, listen: false);
    var movies = movieModelInstance.items;
    Movie? movie = widget.id != -1 ? movies[widget.id] : null;

    var adding = movie == null;
    if (!adding) { //we are editing
      titleController.text = movie.title;
      yearController.text = movie.year.toString();
      durationController.text = movie.duration.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(adding ? "Add Movie" : "Edit Movie"),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),
        body: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (adding == false) Text("Movie Index ${widget.id}"),
                    //check out this dart syntax, lets us do an if as part of an argument list
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[

                          TextFormField(
                            decoration: const InputDecoration(labelText: "Title"),
                            controller: titleController,
                            validator: (inputValue) {
                              if (inputValue == null || inputValue.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            decoration: const InputDecoration(labelText: "Year"),
                            controller: yearController,
                            validator: (inputValue) {
                              if (inputValue == null || inputValue.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (int.tryParse(inputValue) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            decoration: const InputDecoration(labelText: "Duration"),
                            controller: durationController,
                            validator: (inputValue) {
                              if (inputValue == null || inputValue.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (double.tryParse(inputValue) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),

                          ElevatedButton.icon(
                              onPressed: () async
                              {
                                if (adding) {
                                  movie = Movie(title: "", duration: 0, year: 0);
                                }

                                //TODO: use a form validator
                                if (formKey.currentState!.validate())
                                {

                                  //update the movie object
                                  movie!.title = titleController.text;
                                  movie!.year = int.parse(yearController.text); //good code would validate these
                                  movie!.duration = double.parse( durationController.text); //good code would validate these

                                  if (adding)
                                  {
                                    movieModelInstance.add(movie!);
                                  }
                                  else
                                  {
                                    movieModelInstance.edit(movie!, atIndex: widget.id);
                                  }

                                  //return to previous screen
                                  if (context.mounted) Navigator.pop(context);
                                }

                              },
                              icon: const Icon(Icons.save),
                              label: const Text("Save Values")),

                          TextButton(onPressed: () {
                            //Share.share(movie!.title);
                          }, child: const Text("Share!")),
                        ],
                      ),
                    )
                  ]
              )
          ),
        )
    );
  }
}

