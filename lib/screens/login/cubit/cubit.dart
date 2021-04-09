import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/login/cubit/states.dart';
import 'package:wasla/shared/components/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStateInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  login({@required String email, @required String password}) async {
    emit(LoginStateLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(LoginStateFailed());
        showInSnackBar('No user found for that email.');
        return;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(LoginStateFailed());
        showInSnackBar('Wrong password provided for that user.');
        return;
      }
    }
    emit(LoginStateSuccess());
    print("Sucess");
  }
}
