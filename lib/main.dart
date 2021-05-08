import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/home/cubit/cubit.dart';
import 'package:wasla/screens/home/home_screen.dart';
import 'package:wasla/screens/login/cubit/cubit.dart';
import 'package:wasla/screens/login/login_screen.dart';
import 'package:wasla/screens/registration/cubit/cubit.dart';
import 'package:wasla/screens/registration/sign_up_screen.dart';
import 'package:bloc/bloc.dart' as mainbloc;
import 'package:wasla/screens/search/cubit/cubit.dart';
import 'package:wasla/screens/search/search_screen.dart';
import 'shared/bloc_ovserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  mainbloc.Bloc.observer = MyBlocObserver();
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
        BlocProvider(create: (BuildContext context) => LocationCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Bolt-Regular",
        ),
        home: LoginScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          SearchScreen.id: (context) => SearchScreen(),
        },
      ),
    );
  }
}

final controller = StreamController();
