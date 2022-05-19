// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use, unused_local_variable, unused_field, unrelated_type_equality_checks, prefer_const_constructors_in_immutables, unnecessary_null_comparison, prefer_if_null_operators, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchise/Model/login_model.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/screens/wrapper.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/widgets/spinner.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _forgotPassKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _modelScaffoldKey = GlobalKey<ScaffoldState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _forgotPassController = TextEditingController();
  final passwordString = '';
  final phoneNumber = '';
  late LoginRequestModel object;
  bool isApiCallProcess = false;
  bool isModalProcess = true;
  String imeiNumber = '';

  bool press = false;
  bool forpress = false;
  Color onPressColor = const Color(0xFFd00657).withOpacity(0.7);
  Color buttonColor = const Color(0xFFd00657);

  late final NetWorking apiObject;

  @override
  void initState() {
    object = LoginRequestModel(mobile: "", password: "");
    super.initState();
  }

  void MyModalBottomSheet(Size size) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return isModalProcess
                  ? Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        color: Color(0xff757575),
                        child: Container(
                          height: 320,
                          width: 200,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Forgot your Password?",
                                style: poppinFonts(
                                    Colors.black, FontWeight.bold, 22),
                              ),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Text("We'll email you with new credentials."),
                              SizedBox(
                                height: size.height / 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 35.0, right: 35),
                                child: Form(
                                  key: _forgotPassKey,
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "phone number is required";
                                      } else if (value.length != 10) {
                                        return "phone number must be 10 digits long.";
                                      } else if (!RegExp(
                                              r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                          .hasMatch(value)) {
                                        return "Enter correct phone number";
                                      }
                                      return null;
                                    },
                                    controller: _forgotPassController,
                                    decoration: InputDecoration(
                                      labelText: "Enter Phone Number",
                                      fillColor: Colors.white,
                                      labelStyle: poppinFonts(
                                          Colors.black, FontWeight.w100, 15),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      print(value);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height / 25,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    forpress = !forpress;
                                  });

                                  if (_forgotPassKey.currentState!.validate()) {
                                    apiObject = NetWorking(
                                        password: "",
                                        phoneNumber:
                                            _forgotPassController.text.trim());

                                    setState(() {
                                      isModalProcess = false;
                                    });

                                    await apiObject
                                        .forgetPassword()
                                        .then((value) {
                                      setState(() {
                                        isModalProcess = true;
                                      });

                                      Map valueMap = jsonDecode(value);
                                      String text;

                                      if (valueMap['status'] == 1) {
                                        text =
                                            "New Password & Login Details Sent On E-mail";
                                        print(text);
                                      } else {
                                        text = valueMap['message'];
                                        print(text);
                                      }
                                      final snackBar = SnackBar(
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  100,
                                              right: 20,
                                              left: 20),
                                          content: Text(text),
                                          behavior: SnackBarBehavior.floating);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                  }
                                },
                                child: Container(
                                  width: size.width / 1.5,
                                  height: size.height / 15,
                                  decoration: BoxDecoration(
                                      color:
                                          forpress ? onPressColor : buttonColor,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: kBoxShadows),
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: size.width / 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SpinnerPage();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      isAsynCall: isApiCallProcess,
      child: _uiPage(context),
    );
  }

  Widget _uiPage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child:
               CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage(
                      "assets/images/moneyvisionImage.png",
                    ),
                  )),
                SizedBox(
                  height: size.height / 20,
                ),
                Text(
                  "Hi,",
                  style: poppinFonts(Colors.black, FontWeight.bold, 35),
                ),
                Text("Franchise Owner.",
                    style: poppinFonts(Colors.black, FontWeight.bold, 32)),
                SizedBox(
                  height: size.height / 30,
                ),
                Text("Please Login.",
                    style: poppinFonts(
                        const Color(0xFFd00657), FontWeight.bold, 20)),
                SizedBox(
                  height: size.height / 30,
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _idController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone number is required";
                            } else if (value.length != 10) {
                              return "phone number must be 10 digits long.";
                            } else if (!RegExp(
                                    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                .hasMatch(value)) {
                              return "Enter correct phone number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              prefixIcon: Icon(Icons.phone_android),
                              hintText: "Mobile Number",
                              hintStyle: poppinFonts(
                                  Colors.grey, FontWeight.normal, 17)),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password is required";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              suffix: GestureDetector(
                                onTap: () async {
                                  MyModalBottomSheet(size);
                                },
                                child: Text(
                                  "Forgot?",
                                  style: poppinFonts(const Color(0xFFd00657),
                                      FontWeight.bold, 17),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              hintText: "Password",
                              hintStyle: poppinFonts(
                                  Colors.grey, FontWeight.normal, 17)),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        SizedBox(
                          height: size.height / 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              press = !press;
                            });

                            if (_formKey.currentState!.validate()) {
                              object.mobile = _idController.text;
                              object.password = _passwordController.text;

                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();

                              sharedPreferences.setString(
                                  'mobile', object.mobile);
                              sharedPreferences.setString(
                                  'password', object.password);

                              setState(() {
                                isApiCallProcess = true;
                              });

                              ApiService apiService = ApiService();
                              apiService.login(object).then((value) async {
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                if (value.status == 1) {
                                  final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setBool("isLoggedIn", true);
                                  print('after login data');
                                  print('**************************');
                                  print(value.data);
                                  Data.setMap(value.data);
                                  await apiService.firebaseToken();

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return MyHomePage();
                                  }));
                                } else {
                                  final snackBar =
                                      SnackBar(content: Text(value.message));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                            }

                            print(object.toJson());
                          },
                          child: Container(
                            width: size.width / 1.5,
                            height: size.height / 15,
                            decoration: BoxDecoration(
                                color: press ? onPressColor : buttonColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: kBoxShadows),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: size.width / 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
