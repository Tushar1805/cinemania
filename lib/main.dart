import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_tech/Provider/movieProvider.dart';
import 'package:quadb_tech/Screens/splashScreen.dart';
import 'Screens/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MovieProvider()),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinemania',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Future.wait([
          context.read<MovieProvider>().isValid(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return context.watch<MovieProvider>().splash
                ? const SplashScreen()
                : const NavScreen();
          }
        },
      ),
    );
  }
}
