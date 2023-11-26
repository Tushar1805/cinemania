import 'package:flutter/material.dart';
import 'package:quadb_tech/Data/movie_module.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Screens/search.dart';
import 'homePage.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key key}) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  bool _dataLoaded = false;
  var index = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await context.read<MovieProvider>().list();
    setState(() {
      _dataLoaded = true;
    });
  }

  final buildBody = const <Widget>[
    HomeScreen(key: PageStorageKey('homescreen')),
    SearchScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Movie selected = context.watch<MovieProvider>().selected;

    return Scaffold(
      body: _dataLoaded
          ? buildBody[index]
          : Center(
              child:
                  CircularProgressIndicator()), // Show a loader while data is being fetched
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        unselectedItemColor: Colors.white,
        currentIndex: index,
        onTap: (index) async {
          setState(() {
            this.index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
