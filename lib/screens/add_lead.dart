// ignore_for_file: unnecessary_this, unnecessary_new, unused_field, prefer_const_constructors, unnecessary_const

import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:franchise/Model/circle_bg.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/screens/notification_screen.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/Networking/data.dart';

class AddLeads extends StatefulWidget {
  const AddLeads({Key? key}) : super(key: key);

  @override
  State<AddLeads> createState() => _AddLeadsState();
}

class _AddLeadsState extends State<AddLeads> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionController = TextEditingController();
  final _rawDesController = TextEditingController();
  final _secMobController = TextEditingController();
  final List<String> locations = ['OPEN', 'IN PROCESS', 'CLOSED'];
  String _selectedLocation = 'OPEN';
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  DateTime _dateTime = new DateTime(2022, 12, 24);

  final List<DropdownMenuItem> items = [];
  String selectedValue = "";

  bool press = false;
  Color onPressColor = const Color(0xFFd00657).withOpacity(0.7);
  Color buttonColor = const Color(0xFFd00657);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 10, bottom: 5),
            child: CircleBackground(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NotificationScreen();
                }));
              },
              widget: Icon(
                Icons.notifications_none,
                color: Color(0xFFd00657),
                size: 20,
              ),
              height1: 50,
              height2: 40,
              width1: 50,
              width2: 40,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFd00657),
        title: const Text(
          'Add Lead',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFd00657),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipPath(
              clipper: ArcClipper(),
              child: Container(
                width: size.width,
                height: 15,
                color: Colors.pink,
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50, //Colors.green.shade100
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: IntrinsicHeight(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 8,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          labelText: "Name *",
                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          labelText: "Personal Email",
                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          // suffixIcon: _clearIconButton(_passwordController),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          prefix: CountryCodePicker(
                                            initialSelection: 'IN',
                                            favorite: const ['+91', 'IN'],
                                            padding: EdgeInsets.all(0.1),
                                            enabled: true,
                                            hideMainText: false,
                                            showFlag: true,
                                            showFlagMain: true,
                                            showFlagDialog: true,
                                            showOnlyCountryWhenClosed: false,
                                            showCountryOnly: false,
                                          ),
                                          labelText: "Whatsapp Number *",
                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          // suffixIcon: _clearIconButton(_passwordController),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        controller: _secMobController,
                                        decoration: InputDecoration(
                                          prefix: CountryCodePicker(
                                            initialSelection: 'IN',
                                            favorite: const ['+91', 'IN'],
                                            padding: EdgeInsets.all(0.1),
                                            enabled: true,
                                            hideMainText: false,
                                            showFlag: true,
                                            showFlagMain: true,
                                            showFlagDialog: true,
                                            showOnlyCountryWhenClosed: false,
                                            showCountryOnly: false,
                                          ),
                                          labelText: "Alternate Number",
                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          // suffixIcon: _clearIconButton(_passwordController),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        maxLines: null,
                                        controller: _descriptionController,
                                        decoration: const InputDecoration(
                                          labelText:
                                              "Enter Detailed Service Requirements *",
                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          // suffixIcon: _clearIconButton(_passwordController),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        maxLines: null,
                                        controller: _instructionController,
                                        decoration: const InputDecoration(
                                          labelText:
                                              "Enter Instructions, if any",

                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          // suffixIcon: _clearIconButton(_passwordController),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: TextFormField(
                                        controller: _rawDesController,
                                        decoration: const InputDecoration(
                                          labelText: "Raw Description",

                                          labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w100),
                                          // suffixIcon: _clearIconButton(_passwordController),
                                          prefixStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        validator: (value) {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 24.0),
                                    child: Container(
                                        // width: 500,

                                        // color: Color(0xff01661c),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              press = !press;
                                            });
                                            print(_nameController.text);
                                            print(_secMobController.text);
                                            print(_rawDesController.text);
                                            print(_emailController.text);
                                            print(_phoneController.text);
                                            print(_descriptionController.text);
                                            print(_instructionController.text);
                                            NetWorking apiObj = NetWorking(
                                                password: '', phoneNumber: '');
                                            await apiObj
                                                .addUpdateLead(
                                                    id: Data.map['id']
                                                        .toString(),
                                                    name: _nameController.text,
                                                    whatsapp:
                                                        _phoneController.text,
                                                    mobile:
                                                        _secMobController.text,
                                                    email:
                                                        _emailController.text,
                                                    instruction:
                                                        _instructionController
                                                            .text,
                                                    raw_des:
                                                        _rawDesController.text)
                                                .then((value) {
                                              var result = json.decode(value);
                                              if (result['status'] == 1) {
                                                final snackBar = SnackBar(
                                                    content: Text(
                                                        result['message']));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                Navigator.of(context).pop();
                                              } else {
                                                final snackBar = SnackBar(
                                                    content: Text(
                                                        'Something went wrong!'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            });
                                          },
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
                                                "Save",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: size.width / 22,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}