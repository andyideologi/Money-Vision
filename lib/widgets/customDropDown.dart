// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

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
    return SizedBox(
        child: ExpansionPanelList(
      elevation: 0,
      dividerColor: Colors.transparent,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.items[index].isExpanded = !widget.items[index].isExpanded;
          for (int i = 0; i < widget.items.length; i++) {
            if (i != index) {
              widget.items[i].isExpanded = false;
            }
          }
        });
      },
      children: widget.items.map((ExpansionItem item) {
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
            body:SizedBox(
                  child: ExpansionPanelList(
                      elevation: 0,
                      dividerColor: Colors.transparent,
                        expansionCallback: (int indexi, bool isExpanded) {
                        setState(() {
                          item.body[indexi].isExpanded = !item.body[indexi].isExpanded;
                          for (int i = 0; i < item.body.length; i++) {
                            if (i != indexi) {
                              item.body[i].isExpanded = false;
                            }
                          }
                        });
                      },
                      children: item.body.map((ExpansionService element){
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    element.header,
                                    style: poppinFonts(Colors.black, FontWeight.normal, 15),
                                  ),
                                ]),
                              );
                          }, body: Container(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text(element.body),
                            ));
                      }).toList(),
                  ),
                )                
                );
      }).toList(),
    )
    );
  }
}

class ExpansionItem {
  bool isExpanded;
  final String header;
  final List<ExpansionService> body;
  final int id;

  ExpansionItem(
      {this.isExpanded = false,
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

  ExpansionService(
      {this.isExpanded = false,
        required this.header,
        required this.id,
        required this.body,
      });
}
