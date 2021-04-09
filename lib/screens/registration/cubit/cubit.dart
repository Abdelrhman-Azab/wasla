import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/registration/cubit/states.dart';
import 'package:wasla/shared/components/components.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterStateInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  static FirebaseAuth auth = FirebaseAuth.instance;

  register(
      {@required String email,
      @required String password,
      @required String phone,
      @required String name}) async {
    emit(RegisterStateLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      emit(RegisterStateFailed());

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showInSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showInSnackBar('The account already exists for that email.');
      }
      return;
    } catch (e) {
      emit(RegisterStateFailed());
      showInSnackBar(e);
      print(e);
      return;
    }
    emit(RegisterStateSuccess());

    DatabaseReference newDbRef = FirebaseDatabase.instance
        .reference()
        .child("users/${auth.currentUser.uid}");
    Map userMap = {"fullname": name, "email": email, "phone": phone};
    newDbRef.set(userMap);
  }
}
