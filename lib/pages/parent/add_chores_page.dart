import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finlearn/consts/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddChoresPage extends StatefulWidget {
  @override
  _AddChoresPageState createState() => _AddChoresPageState();
}

class _AddChoresPageState extends State<AddChoresPage> {
  final TextEditingController taskNameTEC = TextEditingController();
  final TextEditingController rewardValueTEC = TextEditingController();
  double sliderValue = 50;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kBluePurple))
            : FloatingActionButton.extended(
                onPressed: () {
                  saveChoreToDB();
                },
                backgroundColor: kBluePurple,
                label: Text(
                  "Add Chores",
                ),
              ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Form(
                child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ListView(
                    children: [
                      Center(
                        child: TextFormField(
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 25,
                            ),
                            hintText: "Enter new Task",
                            border: InputBorder.none,
                          ),
                          controller: taskNameTEC,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Slider(
                        activeColor: kBluePurple,
                        value: sliderValue,
                        onChanged: (val) {
                          setState(() {
                            sliderValue = val;
                          });
                        },
                        max: 100,
                        min: 10,
                      ),
                      Center(
                          child: Text(
                        'Reward Value: ${sliderValue.ceil()} FinCoins',
                        style: TextStyle(fontSize: 20),
                      ))
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future saveChoreToDB() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance.collection('tasks').doc().set({
        'title': taskNameTEC.text,
        'rewardValue': sliderValue.ceil(),
        'isCompleted': false,
        'assignedTo': 'uid',
        'createdBy': FirebaseAuth.instance.currentUser.uid,
        'creationTime': Timestamp.now()
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }
}
