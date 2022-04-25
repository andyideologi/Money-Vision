// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:franchise/utils/constants.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<ExpansionItem> items = [
    ExpansionItem(
        id: 1,
        icon: Icon(Icons.person),
        header: "Header 1",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
    ExpansionItem(
        id: 2,
        icon: Icon(Icons.info),
        header: "Header 2",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
    ExpansionItem(
        id: 3,
        icon: Icon(Icons.lock),
        header: "Header 3",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
    ExpansionItem(
        id: 4,
        icon: Icon(Icons.logout),
        header: "Header 4",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
  ];

  List<ExpansionItem> headerOneItems = [
     ExpansionItem(
        id: 1,
        icon: Icon(Icons.search),
        header: "Header 1",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
    ExpansionItem(
        id: 2,
        icon: Icon(Icons.place_outlined),
        header: "Header 2",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
    ExpansionItem(
        id: 3,
        icon: Icon(Icons.video_call),
        header: "Header 3",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
    ExpansionItem(
        id: 4,
        icon: Icon(Icons.plus_one),
        header: "Header 4",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae auctor eu augue ut lectus arcu."),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        child: ExpansionPanelList(
      elevation: 0,
      dividerColor: Colors.transparent,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          items[index].isExpanded = !items[index].isExpanded;
          for (int i = 0; i < items.length; i++) {
            if (i != index) {
              items[i].isExpanded = false;
            }
          }
        });
      },
      children: items.map((ExpansionItem item) {
        return ExpansionPanel(
            backgroundColor: Colors.transparent,
            isExpanded: item.isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Row(children: [
                  item.icon,
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    item.header,
                    style: poppinFonts(Colors.black, FontWeight.normal, 15),
                  ),
                ]),
              );
            },
            body: item.id != 1
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      item.body,
                      textAlign: TextAlign.justify,
                      style: poppinFonts(Colors.black, FontWeight.normal, 15),
                    ),
                  )
                : SizedBox(
                  child: ExpansionPanelList(
                      elevation: 0,
                      dividerColor: Colors.transparent,
                        expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          headerOneItems[index].isExpanded = !headerOneItems[index].isExpanded;
                          for (int i = 0; i < headerOneItems.length; i++) {
                            if (i != index) {
                              headerOneItems[i].isExpanded = false;
                            }
                          }
                        });
                      },
                      children: headerOneItems.map((ExpansionItem element){
                          return ExpansionPanel(
                          backgroundColor: Colors.transparent,
                          isExpanded: element.isExpanded,
                          headerBuilder: (BuildContext context, bool isExpanded){
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal:25),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Row(children: [
                                  element.icon,
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    element.header,
                                    style: poppinFonts(
                                        Colors.black, FontWeight.normal, 15),
                                  ),
                                ]),
                              );
                          }, body: Container(
                              padding: EdgeInsets.symmetric(horizontal: 35),
                              child: Text(
                                element.body,
                                textAlign: TextAlign.justify,
                                style: poppinFonts(
                                    Colors.black, FontWeight.normal, 15),
                              ),
                            ));
                      }).toList(),
                  ),
                )                
                );
      }).toList(),
    ));
  }
}

class ExpansionItem {
  bool isExpanded;
  final String header;
  final String body;
  final Icon icon;
  final int id;

  ExpansionItem(
      {this.isExpanded = false,
      required this.header,
      required this.id,
      required this.body,
      required this.icon});
}
