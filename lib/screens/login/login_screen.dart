import 'package:flutter/material.dart';
import 'package:wasla/shared/components/components.dart';
import 'package:wasla/style/brand_colors.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  myTextFormField(
                      hintText: "Email address",
                      keyboardType: TextInputType.emailAddress),
                  myTextFormField(
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      password: true),
                  Container(
                    height: 85,
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: BrandColors.colorGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Center(
                          child: Text(
                        "LOGIN",
                        style: TextStyle(fontFamily: "Bolt-Semibold"),
                      )),
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(primary: Colors.grey[900]),
                      onPressed: () {},
                      child: Text("Don't have an account ? sign up here "))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
