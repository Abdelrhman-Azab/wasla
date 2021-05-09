import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:wasla/models/Appuser.dart';
import 'package:wasla/shared/components/globalVariables.dart';

Future<dynamic> getRequest(Uri url) async {
  http.Response response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return "Failed";
    }
  } catch (e) {
    return "Failed";
  }
}

getUserInfo() {
  auth = FirebaseAuth.instance;
  user = auth.currentUser;
  FirebaseDatabase.instance
      .reference()
      .child("users/${user.uid}")
      .once()
      .then((DataSnapshot dataSnapshot) {
    appUser = AppUser.fromSnapshot(dataSnapshot);
    print(appUser.email);
  });
}
