import 'package:finlearn/consts/colors.dart';
import 'package:finlearn/pages/child/child_login_page.dart';
import 'package:finlearn/pages/parent/parent_home.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with WidgetsBindingObserver {
  bool isLoading = false;
  final introKey = GlobalKey<IntroductionScreenState>();
  Future onResumeHandleDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      _handleDynamicLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  Future initDynamicLinks(BuildContext context) async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDynamicLink(data);
  }

  Future<void> _handleDynamicLink(PendingDynamicLinkData data) async {
    final deepLink = data?.link;
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        final parentId = queryParams['parentId'];
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => ChildLogin(
              parentId: parentId,
            ),
          ),
          (route) => false,
        );
      } else {}
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initDynamicLinks(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResumeHandleDynamicLink();
    }
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('images/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = GoogleFonts.firaSans(fontSize: 19.0, color: kBluePurple);
    final pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: kBluePurple,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: kBluePurple,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
          key: introKey,
          pages: [
            PageViewModel(
              title: "FinLearn",
              body: "Learn about managing finance\nby earning rewards.",
              image: _buildImage('bank.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Make your kids better",
              body:
                  "Motivate your kids to complete chores by giving them rewards",
              image: _buildImage('slider4.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Real world learning",
              body:
                  "FinCoins show patterns similar to Fiat like inflation etc.",
              image: _buildImage('slider2.jpg'),
              decoration: pageDecoration,
              footer: isLoading
                  ? CircularProgressIndicator()
                  : OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: kBluePurple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await _signInWithGoogle();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => ParentHome()),
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
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        "Get Started!",
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ],
          next: const Text("Next",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: kBluePurple,
              )),
          done: null,
          onDone: () {
            // When done button is press
          },
        ),
      ),
    );
  }
}

Future<UserCredential> _signInWithGoogle() async {
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
  await saveUserToDB();
  return userCredential;
}

Future saveUserToDB() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final uri = await createDynamicLink(currentUser.uid);
  FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
    'name': currentUser.displayName,
    'referLink': uri.toString(),
    'uid': currentUser.uid,
    'photoURL': currentUser.photoURL,
    'isParent': true
  });
}

Future<Uri> createDynamicLink(String uid) async {
  print(uid);
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://finlearnapp.page.link',
    link: Uri.parse('https://prachar-5c6b7.web.app/?parentId=$uid'),
    androidParameters: AndroidParameters(
      packageName: 'com.example.finlearn',
      minimumVersion: 1,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.example.finlearn',
      minimumVersion: '1',
      appStoreId: 'com.example.finlearn',
    ),
  );
  var dynamicUrl = await parameters.buildShortLink();
  return dynamicUrl.shortUrl;
}
