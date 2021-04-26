import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wasla/main.dart';
import 'package:wasla/shared/network/network.dart';
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

Widget myListTile({@required IconData iconData, @required String title}) =>
    ListTile(
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );

Widget searchListContainer(
        {@required String mainText,
        @required String secondaryText,
        @required String placeid,
        @required Function onPressed}) =>
    TextButton(
      style: TextButton.styleFrom(primary: Colors.black),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(
              OMIcons.locationOn,
              color: Colors.grey[700],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mainText == null ? "new place" : mainText),
                  Text(
                    secondaryText == null ? " " : secondaryText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
