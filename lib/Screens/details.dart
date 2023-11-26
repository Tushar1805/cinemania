import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Data/movie_module.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:quadb_tech/widgets/buttons/icon.dart';

class DetailsScreen extends StatefulWidget {
  final Movie _movie;

  DetailsScreen({Key key, Movie movie})
      : _movie = movie,
        super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DetailHeader(featured: widget._movie),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Expanded(
            child: Text(widget._movie.show.summary.toString() ?? "",
                maxLines: 3,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          child: Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text("Genres: ${widget._movie.show.genres.join(', ')}",
                style: const TextStyle(fontSize: 12, color: Colors.white)),
          )),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            VerticalIconButton(
                icon:  Icons.add,
                title: "My List",
                tap: () {
                  Navigator.of(context).pop();
                }),
            const Spacer(),
            VerticalIconButton(icon: Icons.thumb_up, title: "Rate", tap: () {}),
            const Spacer(),
            VerticalIconButton(icon: Icons.share, title: "Share", tap: () {}),
            const Spacer(),
          ],
        )),
        const Spacer(),
      ],
    ));
  }
}

class _DetailHeader extends StatelessWidget {
  final Movie featured;

  const _DetailHeader({Key key, @required this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<MovieProvider>().imageFor(featured, 0),
        builder: (context, snapshot) {
          if (snapshot.hasData == false || snapshot.data == null) {
            return const SizedBox(
              height: 500,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.memory((snapshot.data as Uint8List)).image,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      height: 500,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
                Positioned(
                    top: 1,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
                Positioned(
                    bottom: 160,
                    child: Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              Image.memory((snapshot.data as Uint8List)).image,
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            featured.show.language == null
                                ? featured.show.language.toString()
                                : "English",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            featured.show.premiered == null
                                ? "2020"
                                : featured.show.premiered.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: Colors.black.withAlpha(180),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            featured.show.type,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "${(featured.show.runtime / 60).floor().toStringAsFixed(2).replaceAll('.', ' h ')} m",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: 10,
                    right: 10,
                    left: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                            color: Colors.white,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.play_arrow),
                                SizedBox(width: 8),
                                Text("Play")
                              ],
                            )),
                        MaterialButton(
                            color: Colors.white.withAlpha(40),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Download",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ],
                    ))
              ]);
        });
  }
}
