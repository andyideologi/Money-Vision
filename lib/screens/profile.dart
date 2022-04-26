// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/widgets/customDropDown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Networking/api_calling.dart';
import 'login_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController oldpass = TextEditingController(), newpass = TextEditingController(), conpass = TextEditingController();

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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFd00657),
          title: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: kBoxShadows
                  ),
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                        "https://fleenks.com/mv/"+Data.map['photo_path'].toString()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Data.map['name'].toString(),style:poppinFonts(Colors.black, FontWeight.w600, 20),),
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
                GestureDetector(
                  onTap: (){displayDialog(context);},
                  child:
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
