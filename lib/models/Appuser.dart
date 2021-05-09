import 'package:firebase_database/firebase_database.dart';

class AppUser {
  String name;
  String email;
  String id;
  String phone;

  AppUser({this.email, this.id, this.name, this.phone});

  AppUser.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    email = snapshot.value['email'];
    phone = snapshot.value['phone'];
    name = snapshot.value['fullname'];
  }
}
