// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchise/Networking/api_calling.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/utils/details.dart';
import 'package:franchise/widgets/notify_card.dart';
import '../Model/notification_data.dart' as noti;

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<noti.Notification> notifications = [];
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotification();
  }

  Future<void> getNotification() async {
    setState(() {
      _isLoading = true;
    });
    NetWorking apiObj = NetWorking(password: '', phoneNumber: '');
    var jsonNotification = json.decode(await apiObj.getNotifications());
    print(jsonNotification);
    for (var item in jsonNotification['n_list']) {
      notifications.add(noti.Notification(
          title: item['title'],
          dateTime: item['created_at'],
          desc: item['description']));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Notifications",
              style: poppinFonts(Colors.white, FontWeight.w600, 22),
            )),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return Dismissible(
                      background: Container(
                        margin: const EdgeInsets.all(8),
                        color: Colors.green.withOpacity(0.9),
                        child: const Icon(Icons.check),
                      ),
                      secondaryBackground: Container(
                        margin: const EdgeInsets.all(8),
                        color: Color(0xFFd00657),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        notifications.removeAt(index);
                        HapticFeedback.vibrate();
                        setState(() {});
                      },
                      child: NotifyCard(
                          desc: notifications[index].desc,
                          dateTime: notifications[index].dateTime,
                          title: notifications[index].title));
                }));
  }
}
