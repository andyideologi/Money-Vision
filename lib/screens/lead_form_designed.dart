// ignore_for_file: unnecessary_this, prefer_const_constructors, unused_field, prefer_final_fields, unused_import

import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:franchise/Model/circle_bg.dart';
import 'package:franchise/Model/lead_data.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/screens/notification_screen.dart';
import 'package:franchise/utils/constants.dart';

import 'home.dart';

class LeadFormDesign extends StatefulWidget {
  Leads lead;
  LeadFormDesign({Key? key, required this.lead}) : super(key: key);

  @override
  State<LeadFormDesign> createState() => _LeadFormDesignState();
}

class _LeadFormDesignState extends State<LeadFormDesign> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionController = TextEditingController();
  final _secMobController = TextEditingController();
  List<String> locations = ['Lead Status', 'OPEN', 'IN PROCESS', 'CLOSED'];
  String _selectedLocation = 'Lead Status';
  DateTime _dateTime = DateTime(2022, 12, 24);
  @override
  void initState() {
    super.initState();
    initializeFields();
  }

  final List<DropdownMenuItem> items = [];
  String selectedValue = "";
  String _selectedStatus = 'A';
  bool press = false;
  Color onPressColor = const Color(0xFFd00657).withOpacity(0.7);
  Color buttonColor = const Color(0xFFd00657);

  void initializeFields() {
    _nameController.text = widget.lead.name;
    _emailController.text = widget.lead.emailID;
    _phoneController.text = widget.lead.phoneNumber.toString();
    _secMobController.text = widget.lead.secNumber.toString();
    _descriptionController.text = widget.lead.rawDescription;
    _instructionController.text = widget.lead.instructions;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFd00657),
        title: const Text(
          'Update Lead',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Color(0xFFd00657),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              height: 8,
              color: Colors.pink,
              child: Center(child: Text("ArcClipper()")),
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
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
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
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Please Enter Your Name';
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
                                            color: Colors.black, fontSize: 10),
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
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Please Enter Your Whatsapp Number';
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
                                            color: Colors.black, fontSize: 10),
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
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Please Enter Your Requirements';
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
                                        labelText: "Enter Instructions, if any",

                                        labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w100),
                                        // suffixIcon: _clearIconButton(_passwordController),
                                        prefixStyle: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 15,
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
                                          if (!_formKey.currentState!
                                              .validate()) return;
                                          setState(() {
                                            press = !press;
                                          });
                                          NetWorking apiObj = NetWorking(
                                              password: '', phoneNumber: '');
                                          await apiObj
                                              .addUpdateLead(
                                                  id: Data.map['id'].toString(),
                                                  name: _nameController.text,
                                                  whatsapp:
                                                      _phoneController.text,
                                                  mobile:
                                                      _secMobController.text,
                                                  email: _emailController.text,
                                                  instruction:
                                                      _instructionController
                                                          .text,
                                                  raw_des:
                                                      _descriptionController
                                                          .text,
                                                  leadId: widget.lead.leadID)
                                              .then((value) {
                                            var result = json.decode(value);
                                            if (result['status'] == 1) {
                                              final snackBar = SnackBar(
                                                  content:
                                                      Text(result['message']));
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage()));
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
                                                  fontWeight: FontWeight.bold),
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
    );
  }
}
