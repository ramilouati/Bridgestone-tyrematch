import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_app/provider/download_file_provider.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class Header extends StatefulWidget {
  String title;
  bool home;
  var calculation;
  var details;
  var date;
  var rsize;
  var fsize;
  var data;
  Header(
      {Key key,
      this.home,
      this.title,
      this.details,
      this.date,
      this.fsize,
      this.rsize,
      this.data})
      : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (widget.home==true) {
                  Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Home(color: false),
                ),
              );
              }
            
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
              child: Provider.of<downloadFileProvider>(context, listen: false)
                          .status ==
                      "false"
                  ? Image.asset("assets/images/basic.png")
                  : Image.asset("assets/images/advanced.png"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            color: const Color.fromARGB(255, 127, 127, 127),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
