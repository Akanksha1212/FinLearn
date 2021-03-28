import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:finlearn/pages/parent/add_chores_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: kBluePurple,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBluePurple,
      ),
      drawer: MyDrawer(currentUser: currentUser),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('parentId', isEqualTo: currentUser.uid)
                .snapshots(),
            builder:
                (BuildContext cosntext, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data.docChanges.isNotEmpty) {
                final data = snapshot.data.docs[0];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Your FinKid",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(data['photoURL'].toString()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data['name'],
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              } else
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20,
                        ),
                        child: Text(
                          "Your FinKid has not joined yet.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20,
                        ),
                        child: FutureBuilder(
                          future: getParentData(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              final dynamicLinkUrl = snapshot.data['referLink'];
                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 90, vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onPressed: () {
                                  Share.share(
                                      'Hey, Download this app and you will earn rewards.\n Download Now -$dynamicLinkUrl');
                                },
                                child: Text(
                                  "Invite Your FinKid!",
                                  style: GoogleFonts.playfairDisplay(
                                    color: kBluePurple ?? Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            } else
                              return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ],
                  ),
                );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                "Chores",
                style: GoogleFonts.playfairDisplay(
                    color: Colors.white, fontSize: 45),
              ),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .orderBy('creationTime', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final data = snapshot.data.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final task = data[index];
                          final isComplete = task['isCompleted'];
                          final taskTitle = task['title'];
                          final taskReward = task['rewardValue'];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 25,
                            ),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9.0, horizontal: 15),
                                      child: isComplete
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            )
                                          : Icon(Icons.alarm),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      taskTitle,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Expanded(child: Container()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9.0, horizontal: 15),
                                      child: Text('\$ $taskReward'),
                                    )
                                  ],
                                ),
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    25,
                                  ),
                                  color: isComplete
                                      ? Colors.greenAccent.shade100
                                      : Colors.yellow.shade100,
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else
                  return CircularProgressIndicator();
              } else
                return CircularProgressIndicator();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddChoresPage()));
        },
        label: Text(
          "Add Chores",
          style: TextStyle(
            color: kBluePurple,
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
    @required this.currentUser,
  }) : super(key: key);

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              radius: 40,
              foregroundImage: NetworkImage(currentUser.photoURL),
              backgroundImage: NetworkImage(currentUser.photoURL),
            ),
          ),
          ListTile(
            title: Text(
              currentUser.displayName,
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text(
              "Logout",
              textAlign: TextAlign.center,
            ),
            onTap: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => IntroPage(),
                  ),
                  (route) => false);
            },
          )
        ],
      ),
    );
  }
}
