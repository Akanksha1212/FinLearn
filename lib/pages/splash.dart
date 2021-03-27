import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/pages/intro_page.dart';
import 'package:finlearn/pages/parent/parent_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bottomNav.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser == null
        ? IntroPage()
        : FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                bool isParent = snapshot.data['isParent'] as bool;
                return isParent ? ParentHome() : BottomNav();
              } else
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            },
          );
  }
}
