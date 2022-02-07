// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movie_provider.dart';

class SearchWp extends SearchDelegate{ //clase con un SearchDelegate que nos construye 4 Widgets
  SearchWp(): super(searchFieldLabel: "Cercar..."); //Texto que nos saldrá en el label de busqueda

  @override
  List<Widget>? buildActions(BuildContext context) { //Widget para limpiar el texto del label de busqueda a partir de un boton
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        }
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) { //Widget para salir de la clase a partir de un boton
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context) { //Método para imprimir los resultados de nuestra busqueda
    if (query.isEmpty) { //If para comprobar si la busqueda vacia, si es asi nos dira que busquemos algo.
        return Center(child: Text("Realitza una recerca"),);
      } else { //Si nos es vacia nos devolvera las obras que coincidan con nuestra busqueda
        return FutureBuilder(
          future: MoviesProvider().busqueda(query),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if(snapshot.hasData){ //Si hay resultados nos lo imprimira en un ListView con el titulo y la imagen
              final List<Movie>? llista = snapshot.data;
              return ListView.builder(
                itemCount: llista!.length,
                itemBuilder: (context, index) {
                  Movie result = llista[index];
                  return ListTile(
                    leading: Image.network(result.fullPosterPath),
                    title: Text(result.title),
                    onTap: () => Navigator.pushNamed(context, 'details', arguments: result),
                    // onTap: ()=> Navigator.pushNamed(context, 'details', arguments: resultado)
                  );
                },
              );
            }else{
              return Center(child: Text('No s\'ha trobat cap pel.lícula')); //Si no hay resultados nos imprimira un texto diciendo que no se han encontrado resultados
            }
           },
        );
      }
  }

  @override
  Widget buildSuggestions(BuildContext context) { //Método para ver los resultados de nuestra busqueda mientras estamos buscando
    if (query.isEmpty) {
        return Center(child: Text("No has realitzat cap recerca"),);
      } else {
        return FutureBuilder(
          future: MoviesProvider().busqueda(query),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if(snapshot.hasData){
              final llista = snapshot.data;
              return ListView.builder(
                itemCount: llista!.length,
                itemBuilder: (context, index) {
                  Movie resultado = llista[index];
                  return ListTile(
                    title: Text(resultado.title),
                    onTap: ()=> Navigator.pushNamed(context, 'details', arguments: resultado)
                  );
                },
              );
            }else{
              return Center(child: CircularProgressIndicator(),); //Mientras estemos buscando saldra un gif de carga
            }
           },
        );
      }
  }
}