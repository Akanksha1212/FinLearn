import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';

import '../intro_page.dart';

class ParentHome extends StatefulWidget {
  @override
  _ParentHomeState createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot> getParentData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBluePurple,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(currentUser.photoURL),
              ),
            ),
            ListTile(
              title: Text(currentUser.displayName),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('parentId', isEqualTo: currentUser.uid)
                .snapshots(),
            builder:
                (BuildContext cosntext, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data.docChanges.isNotEmpty) {
                final data = snapshot.data;
                return Text(data.toString());
              } else
                return Container(
                  child: Text("Your kids have not joined yet."),
                );
            },
          ),
          Container(
            child: Center(
              child: FutureBuilder(
                future: getParentData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final dynamicLinkUrl = snapshot.data['referLink'];
                    return ElevatedButton(
                      onPressed: () {
                        Share.share(
                            'Hey, Join this app and you will earn rewards.\n Download Now -$dynamicLinkUrl');
                      },
                      child: Text("Invite Your Kids"),
                    );
                  } else
                    return CircularProgressIndicator();
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => IntroPage(),
                  ),
                  (route) => false);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
