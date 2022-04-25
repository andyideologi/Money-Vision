// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/widgets/spinner.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key, required this.isAsynCall,required this.child}) : super(key: key);
  final bool isAsynCall;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isAsynCall) {
      return SpinnerPage();
    }
    return child;
  }
}
