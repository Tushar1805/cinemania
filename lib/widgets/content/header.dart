import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Data/movie_module.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:quadb_tech/widgets/buttons/icon.dart';
import '../../screens/details.dart';

class ContentHeader extends StatelessWidget {
  final Movie featured;

  const ContentHeader({Key key, @required this.featured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<MovieProvider>().imageFor(featured, 1),
        builder: (context, snapshot) {
          if (snapshot.hasData == false || snapshot.data == null) {
            return const SizedBox(
              height: 500,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Stack(alignment: Alignment.center, children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.memory((snapshot.data as Uint8List)).image,
                ),
              ),
            ),
            Container(
              height: 500,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              child: SizedBox(
                  width: 250,
                  child: Text(
                    featured.show.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Positioned(
              bottom: 88,
              child: SizedBox(
                  width: 250,
                  child: Text(
                    featured.show.type.replaceAll(", ", " • "),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  VerticalIconButton(
                    icon: Icons.add,
                    title: 'Watchlist',
                    tap: () {},
                  ),
                  const SizedBox(width: 40),
                  MaterialButton(
                      color: Colors.white,
                      child: Row(
                        children: const [Icon(Icons.play_arrow), Text("Play")],
                      ),
                      onPressed: () {}),
                  const SizedBox(width: 40),
                  VerticalIconButton(
                    icon: Icons.info,
                    title: 'Info',
                    tap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) => DetailsScreen(movie: featured));
                    },
                  ),
                  const Spacer(),
                ],
              ),
            )
          ]);
        });
  }
}
