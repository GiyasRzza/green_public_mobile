import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_public_mobile/page/MainPage.dart';
import 'package:green_public_mobile/provider/StoreProvider.dart';
import 'package:green_public_mobile/provider/TreeProvider.dart';
import 'package:green_public_mobile/provider/WeatherProvider.dart';
import 'package:mappable_maps_mapkit_lite/init.dart' as init;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.initMapkit(
      apiKey: 'pk_yaZBUVpudIkqBnOmAaljgzwLjfRSSWjEncXLesvEfRYYnLBqIuVlQOOmemlJNHsN'
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => TreeProvider()),
        ChangeNotifierProvider(create: (_) =>StoreProvider()),
      ],
      child: MaterialApp(
        title: 'Green Public',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Green Public'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.lightGreen[100]?.withOpacity(0.9999),
      body: Stack(
        children: [
          Image.asset(
            'images/oneTwoLoader.gif',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),

        ],
      ),
    );
  }


}
