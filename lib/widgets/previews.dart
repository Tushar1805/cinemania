import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Data/movie_module.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:quadb_tech/Screens/details.dart';

class Previews extends StatefulWidget {
  final String title;

  const Previews({Key key, @required this.title});

  @override
  State<Previews> createState() => _PreviewsState();
}

class _PreviewsState extends State<Previews> {
  Widget _renderStack(Movie movie) {
    return FutureBuilder(
        future: context.watch<MovieProvider>().imageFor(movie, 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 130,
              width: 130,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              snapshot.hasData && snapshot.data != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.memory((snapshot.data as Uint8List))
                                .image,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withAlpha(40), width: 4.0)),
                    )
                  : const CircularProgressIndicator(),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Colors.black87,
                    Colors.black45,
                    Colors.transparent
                  ], stops: [
                    0,
                    0.25,
                    1
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.white.withAlpha(40), width: 4.0),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                    height: 60,
                    child: Text(
                      movie.show.name.length > 14
                          ? movie.show.name.substring(0, 14)
                          : movie.show.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var entries = context.watch<MovieProvider>().movies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Popular this week',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 165.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie entry = entries[index];

                return GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => DetailsScreen(movie: entry));
                  },
                  child: _renderStack(entry),
                );
              }),
        ),
      ],
    );
  }
}
