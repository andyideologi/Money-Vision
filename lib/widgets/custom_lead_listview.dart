// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise/utils/details.dart';
import 'package:franchise/widgets/card_design.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: Details.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blueGrey.shade50,
          child: CardDesign(
            index: 10,
            name: Details[index].name,
            dateTime: DateTime.now().toString(),
            desc: Details[index].description,
            email: Details[index].emailID,
            instr: Details[index].instructions,
            leadId: Details[index].leadID,
            phoneNumber: Details[index].phoneNumber,
            status: Details[index].status,
          ),
        );
      },
    );
  }
}
