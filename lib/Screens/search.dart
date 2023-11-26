import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Data/movie_module.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:quadb_tech/widgets/buttons/icon.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _row(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<Uint8List>(
          future: context.read<MovieProvider>().imageFor(movie, 0),
          builder: (context, snapshot) =>
              snapshot.hasData && snapshot.data != null
                  ? Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: Image.memory(snapshot.data).image,
                        ),
                      ),
                    )
                  : Container(),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.show.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              (movie.show.summary ?? ""),
              maxLines: 2,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
          child: VerticalIconButton(
              icon: Icons.movie,
              title: '',
              tap: () {
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    Future<void> updateList(String text) async {
      await provider.filter(text);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Search for a movie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (text) {
                    updateList(text);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff2B2B2B),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      hintText: "eg: All Rise",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: provider.filterList.length,
                  itemBuilder: (context, index) =>
                      _row(provider.filterList[index]),
                ))
              ],
            )),
      ),
    );
  }
}
