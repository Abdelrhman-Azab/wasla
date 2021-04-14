import 'package:flutter/material.dart';
import 'package:wasla/style/brand_colors.dart';

Widget myTextFormField(
        {@required String hintText,
        @required TextInputType keyboardType,
        TextEditingController controller,
        bool password = false}) =>
    Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: password,
        keyboardType: keyboardType,
        decoration: InputDecoration(hintText: hintText),
      ),
    );

Widget myLoginButton({@required String text, @required Function function}) =>
    Container(
      height: 85,
      padding: EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: BrandColors.colorGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: function,
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontFamily: "Bolt-Semibold"),
        )),
      ),
    );

void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState
      // ignore: deprecated_member_use
      .showSnackBar(new SnackBar(content: new Text(value)));
}

Widget progressDialog(String status) => Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: 70,
        width: double.infinity,
        margin: EdgeInsets.all(15),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),
            ),
            SizedBox(
              width: 25,
            ),
            Text(status)
          ],
        ),
      ),
    );
