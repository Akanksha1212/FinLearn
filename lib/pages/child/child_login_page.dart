import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:finlearn/pages/child/child_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChildLogin extends StatefulWidget {
  final String parentId;

  const ChildLogin({Key key, @required this.parentId}) : super(key: key);
  @override
  _ChildLoginState createState() => _ChildLoginState();
}

class _ChildLoginState extends State<ChildLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBluePurple ?? Color(0xffeed59a),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Parent has invited you to join",
                style:
                    GoogleFonts.firaSans(fontSize: 19.0, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "FinLearn",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white ?? kBluePurple,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.parentId)
                    .get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            data['photoURL'],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data['name'],
                          style: GoogleFonts.firaSans(
                              fontSize: 25.0,
                              color: Colors.white ?? kBluePurple),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white ?? kBluePurple,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            try {
                              await _signInWithGoogle(widget.parentId);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => ChildHome()),
                                  (route) => false);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Accept Invitation!",
                            style: GoogleFonts.playfairDisplay(
                              color: kBluePurple ?? Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else
                    return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> _signInWithGoogle(String parentId) async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  await saveChildToDB(parentId);
  return userCredential;
}

Future saveChildToDB(String parentId) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
    'name': currentUser.displayName,
    'parentId': parentId,
    'uid': currentUser.uid,
    'photoURL': currentUser.photoURL,
    'isParent': false
  });
}
