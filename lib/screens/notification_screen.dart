// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franchise/utils/constants.dart';
import 'package:franchise/utils/details.dart';
import 'package:franchise/widgets/notify_card.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        body: ListView.builder(
            itemCount: notify.length,
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
                    notify.removeAt(index);
                    HapticFeedback.vibrate();
                    setState(() {});
                  },
                  child: NotifyCard(
                      desc: notify[index].desc,
                      dateTime: notify[index].dateTime,
                      title: notify[index].title));
            }));
  }
}
