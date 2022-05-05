// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:franchise/Model/circle_bg.dart';
import 'package:franchise/Model/lead_data.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/screens/leads_screen.dart';
import 'package:franchise/screens/notification_screen.dart';
import 'package:franchise/widgets/card_design.dart';
import 'package:franchise/widgets/custom_lead_listview.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final leadsInfoMap;
  bool _isLoading = false;
  List<Leads> latestLeads = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeadsData();
  }

  Future<void> getLeadsData() async {
    setState(() {
      _isLoading = true;
    });
    NetWorking netWorking = NetWorking(password: '', phoneNumber: '');
    var leadsInfo = await netWorking.dashboardLeads(Data.map['id'].toString());
    leadsInfoMap = json.decode(leadsInfo);
    json.decode(leadsInfo)['latest_ten_leads'].forEach((lead) {
      latestLeads.add(Leads(
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
    print(leadsInfoMap);
    print('************');
    print(latestLeads);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: PageScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Hi, Den!',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleBackground(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return NotificationScreen();
                              }));
                            },
                            // ignore: prefer_const_constructors
                            widget: Icon(
                              Icons.notifications_none,
                              color: Color(0xFFd00657),
                              size: 20,
                            ),
                            height1: 50,
                            height2: 40,
                            width1: 50,
                            width2: 40,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey.shade50,
            child: IntrinsicHeight(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Expanded(
                          child: Center(
                            // heightFactor: 35,
                            // widthFactor: 40,
                            child: Card(
                              elevation: 8,
                              // shadowColor: Colors.black,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    child: Text(
                                      "Leads",
                                      style: TextStyle(
                                        color: Color(0xFFd00657),
                                        fontSize: 24,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "How Much Should You Take?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16.0,
                                              bottom: 16.0,
                                              left: 16.0),
                                          child: Column(
                                            children: [
                                              Countup(
                                                begin: 0.0,
                                                end: leadsInfoMap['total_leads']
                                                    .toDouble(),
                                                duration:
                                                    const Duration(seconds: 2),
                                                style: TextStyle(
                                                    color: Color(0xFFd00657),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "TOTAL LEADS",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 0.9,
                                          height: 45.0,
                                          color: const Color(0xFFd00657),
                                          margin:
                                              const EdgeInsets.only(right: 4),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              top: 16.0,
                                              bottom: 16.0),
                                          child: Column(
                                            children: [
                                              Countup(
                                                begin: 0.0,
                                                end: leadsInfoMap['open_leads']
                                                    .toDouble(),
                                                duration:
                                                    const Duration(seconds: 2),
                                                style: TextStyle(
                                                    color: Color(0xFFd00657),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "OPEN",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 0.9,
                                          height: 45.0,
                                          color: const Color(0xFFd00657),
                                          margin:
                                              const EdgeInsets.only(right: 4),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Countup(
                                                begin: 0,
                                                end: leadsInfoMap[
                                                        'in_process_leads']
                                                    .toDouble(),
                                                duration:
                                                    const Duration(seconds: 2),
                                                style: TextStyle(
                                                    color: Color(0xFFd00657),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "IN PROCESS",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 0.9,
                                          height: 45.0,
                                          color: const Color(0xFFd00657),
                                          margin:
                                              const EdgeInsets.only(right: 4),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Countup(
                                                begin: 0.0,
                                                end:
                                                    leadsInfoMap['closed_leads']
                                                        .toDouble(),
                                                duration:
                                                    const Duration(seconds: 2),
                                                style: TextStyle(
                                                    color: Color(0xFFd00657),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "CLOSED",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ])
                                ],
                              ),

                              color: Colors.green.shade100,
                              margin: const EdgeInsets.all(20),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.green.shade100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Container(
            height: 38,
            color: Colors.blueGrey.shade50,
          ),
          Container(
            color: Colors.blueGrey.shade50,
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Latest 10 Leads",
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      )),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: RawMaterialButton(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontFamily: 'Poppins'),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LeadPage()));
                        },
                      )),
                ),
              ],
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: latestLeads.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blueGrey.shade50,
                      child: CardDesign(
                        lead: latestLeads[index],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
