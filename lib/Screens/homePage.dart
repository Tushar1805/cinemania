import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:quadb_tech/widgets/content/bar.dart';
import 'package:quadb_tech/widgets/content/header.dart';
import 'package:quadb_tech/widgets/content/list.dart';
import 'package:quadb_tech/widgets/previews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({@required Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 70.0),
        child: ContentBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
                featured: context.watch<MovieProvider>().selected),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ContentList(
                title: 'Only on Cinemania',
                contentList: context.watch<MovieProvider>().movies,
                isOriginal: false,
                rounded: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
