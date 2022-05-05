// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/widgets/customDropDown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image/image.dart' as img;
import '../Networking/api_calling.dart';
import 'login_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool press = false;
  bool tap = false;
  late List<dynamic> m;
  late String filespath;
  PickedFile? profileImage;
  var _currencies = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
  ];

  String _currentSelectedValue = '';
  Color onPressColor = const Color(0xFFd00657).withOpacity(0.7);
  Color buttonColor = const Color(0xFFd00657);

  TextEditingController emailController = TextEditingController(),
      locationController = TextEditingController(),
      mobileController = TextEditingController(),
      bloodController = TextEditingController();
  TextEditingController oldpass = TextEditingController(),
      newpass = TextEditingController(),
      conpass = TextEditingController();

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
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Update Password"),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel))
            ],
          ),
          actions: [
            Form(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          maxLength: 15,
                          decoration: InputDecoration(
                            labelText: "Old Password",

                            labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100),
                            // suffixIcon: _clearIconButton(_passwordController),
                            prefixStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          controller: oldpass,
                        ),
                        TextFormField(
                          maxLength: 15,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "New Password",

                            labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100),
                            // suffixIcon: _clearIconButton(_passwordController),
                            prefixStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          controller: newpass,
                        ),
                        TextFormField(
                          maxLength: 15,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm New Password",

                            labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100),
                            // suffixIcon: _clearIconButton(_passwordController),
                            prefixStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          controller: conpass,
                        ),
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: GestureDetector(
                              child: Container(
                                width: size.width / 1.5,
                                height: size.height / 15,
                                decoration: BoxDecoration(
                                    color: press ? onPressColor : buttonColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: kBoxShadows),
                                child: Center(
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: size.width / 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  press = !press;
                                });
                                FocusScope.of(context).unfocus();
                                NetWorking apiObj =
                                    NetWorking(password: '', phoneNumber: '');
                                await apiObj
                                    .updatePassword(oldpass.text, newpass.text,
                                        conpass.text)
                                    .then((value) async {
                                  Map valueMap = jsonDecode(value);
                                  final snackBar = SnackBar(
                                      content: Text(valueMap['message']));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              },
                            ))
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
                      boxShadow: kBoxShadows),
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: profileImage == null
                        ? NetworkImage("https://fleenks.com/mv/" +
                            Data.map['photo_path'].toString())
                        : FileImage(File(profileImage!.path)) as ImageProvider,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Data.map['name'].toString(),
                    style: poppinFonts(Colors.black, FontWeight.w600, 20),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.amberAccent),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.5))),
                          onPressed: () async {
                            tap = true;
                            NetWorking netWorking =
                                NetWorking(password: '', phoneNumber: '');
                            await netWorking
                                .getProfileDetails(Data.map['id'].toString())
                                .then((value) {
                              Map<String, dynamic> data = jsonDecode(value);
                              print(data.toString());
                              filespath = data['files_path'];
                              m = data['profile_obj'];
                              emailController.text = m[0]['pers_email'];
                              locationController.text = m[0]['location'];
                              bloodController.text = m[0]['blood_group'];
                              mobileController.text = m[0]['sec_mobile'];
                            });
                            showProfileDetails();
                          },
                          icon: Icon(Icons.person),
                          label: Text('My Profile',
                              style: TextStyle(fontSize: 17))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.amberAccent),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.5))),
                          onPressed: () async {
                            if (!tap) {
                              NetWorking netWorking =
                                  NetWorking(password: '', phoneNumber: '');
                              await netWorking
                                  .getProfileDetails(Data.map['id'].toString())
                                  .then((value) {
                                Map<String, dynamic> data = jsonDecode(value);
                                print(data.toString());
                                filespath = data['files_path'];
                                m = data['profile_obj'];
                                emailController.text = m[0]['pers_email'];
                                locationController.text = m[0]['location'];
                                _currentSelectedValue = m[0]['blood_group'];
                                mobileController.text = m[0]['sec_mobile'];
                              });
                            }
                            updateProfileDetails();
                            setState(() {});
                          },
                          icon: Icon(Icons.person),
                          label: Text('Update Profile',
                              style: TextStyle(fontSize: 17))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.amberAccent),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.5))),
                          onPressed: () {},
                          icon: Icon(Icons.info),
                          label:
                              Text('About us', style: TextStyle(fontSize: 17))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.amberAccent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.5))),
                        onPressed: () {
                          DisplayChangePasswordDialog(context);
                        },
                        icon: Icon(Icons.lock),
                        label: Text(
                          'Change Password',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.amberAccent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.5))),
                        onPressed: () {
                          displayDialog(context);
                        },
                        icon: Icon(Icons.login),
                        label: Text(
                          'Logout',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.amberAccent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.5))),
                        onPressed: () {},
                        icon: Icon(Icons.password),
                        label: Text(
                          'Check Password',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.amberAccent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.5))),
                        onPressed: () {},
                        icon: Icon(Icons.share),
                        label: Text(
                          'Share our App',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.amberAccent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.5))),
                        onPressed: () {},
                        icon: Icon(Icons.contact_support),
                        label: Text(
                          'Contact us',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
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

  void showProfileDetails() {
    print(m.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Profile Details"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Personal Details : ',
                          style: TextStyle(fontSize: 18),
                        )),
                    Row(children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Name",
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                            ":",
                          ))),
                      Expanded(
                          flex: 4,
                          child: Text(
                            m[0]['name'].toString(),
                          )),
                    ]),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "WhatsApp No.",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['whatsapp'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Sec. Mobile",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['sec_mobile'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Email",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['pers_email'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Gender",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['gender'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Blood Group",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['blood_group'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "dob",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['dob'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Location",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['location'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Village",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['village'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Taluka",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['taluka'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "District",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['district'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "State",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['state'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Country",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['country'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Pincode",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['pincode'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Education",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: (m[0]['education'] != null)
                                ? Text(
                                    m[0]['education'],
                                  )
                                : Text('')),
                      ]),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Company Details : ',
                          style: TextStyle(fontSize: 18),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Source",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['source'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Entity",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['entity'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Firm Name",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['firm_name'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Office Email",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['office_email'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Joined By",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['joined_by'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Relationship Manager",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['rel_mngr'].toString(),
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Joined Date",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['joined_date'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Pan No.",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: (m[0]['pan_file'] != null)
                                ? GestureDetector(
                                    onTap: () async {
                                      String url = 'https://fleenks.com/mv/' +
                                          filespath +
                                          m[0]['pan_file'];
                                      await launch(url);
                                    },
                                    child: Text(
                                      m[0]['pan_no'],
                                    ))
                                : Text(
                                    m[0]['pan_no'],
                                  )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Adhaar No.",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: (m[0]['adhaar_file'] != null)
                                ? GestureDetector(
                                    onTap: () async {
                                      String url = 'https://fleenks.com/mv/' +
                                          filespath +
                                          m[0]['adhaar_file'];
                                      await launch(url);
                                    },
                                    child: Text(
                                      m[0]['aadhar_no'],
                                    ))
                                : Text(
                                    m[0]['adhaar_no'],
                                  )),
                      ]),
                    ),
                    (m[0]['agreement_file'] != null)
                        ? Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () async {
                                String url = 'https://fleenks.com/mv/' +
                                    filespath +
                                    m[0]['agreement_file'];
                                await launch(url);
                              },
                              child: Text('Agreement File'),
                            ))
                        : Text(''),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () async {
                            String url = 'https://fleenks.com/mv/' +
                                filespath +
                                m[0]['kyc_photo'];
                            await launch(url);
                          },
                          child: Text('KYC'),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Id Proof",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: (m[0]['id_proof_name'] != null)
                                ? GestureDetector(
                                    onTap: () async {
                                      String url = 'https://fleenks.com/mv/' +
                                          filespath +
                                          m[0]['id_proof_file'];
                                      await launch(url);
                                    },
                                    child: Text(
                                      m[0]['id_proof_name'],
                                    ))
                                : Text('')),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Address Proof",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: (m[0]['address_proof_name'] != null)
                                ? GestureDetector(
                                    onTap: () async {
                                      String url = 'https://fleenks.com/mv/' +
                                          filespath +
                                          m[0]['address_proof_file'];
                                      await launch(url);
                                    },
                                    child: Text(
                                      m[0]['address_proof_name'],
                                    ))
                                : Text('')),
                      ]),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Bank Details : ',
                          style: TextStyle(fontSize: 18),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Account Number",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['account_number'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Bank Name",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['bank_name'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "IFSC Code",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['ifsc_code'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Branch",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['branch'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "UPI Id",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['upi_id'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "UPI Mobile",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['upi_mobile'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "CSP Type",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['csp_type'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Reg. Charges",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['reg_charges'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Reg. Charges Desc.",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['reg_charges_desc'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Joining Fees",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['joining_fees'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Joining Fees Desc.",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['joining_fees_desc'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Sec. Deposit",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['sec_deposit'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Sec. Deposit Desc.",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['sec_deposit_desc'],
                            )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Created At",
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                                child: Text(
                              ":",
                            ))),
                        Expanded(
                            flex: 4,
                            child: Text(
                              m[0]['created_at'],
                            )),
                      ]),
                    ),
                  ],
                ),
              ),
            ));
  }

  void updateProfileDetails() {
    Size size = MediaQuery.of(context).size;
    bool _isLoading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Update Profile"),
                      if (!_isLoading)
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel)),
                    ],
                  ),
                  content: _isLoading
                      ? Text(
                          'Updating...',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      labelText: "My Email *",
                                      labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w100),
                                      // suffixIcon: _clearIconButton(_passwordController),
                                      prefixStyle: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      return null;
                                    },
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: locationController,
                                    decoration: const InputDecoration(
                                      labelText: "Location *",
                                      labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w100),
                                      // suffixIcon: _clearIconButton(_passwordController),
                                      prefixStyle: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      return null;
                                    },
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: mobileController,
                                    decoration: const InputDecoration(
                                      labelText: "Alternate Mobile",
                                      labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w100),
                                      // suffixIcon: _clearIconButton(_passwordController),
                                      prefixStyle: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      return null;
                                    },
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 8),
                                    child: Text(
                                      'Selected Blood Group',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 15.0),
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        // labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12.0),
                                        hintText: 'Blood Group',
                                      ),
                                      isEmpty: _currentSelectedValue == '',
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _currentSelectedValue,
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _currentSelectedValue = newValue!;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items:
                                              _currencies.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: kBoxShadows),
                                child: CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage("https://fleenks.com/mv/" +
                                          Data.map['photo_path'].toString())
                                      : FileImage(File(profileImage!.path))
                                          as ImageProvider,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final PickedFile? image =
                                        await _picker.getImage(
                                            source: ImageSource.gallery,
                                            maxWidth: 1024,
                                            maxHeight: 768);
                                    setState(() {
                                      profileImage = image;
                                      setProfileImage(image);
                                    });
                                    print(image);
                                  },
                                  child: Text(
                                    'Choose File',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'File Size: Max.3MB & \n PNG/JPEG/JPG Formats Only.',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(25),
                                  child: GestureDetector(
                                    child: Container(
                                      width: size.width / 1.5,
                                      height: size.height / 15,
                                      decoration: BoxDecoration(
                                          color: press
                                              ? onPressColor
                                              : buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: kBoxShadows),
                                      child: Center(
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: size.width / 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        press = !press;
                                        _isLoading = true;
                                      });

                                      FocusScope.of(context).unfocus();
                                      String base64Image = '';
                                      if (profileImage != null) {
                                        Uint8List imagebytes = await File(
                                                profileImage!.path)
                                            .readAsBytes(); //convert to bytes
                                        base64Image = base64.encode(imagebytes);
                                      }

                                      NetWorking apiObj = NetWorking(
                                          password: '', phoneNumber: '');
                                      await apiObj
                                          .updateDetails(
                                              Data.map['id'].toString(),
                                              emailController.text,
                                              locationController.text,
                                              mobileController.text,
                                              _currentSelectedValue,
                                              profileImage == null
                                                  ? Data.map['photo_path']
                                                  : base64Image)
                                          .then((result) async {
                                        print(result);
                                        final snackBar = SnackBar(
                                            content: Text(result[1] == 'K'
                                                ? 'Updated Successfully'
                                                : 'Failed'));
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ))
                            ],
                          ),
                        )),
            ));
  }

  void setProfileImage(PickedFile? image) {
    setState(() {
      profileImage = image;
    });
  }
}