// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/widgets/customDropDown.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFd00657),
          title: Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: kBoxShadows
                  ),
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                        "https://fleenks.com/mv/"+Data.map['photo_path'].toString()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Data.map['name'].toString(),style:poppinFonts(Colors.black, FontWeight.w600, 20),),
                ),
                CustomDropDown()
              ],
            ),
          ),
        ));
  }
}
