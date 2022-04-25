// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/screens/login_page.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/widgets/customDropDown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../Networking/api_calling.dart';

class ServicePage extends StatelessWidget {

  TextEditingController oldpass = TextEditingController(), newpass = TextEditingController(), conpass = TextEditingController();
  ServicePage({Key? key}) : super(key: key);

  void LogOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
      return LoginPage();
    }), (route) => false);
  }

  void displayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text("Confirm logout"),
          content: Text("Do you sure you want to Logout ?"),
          actions: [
            TextButton(
                onPressed: () {
                  LogOut(context);
                },
                child: Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"))
          ]),
    );
  }

  void DisplayChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text("Update Password"),
          actions: [
            Form(
                child: Padding(padding: EdgeInsets.all(10),
                child: Column(
              children: [TextFormField(
                obscureText: true,
                decoration:  InputDecoration(
                  labelText: "Old Password",

                  labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w100),
                  // suffixIcon: _clearIconButton(_passwordController),
                  prefixStyle: TextStyle(
                      color: Colors.black, fontSize: 10),
                ),
                controller: oldpass,
              ),
                TextFormField(
                  obscureText: true,
                  decoration:  InputDecoration(
                    labelText: "New Password",

                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100),
                    // suffixIcon: _clearIconButton(_passwordController),
                    prefixStyle: TextStyle(
                        color: Colors.black, fontSize: 10),
                  ),
                  controller: newpass,
                ),
                TextFormField(
                  obscureText: true,
                  decoration:  InputDecoration(
                    labelText: "Confirm New Password",

                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100),
                    // suffixIcon: _clearIconButton(_passwordController),
                    prefixStyle: TextStyle(
                        color: Colors.black, fontSize: 10),
                  ),
                  controller: conpass,
                ),

                TextButton(onPressed: () async {
                  FocusScope.of(context).unfocus();
                  NetWorking apiObj = NetWorking(password: '', phoneNumber: '');
                  await apiObj.updatePassword(oldpass.text, newpass.text, conpass.text).then((value) async {

                    Map valueMap = jsonDecode(value);
                      final snackBar =
                      SnackBar(content: Text(valueMap['message']));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);

                  });
                }, child: Text('Upate'))
              ],
            )))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        // ignore: prefer_const_constructors
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.logout_sharp,
                          color: Colors.transparent,
                        )),
                    Center(
                      child: Text(
                        "Leads",
                        style:
                            poppinFonts(Color(0xFFd00657), FontWeight.bold, 30),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          displayDialog(context);
                        },
                        icon: Icon(Icons.logout_sharp))
                  ]),
            ),
            SizedBox(
              height: 40,
            ),

            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.person)),
              Padding(padding: EdgeInsets.all(10),
              child:
              Text('My Profile', style: TextStyle(fontSize: 17),))
            ],),)),

            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.info)),
              Padding(padding: EdgeInsets.all(10),
                  child:
                  Text('About us', style: TextStyle(fontSize: 17),))
            ],),)),

            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(
              onTap: (){DisplayChangePasswordDialog(context);},
              child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.lock)),
              Padding(padding: EdgeInsets.all(10),
                  child:
                  Text('Change Password', style: TextStyle(fontSize: 17),))
            ],),)),

            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.login)),
              Padding(padding: EdgeInsets.all(10),
                  child:
                  Text('Logout', style: TextStyle(fontSize: 17),))
            ],),)),

            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.password)),
              Padding(padding: EdgeInsets.all(10),
                  child:
                  Text('Check Password', style: TextStyle(fontSize: 17),))
            ],),)),

            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.share)),
              Padding(padding: EdgeInsets.all(10),
                  child:
                  Text('Share our App', style: TextStyle(fontSize: 17),))
            ],),)),
            Padding(padding: EdgeInsets.only(left: 10), child:
            GestureDetector(child:
            Row(children: [
              Padding(padding: EdgeInsets.all(10), child:
              Icon(Icons.contact_support)),
              Padding(padding: EdgeInsets.all(10),
                  child:
                  Text('Contact us', style: TextStyle(fontSize: 17),))
            ],),)),

            SizedBox(
              height: 40,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () async {
                  launch("https://www.google.com");
                },
                child: Text(
                  "Visit our Website",
                  style: poppinFonts(Colors.black, FontWeight.normal, 15),
                ))
          ],
        ),
      ),
    ));
  }
}
