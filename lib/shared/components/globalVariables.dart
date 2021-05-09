import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wasla/models/Appuser.dart';
import 'package:wasla/models/address.dart';

AppUser appUser;
FirebaseAuth auth;
User user;

DatabaseReference rideref =
    FirebaseDatabase.instance.reference().child("ride_request").push();
