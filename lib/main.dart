import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_public_mobile/page/first/first_page.dart';
import 'package:green_public_mobile/page/map/map_page.dart';
import 'package:green_public_mobile/page/register/profile_page.dart';
import 'package:green_public_mobile/page/register/register_page.dart';
import 'package:green_public_mobile/provider/PlacemarkProvider.dart';
import 'package:green_public_mobile/provider/StoreProvider.dart';
import 'package:green_public_mobile/provider/TreeProvider.dart';
import 'package:green_public_mobile/provider/WeatherProvider.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as init;
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.initMapkit(
      apiKey: 'pk_WSVzAEZzqvWXnmCfWXsWKkXiSMIEXAuapaUCBQSlbtQcJRCHYvvBTEqerdzkAlBZ'
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
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => PlacemarkProvider()),
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
  final QuickActions quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();

    quickActions.setShortcutItems([
      const ShortcutItem(
          type: 'action_map', localizedTitle: 'Map', icon: 'AppIcon',),
      const ShortcutItem(
          type: 'action_event', localizedTitle: 'Event', icon: 'AppIcon'),
      const ShortcutItem(
          type: 'action_profile', localizedTitle: 'Profile', icon: 'AppIcon'),
    ]);

    quickActions.initialize((String shortcutType) {
      if (shortcutType == 'action_map') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MapPage()));
      } else if (shortcutType == 'action_event') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const RegisterPage()));
      } else if (shortcutType == 'action_profile') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ProfilePage()));
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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