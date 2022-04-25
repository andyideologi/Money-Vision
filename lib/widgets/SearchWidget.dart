// ignore_for_file: unnecessary_new, unused_local_variable, prefer_const_constructors, unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise/utils/constants.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.hintText})
      : super(key: key);
  String text;
  ValueChanged<String> onChanged;
  String hintText;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final activeStyle = poppinFonts(Colors.black, FontWeight.normal, 15);
    final hintStyle = poppinFonts(Colors.black54, FontWeight.normal, 15);
    final style = widget.text.isEmpty ? hintStyle : activeStyle;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          boxShadow: kBoxShadows,
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 15, 10, 10),
          icon: Icon(
            Icons.search,
            color: style.color,
          ),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: style.color,
                  ),
                  onTap: () {
                    Future.delayed(Duration(microseconds: 500), () {
                      //call back after 500  microseconds
                      _controller.clear(); // clear textfield
                    });
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
