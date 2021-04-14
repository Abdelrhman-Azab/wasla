import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/home/home_screen.dart';
import 'package:wasla/screens/login/cubit/cubit.dart';
import 'package:wasla/screens/login/cubit/states.dart';
import 'package:wasla/screens/registration/sign_up_screen.dart';
import 'package:wasla/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login';
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  GlobalKey<ScaffoldState> loginScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginStateLoading) {
          showDialog(
            context: context,
            builder: (context) => progressDialog("Logging you in..."),
          );
        }
        if (state is LoginStateFailed) {
          Navigator.of(context).pop();
        }
        if (state is LoginStateSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: loginScaffoldKey,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Image(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        image: AssetImage("images/logo.png"),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Sign In as Rider",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      myTextFormField(
                          hintText: "Email address",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller),
                      myTextFormField(
                          hintText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordcontroller,
                          password: true),
                      myLoginButton(
                          text: "LOGIN",
                          function: () async {
                            print("logggg");
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            print(connectivityResult);

                            if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                connectivityResult != ConnectivityResult.wifi) {
                              showInSnackBar(
                                  "Intenet is not connected", loginScaffoldKey);
                              return;
                            }
                            if (!emailcontroller.text.contains("@")) {
                              showInSnackBar(
                                  "Please enter a vaild email Address",
                                  loginScaffoldKey);
                              return;
                            }
                            if (passwordcontroller.text.length < 8) {
                              showInSnackBar("Please enter a vaild password",
                                  loginScaffoldKey);
                              return;
                            }
                            LoginCubit.get(context).login(
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                                scaffoldKey: loginScaffoldKey);
                          }),
                      TextButton(
                          style:
                              TextButton.styleFrom(primary: Colors.grey[900]),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, SignUpScreen.id, (route) => false);
                          },
                          child: Text("Don't have an account ? sign up here "))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
