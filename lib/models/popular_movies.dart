import 'dart:convert';

import 'package:practica_final_2/models/models.dart';

class Popular_Movies {
    Popular_Movies({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory Popular_Movies.fromJson(String str) => 
    Popular_Movies.fromMap(json.decode(str));

    factory Popular_Movies.fromMap(Map<String, dynamic> json) => 
    Popular_Movies(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}