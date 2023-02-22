import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_app/pages/Item.dart';
import 'package:flutter_blue_app/provider/download_file_provider.dart';
import 'package:provider/provider.dart';

import '../pages/home.dart';
import '../pages/input/modif_vehicle.dart';

class Header extends StatefulWidget {
  String title;
  var calculation;
  var details;
  var date;
  var rsize;
  var fsize;
  var data;
  Header(
      {Key key,
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
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Home(color: false),
                ),
              );
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
          Card(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                CustomListItemTwo(
                  thumbnail: File(Provider.of<downloadFileProvider>(context,
                                          listen: false)
                                      .vehicleimagepath
                                      .toString() +
                                  "/vehicle_${widget.details}.jpg")
                              .existsSync() ==
                          true
                      ? Image.file(
                          File(Provider.of<downloadFileProvider>(context,
                                      listen: false)
                                  .vehicleimagepath
                                  .toString() +
                              "/vehicle_${widget.details}.jpg"),
                          width: 100,
                          fit: BoxFit.fill,
                          height: 100,
                        )
                      : Image.asset("assets/images/tractor.png"),
                  title: "${widget.details} \n",
                  subtitle: "${widget.fsize} \n${widget.rsize}",
                  publishDate: "${widget.date}",
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ModifVehicle(
                                data: widget.data, Details: widget.details)));
                      },
                      child: Text(
                        "Modify vehicle data",
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: const Color(0xFF4A8522)),
                      )),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
