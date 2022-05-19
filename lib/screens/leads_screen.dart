// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_this

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:franchise/Model/circle_bg.dart';
import 'package:franchise/Model/lead_data.dart';
import 'package:franchise/Networking/api_calling.dart';
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
  List<Leads> searchResult = [];
  List<Leads> leadsFromErp = [];
  List<Leads> allLeads = [];
  bool _isLoading = false;

  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchLead,
        hintText: 'Search Leads by Name or Lead Id',
      );

  void searchLead(String query) {
    if (query == '') {
      setState(() {
        this.leadsFromErp = allLeads;
      });
    }
    print(query);
    final listLeads = allLeads.where((element) {
      final nameLower = element.name.toLowerCase();
      final leadName = query.toLowerCase();
      // final leadId = 'LEAD' + element.leadID.toLowerCase();
      final leadId = 'lead' +
          (element.leadID.length == 1
              ? '0${element.leadID.toLowerCase()}'
              : element.leadID.toLowerCase());
      final searchId = query.toLowerCase();

      return nameLower.contains(leadName) ||
          leadId.contains(searchId) ||
          leadId == searchId;
    }).toList();

    setState(() {
      this.leadsFromErp = listLeads;
      this.query = query;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeadsFromErp();
  }

  Future<void> getLeadsFromErp() async {
    setState(() {
      _isLoading = true;
    });
    NetWorking apiObj = NetWorking(password: '', phoneNumber: '');
    var leadsJosn = await apiObj.getAllLeads();
    var leads = json.decode(leadsJosn)['all_leads'];
    leads.forEach((lead) {
      leadsFromErp.add(Leads(
          emailID: lead['pers_email']!,
          leadID: lead['id']!.toString(),
          name: lead['name']!,
          phoneNumber: lead['whatsapp']!,
          status: lead['status']!,
          instructions: lead['instruction_by_fr']!,
          secNumber: lead['sec_mobile']!,
          rawDescription: lead['raw_desc']!,
          createdDate: lead['created_at'],
          updatedDate: lead['updated_at']));
    });
    allLeads = leadsFromErp;
    setState(() {
      _isLoading = false;
    });
    print(leadsFromErp.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFFd00657),
          title: Text(
            'All Leads',
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
          _isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Expanded(
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
                      itemCount: leadsFromErp.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          child: CardDesign(
                            lead: leadsFromErp[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ]));
  }
}
