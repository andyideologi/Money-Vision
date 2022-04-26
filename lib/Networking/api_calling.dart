// ignore_for_file: avoid_print, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:franchise/Model/login_model.dart';
import 'package:http/http.dart' as http;

class NetWorking {
  String phoneNumber;
  String password;
  NetWorking({required this.password, required this.phoneNumber});

  Future<String> getLoginDetails() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-login'));
    request.fields.addAll({'mobile': phoneNumber, 'password': password});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase.toString();
  }

  Future<String> getProfileDetails() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-profile'));
    request.fields.addAll({'id': '1'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase.toString();
  }

  Future<String> getServices() async{
    var request = http.MultipartRequest('POST', Uri.parse('https://fleenks.com/mv/api/fr-services-list'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> forgetPassword() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-forgot-password'));
    request.fields.addAll({'mobile': phoneNumber});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase.toString();
  }

  Future<String> updatePassword(String curpass, String newpass, String conpass) async{
    var request = http.MultipartRequest('POST', Uri.parse('https://fleenks.com/mv/api/fr-update-pass'));
    request.fields.addAll({
      'id': '2',
      'curr_pass': curpass,
      'new_pass': newpass,
      'con_new_pass': conpass
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase.toString();
  }
}

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-login'));
    request.fields.addAll(loginRequestModel.toJson());

    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);

      return LoginResponseModel.fromJson(map);
    } else {
      throw "Error";
    }
  }
}
