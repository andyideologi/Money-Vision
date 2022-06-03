// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise/utils/constants.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({Key? key, required this.items}) : super(key: key);
  final List<ExpansionItem> items;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // radius of 10
              color: Color(0xFFd00657) // green as background color
              ),
          child: ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.only(top: 0),
            elevation: 0,
            dividerColor: Colors.white,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                widget.items[index].isExpanded =
                    !widget.items[index].isExpanded;
                for (int i = 0; i < widget.items.length; i++) {
                  if (i != index) {
                    widget.items[i].isExpanded = false;
                  }
                }
              });
            },
            children: widget.items.map((ExpansionItem item) {
              return ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: Colors.transparent,
                  isExpanded: item.isExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          item.header,
                          softWrap: true,
                          maxLines: null,
                          style: poppinFonts(Colors.white, FontWeight.bold, 15),
                        ),
                      ]),
                    );
                  },
                  body: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade100),
                    child: ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.only(top: 0),
                      elevation: 0,
                      dividerColor: Colors.white,
                      expansionCallback: (int indexi, bool isExpanded) {
                        setState(() {
                          item.body[indexi].isExpanded =
                              !item.body[indexi].isExpanded;
                          for (int i = 0; i < item.body.length; i++) {
                            if (i != indexi) {
                              item.body[i].isExpanded = false;
                            }
                          }
                        });
                      },
                      children: item.body.map((ExpansionService element) {
                        print(item.header.toString());
                        return ExpansionPanel(
                            canTapOnHeader: true,
                            backgroundColor: Colors.transparent,
                            isExpanded: element.isExpanded,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        element.header,
                                        softWrap: true,
                                        maxLines: null,
                                        style: poppinFonts(Colors.black,
                                            FontWeight.normal, 12),
                                      ),
                                    ]),
                              );
                            },
                            body: Column(children: [
                              Container(
                                color: Colors.white,
                                // margin: EdgeInsets.fromLTRB(27, 0, 27, 0),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  element.body,
                                  softWrap: true,
                                  maxLines: null,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ]));
                      }).toList(),
                    ),
                  ));
            }).toList(),
          )),
    );
  }
}

class ExpansionItem {
  bool isExpanded;
  final String header;
  final List<ExpansionService> body;
  final int id;

  ExpansionItem({
    this.isExpanded = false,
    required this.header,
    required this.id,
    required this.body,
  });
}

class ExpansionService {
  bool isExpanded;
  final String header;
  final String body;
  final int id;

  ExpansionService({
    this.isExpanded = false,
    required this.header,
    required this.id,
    required this.body,
  });
}
