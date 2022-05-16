// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:franchise/Model/login_model.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/Networking/data.dart';
import 'package:franchise/screens/home.dart';
import 'package:franchise/widgets/spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  bool isApiCall = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService apiService = ApiService();
    LoginRequestModel model = LoginRequestModel(
        mobile: pref.get('mobile').toString(),
        password: pref.get('password').toString());
    apiService.login(model).then((value) {
      setState(() {
        isApiCall = true;
      });

      if (value.status == 1) {
        print(value.data);
        Data.setMap(value.data);

        apiService.firebaseToken();

        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const MyHomePage();
        }));
      } else {
        final snackBar = SnackBar(content: Text(value.message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    // });

    return isApiCall ? const MyHomePage() : const SpinnerPage();
  }
}
