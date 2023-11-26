import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quadb_tech/Data/movie_module.dart';

class MovieProvider extends ChangeNotifier {
  Future<void> initMethods() async {
    await list();
    await isValid();
  }

  Map<String, Uint8List> _imageCache = {};
  bool splash = true;

  Movie _selected;
  Movie get selected => _selected;

  List<Movie> movieList = [];
  List<Movie> filterList = [];
  List<Movie> get movies => movieList;
  List<Movie> get filteredList => filterList;

  void setSelected(Movie movie) {
    _selected = movie;

    notifyListeners();
  }

  Future<void> list() async {
    var request = http.Request(
        'GET', Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      String responseBody = await streamedResponse.stream.bytesToString();
      print(responseBody);

      // Decode the JSON into a dynamic object
      List<dynamic> jsonList = json.decode(responseBody);

      // Convert each show in the list to a Movie object
      movieList =
          List<Movie>.from(jsonList.map((json) => Movie.fromJson(json)));
      _selected = movieList[0];
    } else {
      print(streamedResponse.reasonPhrase);
    }
    notifyListeners();
  }

  Future<void> filter(var search) async {
    var request = http.Request(
        'GET', Uri.parse('https://api.tvmaze.com/search/shows?q=$search'));

    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      String responseBody = await streamedResponse.stream.bytesToString();
      print(responseBody);

      // Decode the JSON into a dynamic object
      List<dynamic> jsonList = json.decode(responseBody);

      // Convert each show in the list to a Movie object
      filterList =
          List<Movie>.from(jsonList.map((json) => Movie.fromJson(json)));
    } else {
      print(streamedResponse.reasonPhrase);
    }
    notifyListeners();
  }

  Future<void> isValid() async {
    await Future.delayed(Duration(seconds: 3));
    splash = false;
    notifyListeners();
  }

  Future<Uint8List> imageFor(Movie movie, size) async {
    // Size: 0 - small, 1 large
    String imageUrl;
    if (size == 0) {
      imageUrl = movie.show.image.medium;
    } else {
      imageUrl = movie.show.image.original;
    }

    if (_imageCache.containsKey(imageUrl)) {
      return _imageCache[imageUrl];
    }
    // Fetch the image from the network
    http.Response response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      Uint8List imageBytes = response.bodyBytes;
      _imageCache[imageUrl] = imageBytes;
      return imageBytes;
    } else {
      // Handle error, return a default image, or throw an exception
      print('Failed to load image: ${response.statusCode}');
      return Uint8List(0); // Return an empty Uint8List for simplicity
    }
  }
}
