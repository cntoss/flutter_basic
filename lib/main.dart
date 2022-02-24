// Flutter imports:

import 'package:flutter/material.dart';
import 'package:glimo/home/ui/screen/home_page.dart';
import 'package:glimo/login/ui/login.dart';

// Project imports:

import 'common/app_config.dart';

import 'service/locator.dart';
import 'splash/splash_screen.dart';

void main() async {
  setLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.black,
      builder: (context, child) => const Glimo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Glimo extends StatefulWidget {
  const Glimo({Key? key}) : super(key: key);

  @override
  _GlimoState createState() => _GlimoState();
}

class _GlimoState extends State<Glimo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppConfig.navigatorKey,
      home: const SplashScreen(),
      initialRoute: '/',

      // onGenerateRoute: RouteGenerator.generateRoute,

      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
