// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise/Model/lead_data.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/screens/lead_form_designed.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/utils/details.dart';
import 'package:url_launcher/url_launcher.dart';

class CardDesign extends StatefulWidget {
  final Leads lead;

  CardDesign({Key? key, required this.lead}) : super(key: key);

  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  bool press1 = false;
  bool press2 = false;

  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text("Confirm Record Deletion"),
          content: const Text("Do you really want to delete this record ?"),
          actions: [
            TextButton(
                onPressed: () async {
                  NetWorking apiObj = NetWorking(password: '', phoneNumber: '');
                  await apiObj.deleteLead(widget.lead.leadID).then((value) {
                    var result = json.decode(value);
                    if (result['status'] == 1) {
                      final snackBar =
                          SnackBar(content: Text(result['message']));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    } else {
                      final snackBar =
                          SnackBar(content: Text('Something went wrong!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(this.widget.lead.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'LEAD' +
                          (this.widget.lead.leadID.length == 1
                              ? '0${this.widget.lead.leadID}'
                              : this.widget.lead.leadID),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.40,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.call,
                    size: 15,
                    color: Color(0xFFd00657),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      String url =
                          "tel:" + this.widget.lead.phoneNumber.toString();
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      this.widget.lead.phoneNumber.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                (this.widget.lead.secNumber.toString() == '')
                    ? Text('')
                    : GestureDetector(
                        onTap: () async {
                          String url =
                              "tel:" + this.widget.lead.secNumber.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          '/${this.widget.lead.secNumber.toString()}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                Spacer(),
              ],
            ),
            if (this.widget.lead.emailID != '')
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.email_outlined,
                      size: 15.0,
                      color: Color(0xFFd00657),
                    ),
                  ),
                  GestureDetector(
                      onTap: ()
                      async{
                        String uri =
                            'mailto:' +  this.widget.lead.emailID;
                        if (await canLaunch(uri)) {
                        await launch(uri);
                        } else {
                        throw 'Could not launch $uri';
                        }
                      },
                      child:
                  Text(
                    this.widget.lead.emailID,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),)
                  ),
                ],
              ),
            Text(
              "Detailed Service Requirements :",
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              this.widget.lead.rawDescription,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Instructions, if any :",
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              this.widget.lead.instructions,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.widget.lead.status.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                if (widget.lead.status == "OPEN")
                  GestureDetector(
                    onTap: () {
                      if (widget.lead.status == "OPEN") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                LeadFormDesign(lead: widget.lead)));
                      }
                      press1 = !press1;
                      setState(() {});
                      Future.delayed(Duration(milliseconds: 200), () {
                        press1 = !press1;
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: kButtonShadows,
                              color: press1
                                  ? Colors.grey.withOpacity(0.5)
                                  : Colors.white),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Color(0xFFd00657),
                            size: 20,
                          )),
                    ),
                  ),
                if (widget.lead.status == "OPEN")
                  GestureDetector(
                    onTap: () {
                      displayDialog();
                      press2 = !press2;
                      setState(() {});
                      Future.delayed(Duration(milliseconds: 200), () {
                        press2 = !press2;
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: kButtonShadows,
                              color: press2
                                  ? Colors.grey.withOpacity(0.5)
                                  : Colors.white),
                          child: Icon(
                            Icons.delete_outlined,
                            color: Color(0xFFd00657),
                            size: 20,
                          )),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4.0, top: 2.0),
              child: Center(
                child: Text(
                  "${this.widget.lead.createdDate}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(10),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white)),
    );
  }
}
