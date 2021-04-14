import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wasla/screens/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("waslten"),
      ),
      body: Center(
          child: MaterialButton(
              color: Colors.green,
              child: Text("TEST"),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
              })),
    );
  }
}
