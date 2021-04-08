import 'package:flutter/material.dart';

Widget myTextFormField(
        {@required String hintText,
        @required TextInputType keyboardType,
        bool password = false}) =>
    Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: TextFormField(
        obscureText: password,
        keyboardType: keyboardType,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
