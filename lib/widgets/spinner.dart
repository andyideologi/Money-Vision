// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:franchise/utils/constants.dart';

class SpinnerPage extends StatefulWidget {
  const SpinnerPage({Key? key}) : super(key: key);

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height/3,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                "assets/images/moneyvisionImage.png",
              ),
            ),
            SizedBox(
              height: size.height / 4,
            ),
            const SpinKitCircle(
              color: Color(0xFFd00657),
              size: 60.0,
            ),
          ],
        ));
  }
}
