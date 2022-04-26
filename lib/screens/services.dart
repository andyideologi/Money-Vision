// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:franchise/Model/ServiceCategory.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/screens/login_page.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/widgets/customDropDown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../Networking/api_calling.dart';

class ServicePage extends StatelessWidget {

  List<ServiceCategory> categories = [];
  ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    NetWorking object = NetWorking(password: '', phoneNumber: '');
    object.getServices().then((value) {
      Map valueMap = jsonDecode(value);
      List<dynamic> parsedListJson = valueMap['services_obj'];
      categories = parsedListJson.cast<ServiceCategory>();
      final snackBar =
      SnackBar(content: Text(categories.toString()));
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    });

    return Scaffold(
        // ignore: prefer_const_constructors
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomDropDown()
          ],
        ),
      ),
    ));
  }
}
