import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/home/home_screen.dart';
import 'package:wasla/screens/login/login_screen.dart';
import 'package:wasla/screens/registration/cubit/cubit.dart';
import 'package:wasla/screens/registration/cubit/states.dart';
import 'package:wasla/shared/components/components.dart';
import 'package:connectivity/connectivity.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'signup';
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterStateLoading) {
          showDialog(
            context: context,
            builder: (context) => progressDialog("Registering you..."),
          );
        }
        if (state is RegisterStateFailed) {
          Navigator.of(context).pop();
        }
        if (state is RegisterStateSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      image: AssetImage("images/logo.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create a Rider's Account",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    myTextFormField(
                        hintText: "Full name",
                        keyboardType: TextInputType.name,
                        controller: fullNameController),
                    myTextFormField(
                        hintText: "Email address",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController),
                    myTextFormField(
                        hintText: "Phone number",
                        keyboardType: TextInputType.phone,
                        controller: phoneController),
                    myTextFormField(
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        password: true,
                        controller: passowrdController),
                    myLoginButton(
                        text: "REGISTER",
                        function: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          print(connectivityResult);

                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showInSnackBar("Intenet is not connected");
                            return;
                          }

                          if (fullNameController.text.length < 5) {
                            showInSnackBar("Please enter a vaild full name");
                            return;
                          }
                          if (!emailController.text.contains("@")) {
                            showInSnackBar(
                                "Please enter a vaild email Address");
                            return;
                          }
                          if (phoneController.text.length < 10) {
                            showInSnackBar("Please enter a vaild phone number");
                            return;
                          }
                          if (passowrdController.text.length < 8) {
                            showInSnackBar("Please enter a vaild password");
                            return;
                          }

                          RegisterCubit.get(context).register(
                            name: fullNameController.text,
                            email: emailController.text,
                            password: passowrdController.text,
                            phone: phoneController.text,
                          );
                        }),
                    TextButton(
                        style: TextButton.styleFrom(primary: Colors.grey[900]),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.id, (route) => false);
                        },
                        child: Text("Already have a RIDER account ? Login"))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
