// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise/screens/lead_form_designed.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/utils/details.dart';

class CardDesign extends StatefulWidget {
  final String name;
  final String leadId;
  final String desc;
  final String instr;
  final String status;
  final String email;
  final int phoneNumber;
  final int index;
  final String dateTime;

  CardDesign(
      {Key? key,
      required this.name,
      required this.leadId,
      required this.desc,
      required this.index,
      required this.instr,
      required this.email,
      required this.phoneNumber,
      required this.dateTime,
      required this.status})
      : super(key: key);

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
            TextButton(onPressed: () {
              //TODO:
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
          children: [
            Row(
              children: [
                Text(this.widget.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    )),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      this.widget.leadId,
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
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.call,
                    size: 15,
                    color: Color(0xFFd00657),
                  ),
                ),
                Text(
                  this.widget.phoneNumber.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Spacer(),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.email_outlined,
                    size: 15.0,
                    color: Color(0xFFd00657),
                  ),
                ),
                Text(
                  this.widget.email,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Text(
              this.widget.desc,
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
              this.widget.instr,
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
                  this.widget.status.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (widget.status == "OPEN") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LeadFormDesign()));
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
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0, top: 2.0),
              child: Center(
                child: Text(
                  "09-03-2022",
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
