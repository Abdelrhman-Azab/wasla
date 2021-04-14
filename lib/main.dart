import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/home/home_screen.dart';
import 'package:wasla/screens/login/cubit/cubit.dart';
import 'package:wasla/screens/login/login_screen.dart';
import 'package:wasla/screens/registration/cubit/cubit.dart';
import 'package:wasla/screens/registration/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Bolt-Regular",
          primarySwatch: Colors.blue,
        ),
        home: SignUpScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen()
        },
      ),
    );
  }
}

final controller = StreamController();
