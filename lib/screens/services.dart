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

import '../Model/Service.dart';
import '../Networking/api_calling.dart';

class ServicePage extends StatefulWidget {
  ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  List<ServiceCategory> categories = [];

  List<ExpansionItem> items = [];

  List<Service> getListServices(dynamic ServiceCategoryItem) {
    List<Service> services = [];
    ServiceCategoryItem['services'].forEach((service) {
      services.add(Service(
          service_name: service['services_name'],
          service_description: service['service_description']));
    });
    return services;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xFFd00657),
          title: const Text(
            'Services',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<String>(
                    future:
                        call(), // a previously-obtained Future<String> or null
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        return CustomDropDown(items: items);
                      }
                      return Center();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<String> call() async {
    NetWorking object = NetWorking(password: '', phoneNumber: '');
    await object.getServices().then((value) {
      print(value.toString());
      Map valueMap = jsonDecode(value);
      List<dynamic> parsedListJson = valueMap['services_obj'];
      parsedListJson.forEach((ServiceCategoryItem) {
        categories.add(ServiceCategory(
            category_name: ServiceCategoryItem['category_name'],
            services: getListServices(ServiceCategoryItem)));
      });

      categories.forEach((element) {
        List<ExpansionService> sers = [];
        element.services.forEach((element) {
          ExpansionService expansionService = ExpansionService(
              header: element.service_name,
              id: 1,
              body: element.service_description);
          sers.add(expansionService);
        });
        ExpansionItem expansionItem =
            ExpansionItem(header: element.category_name, id: 1, body: sers);
        items.add(expansionItem);
      });
    });

    return 'test';
  }
}
