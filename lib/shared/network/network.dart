import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

FirebaseAuth auth = FirebaseAuth.instance;

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
  User user = auth.currentUser;
  print(user.email);
}
