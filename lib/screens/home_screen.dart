import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movie_provider.dart';
import 'package:practica_final_2/screens/details_screen.dart';
import 'package:practica_final_2/screens/search.dart';
import 'package:practica_final_2/widgets/widgets.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cartellera'),
          backgroundColor: Colors.red[600],
          elevation: 0,
          actions: [
            IconButton(onPressed: () {showSearch(context: context, delegate: SearchWp());}, icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              // Slider de pel·licules
              MovieSlider(populars: moviesProvider.onPopularMovies),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        )));
  }
}
