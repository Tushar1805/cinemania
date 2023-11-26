import 'dart:convert';

import 'package:quadb_tech/Data/show_module.dart';

Movie moviesFromJson(String str) => Movie.fromJson(json.decode(str));

String moviesToJson(Movie data) => json.encode(data.toJson());

class Movie {
  double score;
  Show show;

  Movie({
    this.score,
    this.show,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        score: json["score"].toDouble(),
        show: Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "show": show.toJson(),
      };
}







