// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/screens/login_page.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/utils/onboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  static String id = "OnBoardScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardModel> _content = Utils.getOnBoard();
  int pageIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool press = false;
  Color onPressColor = const Color(0xFFd00657).withOpacity(0.7);
  Color buttonColor = const Color(0xFFd00657);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Column(
        children: [
          Hero(
            tag: "lead",
            child: Center(
              child: SafeArea(
                child: Text(
                  'Money Vision',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: const Color(0xFFd00657),
                    fontSize: 45.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  pageIndex = page;
                });
              },
              children: List.generate(
                  _content.length,
                  (index) => Container(
                        padding: EdgeInsets.all(size.height / 30),
                        margin: EdgeInsets.only(
                            left: size.width / 12,
                            right: size.width / 12,
                            top: size.width / 20,
                            bottom: size.width / 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xFFd00657).withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(8, 2),
                                  spreadRadius: 1)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              _content[pageIndex].img,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                            SizedBox(
                                child: Text(
                                  _content[index].message,
                                  style: poppinFonts(
                                      Colors.black, FontWeight.w500, 20),
                                  textAlign: TextAlign.center,
                                ),
                            )
                          ],
                        ),
                      )),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  _content.length,
                  (index) => Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFFd00657).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              width: 6,
                              color: pageIndex == index
                                  ? const Color(0xFFd00657).withOpacity(0.1)
                                  : Colors.white.withOpacity(0.95),
                            )),
                      ))),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  press = !press;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              child: Container(
                width: size.width / 1.5,
                height: size.height / 15,
                decoration: BoxDecoration(
                    color: press ? onPressColor : buttonColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: kBoxShadows),
                child: Center(
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: size.width / 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
