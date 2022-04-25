// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_this

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:franchise/Model/circle_bg.dart';
import 'package:franchise/Model/lead_data.dart';
import 'package:franchise/screens/notification_screen.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/utils/details.dart';
import 'package:franchise/widgets/SearchWidget.dart';
import 'package:franchise/widgets/card_design.dart';

class LeadPage extends StatefulWidget {
  LeadPage({Key? key}) : super(key: key);

  @override
  State<LeadPage> createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  String query = '';
  List<Leads> leads = Details;

  Widget buildSearch() => SearchWidget(
      text: query,
      onChanged: searchLead,
      hintText: 'Search Leads by Name or Id');

  void searchLead(String query) {
    if (query == '') {
      setState(() {
        this.leads = Details;
      });
    }
    print(query);
      final listLeads = leads.where((element) {
      final nameLower = element.name.toLowerCase();
      final leadName = query.toLowerCase();
      final leadId = element.leadID.toLowerCase();
      final searchId = query.toLowerCase();

      return nameLower.contains(leadName) || leadId.contains(searchId);
    }).toList();

    setState(() {
      this.leads = listLeads;
      this.query = query;
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // ignore: prefer_const_constructors
          flexibleSpace: Align(
            alignment: Alignment.bottomRight,
            // ignore: prefer_const_constructors
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
          backgroundColor: Color(0xFFd00657),
          title: Text(
            'Leads',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Color(0xFFd00657),
        body: Column(children: [
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              height: 8,
              color: Colors.pink,
              child: Center(child: Text("ArcClipper()")),
            ),
          ),
          buildSearch(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: leads.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    child: CardDesign(
                      index: index,
                      name: leads[index].name,
                      dateTime: DateTime.now().toString(),
                      desc: leads[index].description,
                      email: leads[index].emailID,
                      instr: leads[index].instructions,
                      leadId: leads[index].leadID,
                      phoneNumber: leads[index].phoneNumber,
                      status: leads[index].status,
                    ),
                  );
                },
              ),
            ),
          ),
        ]));
  }
}
