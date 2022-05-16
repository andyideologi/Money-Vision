// ignore_for_file: avoid_print

import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/screens/logo_screen.dart';
import 'package:franchise/screens/onboarding_screen.dart';
import 'package:franchise/widgets/spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool status = sharedPreferences.getBool("isLoggedIn") ?? false;
  await Firebase.initializeApp();
  runApp(MyApp(whereToGo: status));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.whereToGo}) : super(key: key);
  final bool whereToGo;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      title: 'Franchise',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: whereToGo ? const LogoScreen() : OnBoardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
