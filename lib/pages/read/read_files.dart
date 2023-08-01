import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_blue_app/pages/read/read_folders.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/download_file_provider.dart';
import '../home.dart';

class ReadFiles extends StatefulWidget {
  var path;
  var exist;

  ReadFiles({Key key, this.path, this.exist}) : super(key: key);

  @override
  State<ReadFiles> createState() => _ReadFilesState();
}

class _ReadFilesState extends State<ReadFiles> {
  var files;
  bool bi;
  var imgi = "no picture";
  var p;
  Map calcule;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<downloadFileProvider>(context, listen: false)
          .fctListFiles(widget.path);
      getrole();
    });
    var calcule1 = File(this.widget.path.path.toString() + "/Final report.json")
        .readAsStringSync();

    print("1998" +
        Directory(this.widget.path.path.toString()).listSync().toString());

    var lo = Directory(this.widget.path.path.toString()).listSync();
    print("1444" + lo.toString());
    for (int i = 0; i < lo.length; i++) {
      if (lo[i].toString().contains("jpg")) {
        print("1444" + lo[i].toString());
        imgi = lo[i].path.toString();
      }
    }
    calcule = jsonDecode(calcule1);
    log(calcule["Vehicles"].toString());
    super.initState();
  }

  Future<void> getrole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      p = prefs.getBool("color");
    });
    // print("colorcolor : $p");
  }

  Widget imageDialog(text, path, context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$text',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close_rounded),
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(255, 240, 240, 240),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Image.file(
              File(path.toString().substring(1)),
              scale: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    var files =
        Provider.of<downloadFileProvider>(context, listen: true).listFiles;

    var keys = [];
    List v45 = [];
    if (calcule == null) {
      var calcule1 =
          File(this.widget.path.path.toString() + "/Final report.json")
              .readAsStringSync();

      calcule = jsonDecode(calcule1);
    }

    if (calcule == null) {
      var calcule1 =
          File(this.widget.path.path.toString() + "/Final report.json")
              .readAsStringSync();
      log(calcule1);
      calcule = jsonDecode(calcule1);
      calcule.forEach(
        (key, value) {
          if (value.toString() == "null") {
            v45.add(key.toString());
          }
        },
      );

      calcule.removeWhere(
          (element, values) => calcule[element].toString().contains("{}"));
    } else {
      calcule.forEach(
        (key, value) {
          if (value.toString() == "null") {
            v45.add(key.toString());
          }
        },
      );

      calcule.removeWhere(
          (element, values) => calcule[element].toString().contains("{}"));
    }
    calcule.forEach((key, value) async {
      if (key.toString() == "Vehicles") {
        var newPath100;
        var pathlist = await ExternalPath.getExternalStorageDirectories();
        if (pathlist.length > 1) {
          newPath100 = pathlist[1];
        } else {
          newPath100 = pathlist[0];
        }

        value["image_vehicle"] = newPath100.toString() +
            "/bridge/vehicle/vehicle_" +
            value["Registration_plate"] +
            ".jpg";
      }
    });

    for (var i = 0; i < v45.length; i++) {
      calcule.remove(v45[i]);
    }

    if (calcule != null) {
      keys = calcule.keys.toList();
    }
    return Scaffold(
        body: SafeArea(
      child: calcule == null
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Column(children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                Home(color: false),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 15),
                        child: Provider.of<downloadFileProvider>(context,
                                        listen: false)
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
                          "Inspection report",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    height: h * 0.60,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          keys.isEmpty
                              ? Center(
                                  child: Container(child: Text(" Is Empty")),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: keys.length,
                                  itemBuilder: (context, index) {
                                    List text = [];
                                    var values = calcule[keys[index]]
                                        .toString()
                                        .substring(
                                            1,
                                            calcule[keys[index]]
                                                    .toString()
                                                    .length -
                                                1);
                                    text = values.split(',');

                                    return Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Container(
                                          margin: EdgeInsets.only(right: 0.5),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255))),
                                          child: ExpansionTile(
                                              maintainState: true,
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "${keys[index]} ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Buffalo',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            22.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              text.length,
                                                          // ignore: missing_return
                                                          itemBuilder:
                                                              (context, i) {
                                                            if (!text[i]
                                                                .toString()
                                                                .contains(
                                                                    "§R")) {
                                                              if (!keys[index]
                                                                  .toString()
                                                                  .contains(
                                                                      "Phoaphs")) {
                                                                if (p ==
                                                                        false &&
                                                                    keys[index] ==
                                                                        "Calculation" &&
                                                                    i > 1) {
                                                                  return Text(
                                                                      "");
                                                                } else {
                                                                  text[
                                                                      i] = text[
                                                                          i]
                                                                      .toString()
                                                                      .trim();
                                                                  var s;

                                                                  s = text[i]
                                                                      .toString()
                                                                      .split(
                                                                          ": ");

                                                                  return Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                140,
                                                                            child:
                                                                                Text(
                                                                              "${s[0].toString()}",
                                                                              style: TextStyle(fontSize: 16),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                              child: Container(
                                                                                  child: s[1].toString().contains(".jpg") && !s[1].toString().contains("vehicle_")
                                                                                      ? InkWell(
                                                                                          child: Image.file(
                                                                                            File(imgi.toString()),
                                                                                            scale: 1.0,
                                                                                          ),
                                                                                        )
                                                                                      :s[1].toString().contains(".jpg") && s[1].toString().contains("vehicle_")
                                                                                      ? InkWell(
                                                                                          child: Image.file(
                                                                                            File(s[1].toString()),
                                                                                            scale: 1.0,
                                                                                          ),
                                                                                        )
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      
                                                                                      : Text(
                                                                                          "${s[1]}",
                                                                                          softWrap: true,
                                                                                          style: TextStyle(fontSize: 15),
                                                                                        )))
                                                                        ],
                                                                      ),
                                                                      Divider(
                                                                        height:
                                                                            10,
                                                                        thickness:
                                                                            1,
                                                                        color: Color.fromARGB(
                                                                            22,
                                                                            78,
                                                                            78,
                                                                            78),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                              }
                                                            }
                                                          },
                                                        )
                                                      ],
                                                    ))
                                              ]),
                                        ));
                                  }),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // widget.exist == true
                      //     ?
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF4A8522)),
                        ),
                        child: Text("Send"),
                        onPressed: () async {
                          try {
                            Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .fctListFolders();
                            final dataDir = widget.path;
                            var ret;
                            List listDirectory = await dataDir.listSync();
                            print("listDirectory :${listDirectory}");
                            for (var i = 0; i < listDirectory.length; i++) {
                              if (listDirectory[i]
                                      .toString()
                                      .contains('json') ==
                                  true) {
                                ret = await listDirectory[i];
                              }
                            }
                            print("ooo" + dataDir.path + "/Final report.json");
                            print("ooo" + ret.path.toString());
                            var c4;

                            File(dataDir.path + "/notsend.json").delete();
                            File(dataDir.path + "/Vehicles.json").delete();

                            print("95996" + dataDir.path);

                            print("999569" +
                                Directory(dataDir.path).listSync().toString());
                            List<String> k = [];
                            for (var i = 0;
                                i < Directory(dataDir.path).listSync().length;
                                i++) {
                              k.add(Directory(dataDir.path)
                                  .listSync()[i]
                                  .path
                                  .toString());
                            }
                            var newPath100;
                            var pathlist = await ExternalPath
                                .getExternalStorageDirectories();
                            if (pathlist.length > 1) {
                              newPath100 = pathlist[1];
                            } else {
                              newPath100 = pathlist[0];
                            }

                            newPath100 = newPath100 +
                                "/bridge/vehicle/vehicle_" +
                                calcule["Vehicles"]["Registration_plate"]
                                    .toString() +
                                ".jpg";
                            log("herehereherehere636556" +
                                newPath100.toString());
                            k.add(newPath100.toString());

                            print("9996" + k.toString());

                            final Email sendEmail = Email(
                              body: 'your inspection is compressed',
                              subject: 'Final report',
                              recipients: ['oussama.fersi2.ext@bridgestone.eu'],
                              attachmentPaths: k,
                              isHTML: false,
                            );
                            await FlutterEmailSender.send(sendEmail);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ReadFolders()));
                          } catch (_) {}
                        },
                      )
                      //  : Container()
                      ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/Bridgestone-Logo.png",
                          width: 200,
                        ),
                      ),
                    ],
                  )
                ]),
    ));
  }
}
