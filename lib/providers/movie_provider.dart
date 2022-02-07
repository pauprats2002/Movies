// ignore_for_file: prefer_final_fields, avoid_print, unnecessary_this
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/models/popular_movies.dart';
import 'package:practica_final_2/models/searchProvider.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';              //Url de la base de datos
  String _apiKey = 'd70493afef399bde80629d22b7280d89'; //Clave de la Api que nos dan de la base de datos
  String _language = 'es-ES';                          //Lenguaje de las peliculas
  String _page = '1';                                  //Pagina que empieza a coger

  List<Movie> onDisplayMovies = [];                    //Lista para almacenar peliculas
  List<Movie> onPopularMovies = [];   
  Map<int, List<Cast>> casting = {};                 //Lista para almacenar las peliculas populares
  List<Movie> onSearchMovies = [];                     //List para almacenar las peliculas en el buscador

  MoviesProvider() {  //Llamamos a los métodos getOnDisplayMovies y getOnPopulars
    this.getOnDisplayMovies();
    this.getOnPopulars();
  }

  getOnDisplayMovies() async { //Llamamos a la base de datos con las variables que hemos definido anteriormente
    // print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page}); //Peticion a la base de datos

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url); //Declaramos el resultado de lo que nos devuelve la peticion y hacemos un await para recibir la respuesta

    final nowPlayingMovies = NowPlayingMovies.fromJson(result.body); //Guardamos de un Json el resultado del body de la peticion

    onDisplayMovies = nowPlayingMovies.results; //Almacenamos todas las peliculas en la lista de Movies

    notifyListeners(); //Utilizamos este metodo por si el objeto cambia
  }

  getOnPopulars() async { //Hacemos lo mismo que en el anterior método
    // print('getOnPopularMovies');
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final popularMovies = Popular_Movies.fromJson(result.body);

    onPopularMovies = popularMovies.results;
    // print(onPopularMovies);
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async { //Declaramos un método donde almacenaremos el resultado en un Future con una lista de Movies
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits', //Peticion a los creditos de la pelicula que elijamos
        {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast; //Almacenamos el resultado en la lista casting

    return creditsResponse.cast; //Devolvemos la lista
  }

   Future<List<Movie>> busqueda(String query) async { //Declaramos un método donde almacenaremos el resultado en un Future con una lista de Movies
    var url = Uri.https(_baseUrl, '3/search/movie', { //Peticion a las peliculas buscadas
      'api_key': _apiKey,
      'language': _language,
      'query': query, //Peticion que hacemos nosotros segun lo que buscamos
    });

    final result = await http.get(url);

    final searchResponse = SerchResponse.fromJson(result.body);

    onSearchMovies = searchResponse.results;

    return onSearchMovies; //Devolvemos la lista
  }
}