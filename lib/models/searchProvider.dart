// ignore_for_file: file_names

import 'dart:convert';
import 'package:practica_final_2/models/models.dart';

class SerchResponse {
    SerchResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SerchResponse.fromJson(String str) => SerchResponse.fromMap(json.decode(str));

    factory SerchResponse.fromMap(Map<String, dynamic> json) => SerchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
