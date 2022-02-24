// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../../environments/envConfig.dart';
import '../common/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  static const String id = 'splash_page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isOffline = false;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await EnvConfig.initialize();

    var token = sharedPreferences.getString(tokenKey);
    if (token != null) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Navigator.of(context).pushReplacementNamed(
          '/home',
        ),
      );
    } else {
      Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FlutterLogo(
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'Welcome to Glimo',
                style: TextStyle(
                  color: Colors.pink[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
