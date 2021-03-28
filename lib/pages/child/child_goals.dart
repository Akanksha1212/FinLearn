import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChildGoal extends StatefulWidget {
  @override
  _ChildGoalState createState() => _ChildGoalState();
}

class _ChildGoalState extends State<ChildGoal> {
  @override
  Widget build(BuildContext context) {
    final kidsFirstName =
        FirebaseAuth.instance.currentUser.displayName.split(' ')[0];
    return SafeArea(
      child: Container(
        color: kBluePurple,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child:
                  SizedBox(height: 120, child: Image.asset('images/giphy.gif')),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                '$kidsFirstName\'s Goals',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Today',
                style: TextStyle(
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .orderBy('creationTime', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                        padding: const EdgeInsets.only(
                                            top: 9.0, bottom: 9, left: 10),
                                        child: Checkbox(
                                            value: isComplete,
                                            onChanged: (val) {
                                              FirebaseFirestore.instance
                                                  .collection('tasks')
                                                  .doc(task.id)
                                                  .update({
                                                'isCompleted': !isComplete
                                              });
                                            }),
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text(
                                        taskTitle,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kBluePurple,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Image.asset(
                                            'images/mario_coin.png'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 9, top: 9.0, right: 15),
                                        child: Text(
                                          '$taskReward',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
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
                                        : Color(0xffE0CAF7),
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
      ),
    );
  }
}
