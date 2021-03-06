// ignore_for_file: avoid_print, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:franchise/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'data.dart';

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

  Future<String> getProfileDetails(String id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-profile'));
    request.fields.addAll({'id': id});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase.toString();
  }

  Future<String> getServices() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-services-list'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
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

  Future<String> dashboardLeads(String id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-dashboard'));
    request.fields.addAll({'id': id});

    http.StreamedResponse response = await request.send();
    Map<String, Object> leadsInfo = {};
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> addUpdateLead(
      {required String id,
      String? leadId,
      required String name,
      required String whatsapp,
      required String mobile,
      required String email,
      required String instruction,
      required String raw_des}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-lead-add-update'));
    request.fields.addAll({
      'id': id,
      'lead_id': leadId ?? '',
      'name': name,
      'whatsapp': whatsapp,
      'sec_mobile': mobile,
      'pers_email': email,
      'instruction_by_fr': instruction,
      'raw_desc': raw_des
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> deleteLead(String id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-lead-delete'));
    request.fields.addAll({'id': id});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> getNotifications() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-notifications-list'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> getAllLeads() async {
    late List<dynamic> m;
    late String filespath;
    late String mobile;
    await getProfileDetails(Data.map['id'].toString()).then((value) {
      Map<String, dynamic> data = jsonDecode(value);
      print(data.toString());
      filespath = data['files_path'];
      m = data['profile_obj'];
      mobile = m[0]['whatsapp'].toString();
    });
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-all-leads'));
    request.fields
        .addAll({'id': Data.map['id'].toString(), 'whatsapp': mobile});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> updatePassword(
      String curpass, String newpass, String conpass) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-update-pass'));
    request.fields.addAll({
      'id': Data.map['id'].toString(),
      'curr_pass': curpass,
      'new_pass': newpass,
      'con_new_pass': conpass
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase.toString();
  }

  Future<String> updateDetails(String id, String email, String location,
      String mobile, String blood, String image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-profile-update'));
    request.fields.addAll({
      'id': id,
      'pers_email': email,
      'location': location,
      'sec_mobile': mobile,
      'blood_group': blood,
      'profile_photo': image,
      'profile_photo_ext': 'jpg'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
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

  Future<String> firebaseToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    String? token = await _firebaseMessaging.getToken();
    String? imeiNumber = '';
    try {
      imeiNumber = await UniqueIdentifier.serial;
    } on PlatformException {
      print('Failed to get Unique Identifier');
    }
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://fleenks.com/mv/api/fr-firebase-token'));
    request.fields.addAll({
      'token': token!,
      'user_id': Data.map['id'].toString(),
      'device_id': imeiNumber!
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase.toString();
    }
  }
}
