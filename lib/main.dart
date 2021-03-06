import 'package:finlearn/consts/colors.dart';
import 'package:finlearn/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bottomNav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: kBluePurple,
        textTheme: GoogleFonts.firaSansTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
