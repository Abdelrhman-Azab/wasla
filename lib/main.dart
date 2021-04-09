import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/home/home_screen.dart';
import 'package:wasla/screens/login/cubit/cubit.dart';
import 'package:wasla/screens/login/login_screen.dart';
import 'package:wasla/screens/registration/cubit/cubit.dart';
import 'package:wasla/screens/registration/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
            appId: '1:583530748642:android:4b363f3428ffd0d0c11cbb',
            apiKey: 'AIzaSyCKrg7hsVuWdlWI_0sMhwdtw0Cn9o5rNMQ',
            projectId: 'wasla-7720c',
            messagingSenderId: '297855924061',
            databaseURL: 'https://wasla-7720c-default-rtdb.firebaseio.com',
          )
        : const FirebaseOptions(
            appId: '1:583530748642:android:4b363f3428ffd0d0c11cbb',
            apiKey: 'AIzaSyCKrg7hsVuWdlWI_0sMhwdtw0Cn9o5rNMQ',
            messagingSenderId: '297855924061',
            projectId: 'wasla-7720c',
            databaseURL: 'https://wasla-7720c-default-rtdb.firebaseio.com',
          ),
  );
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
