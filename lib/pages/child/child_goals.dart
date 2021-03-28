import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChildGoal extends StatefulWidget {
  @override
  _ChildGoalState createState() => _ChildGoalState();
}

class _ChildGoalState extends State<ChildGoal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                'My Goals',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  // fontWeight: FontWeight.bold,
                  color: kBluePurple,
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
                  color: kBluePurple,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9.0, horizontal: 15),
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
                                        child: Text(
                                          '\$ $taskReward',
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
      ),
    );
  }
}
