import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasla"),
      ),
      body: Center(
          child: MaterialButton(
              color: Colors.green,
              child: Text("TEST"),
              onPressed: () {
                print("YES");
                DatabaseReference dbrf =
                    FirebaseDatabase.instance.reference().child("testtt");
                dbrf.set("Is yes");
              })),
    );
  }
}
