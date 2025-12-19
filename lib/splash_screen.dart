import 'dart:async';

import 'package:assignment_5/home_screen.dart';
import 'package:assignment_5/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// final storage = FlutterSecureStorage();
bool userIsLoggedIn = false;
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 75,
    colors: true,
    printEmojis: true,
    // ignore: deprecated_member_use
    printTime: true,
  ),
);

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    homeOrLogin();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Unregister the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Handle this case
        logger.d("resumed");

        homeOrLogin();
        WidgetsBinding.instance.addObserver(this);
        break;
      case AppLifecycleState.inactive:
        // Handle this case
        break;
      case AppLifecycleState.paused:
        // Handle this case
        break;
      case AppLifecycleState.detached:
        // Handle this case
        break;
      case AppLifecycleState.hidden:
      // Handle this case.
    }
  }

  Future<void> homeOrLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userIsLoggedIn = prefs.containsKey("loggedIn");

    Timer(Duration(seconds: 10), () {
      if (userIsLoggedIn) {
        String? user = prefs.getString("loggedInUser").toString();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreenPage(loggedUser: user),
          ),
        );
      } else {
        // Call setState() or update state here

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Image.asset("images/of_logo.jpg")),
      ),
    );
  }
}
