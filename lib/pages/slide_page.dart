// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_app/const_variable.dart';
import 'package:flutter_blue_app/pages/home.dart';
import 'package:flutter_blue_app/pages/input/input_photograph.dart';
import 'package:flutter_blue_app/pages/tyre%20inspection/tyre_inspection.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_blue_app/pages/test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/download_file_provider.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart';
import 'package:external_path/external_path.dart';

// ignore: must_be_immutable
class Slidepage extends StatefulWidget {
  List title;
  var c1;
  var c2;
  var n1;
  Slidepage({Key key, this.title, this.c1, this.c2, this.n1}) : super(key: key);
  @override
  State<Slidepage> createState() => _SlidepageState();
}

class _SlidepageState extends State<Slidepage> {
  TimeOfDay time = TimeOfDay.now();
  DateTime know = DateTime.now();
  String formattedDate;
  String rand_id;
  var atmp = 0;
  var airm = 0;
  var temp = 0;
  var iar;
  var lead;
  var frontrc;
  var rearrc;
  var slip;
  var axeldiff;
  var rcratio;
  var rf;

  var iaravg;
  var leadavg;
  var rfavg;
  var frontrcravg;
  var rearrcavg;
  var axledfavg;
  var rcratioavg;
  var slipavg;

  String typetest;
  List tm = [];
  List<StorageInfo> storageInfo = [];
  bool loading = false;
  double progress = 0;
  List avg = [];
  var p4;
  var positionName;
  DateTime now = DateTime.now();

  var jsonCalculation;
  var jsonDetails;

  String id;

  String dm;
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;
  var v3;
  List na = ["Lead Lag", "Slip %", "Axle Test", "Iar rc lead", "Iar"];
  // getPosition() async {
  //   loc.Location location = new loc.Location();

  //   bool _serviceEnabled;
  //   loc.PermissionStatus _permissionGranted;
  //   loc.LocationData _locationData;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {

  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationData = await location.getLocation();
  //   final coordinates =
  //       new Coordinates(_locationData.latitude, _locationData.longitude);
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   var name = first.adminArea + '_' + first.subAdminArea.split(' ').join('_');
  //   return name;
  // }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  int avv;
  List ccc = [];
  Future<bool> saveFile() async {
    Directory directory;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // widget.c2 = prefs.getBool('color');
    print(
        "wfnbcvxcvbn,bcvxw,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,," +
            widget.c2.toString());
    try {
      if (Platform.isAndroid) {
        String newPath = "";
        if (await _requestPermission(Permission.storage)) {
          // directory = (await getExternalStorageDirectory());
          // 
          // List<String> paths = directory.path.split("/");
          // for (int x = 1; x < paths.length; x++) {
          //   String folder = paths[x];
          //   if (folder != "Android") {
          //     newPath += "/" + folder;
          //   } else {
          //     break;
          //   }
          // }
                 var pathlist = await ExternalPath.getExternalStorageDirectories();
          if (pathlist.length > 1) {
            newPath = pathlist[1];
          }
          else{
                        newPath = pathlist[0];

          }
          print("herehereherehere" + pathlist.toString());

          String formattedDate = DateFormat('dd-MM-yyyy–kk-mm').format(now);

          SharedPreferences prefs1 = await SharedPreferences.getInstance();

          String path = prefs1.getString('path');
          print("pathpathpathpathpath : $path");

          newPath = newPath +
              "/bridge/" +
              "$formattedDate" +
              "_" +
              widget.n1.toString();
          await Provider.of<downloadFileProvider>(context, listen: false)
              .setP1(newPath);

          print("directorydirectorydirectory : $directory");

          directory = Directory(newPath);
          print("jnlsjlsssssssssssssssssssssssssssssssssssssssssssss" +
              newPath.toString());
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('path', newPath.toString());
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      avv = widget.title.length.toInt();

      String test;
      List test1;
      int row = 16;
      int col = 16;
      int m = widget.title.length.toInt();

      var t1 = List.generate(row, (i) => List(col));

      var test0 = List.generate(row, (i) => List(col));
      for (var i = 0; i < widget.title.length; i++) {
        test = widget.title[i];
        test1 = test.split(',');
        if (test1[0] == "") {
          test1.removeAt(0);
        }

        for (var j = 0; j < 15; j++) {
          test0[i][j] = test1[j];
        }
      }

      for (var i = 0; i < widget.title.length; i++) {
        //lead
        t1[i][1] =
            ((((double.parse(test0[i][4 - 1]) / double.parse(test0[i][6 - 1])) /
                        (double.parse(test0[i][3 - 1]) /
                            double.parse(test0[i][5 - 1]))) -
                    1) *
                100);

        if (test0[0][1].toString().contains("&5")) {
          // print("eeeeeeeeeeeeee1" + test0[0][1].toString());

          t1[i][0] =
              (double.parse(test0[i][3 - 1]) / double.parse(test0[i][5 - 1]));
        } else {
          t1[i][0] =
              (double.parse(test0[i][4 - 1]) / double.parse(test0[i][6 - 1]));
        }
        print("eeeeeeeeeeeeee1" + t1[i][0].toString());
        t1[i][2] = ((double.parse(test0[i][8 - 1]) * 10) /
            (double.parse(test0[i][3 - 1]) / 4096));
        t1[i][3] = ((double.parse(test0[i][8 - 1]) * 10) /
            (double.parse(test0[i][5 - 1]) / 4096));

        var f1 = (((double.parse(test0[i][3 - 1]) / 4096) +
                (double.parse(test0[i][5 - 1]) / 4096)) /
            2);

        var da = ((double.parse(test0[i][8 - 1]) / f1));

        var f2 = (((double.parse(test0[i][4 - 1]) / 4096) +
                (double.parse(test0[i][6 - 1]) / 4096)) /
            2);

        var db = ((double.parse(test0[i][9 - 1]) / f2));
        t1[i][4] = ((1 - (db / da)) * 100);

        print("nnnnn" + t1[i][0].toString());
        print("nnnnnl" + db.toString());
        print("rrrrr" + t1[i][4].toString());

        t1[i][5] = ((double.parse(test0[i][3 - 1]) / 4096) -
            (double.parse(test0[i][5 - 1]) / 4096));
        t1[i][6] = ((double.parse(test0[i][3 - 1]) / 4096) /
            ((double.parse(test0[i][5 - 1]) / 4096)));
        t1[i][7] =
            (double.parse(test0[i][3 - 1]) / double.parse(test0[i][5 - 1]));
      }
      print("ali\\${t1}");

      for (var i = 0; i < widget.title.length; i++) {
        if (test0[i][11 - 1] != null) {
          temp = temp + int.parse(test0[i][11 - 1]);
        }
      }
      for (var i = 0; i < widget.title.length; i++) {
        if (test0[i][12 - 1] != null) {
          atmp = atmp + int.parse(test0[i][12 - 1]);
        }
      }
      for (var i = 0; i < widget.title.length; i++) {
        if (test0[i][12 - 1] != null) {
          airm = airm + int.parse(test0[i][13 - 1]);
        }
      }

      double s = 0;
      print("rami\\${widget.title.length}");

      id = test0[0][1 - 1].toString();
      dm = test0[0][7 - 1].toString();
      var rsa =
          "${test0[0][2].toString()}& ${test0[0][4].toString()} A /${test0[0][3].toString()} & ${test0[0][5].toString()} B";
      double t = 0;
      var t10;
      var avg1 = [];
      for (var j = 0; j < 8; j++) {
        for (var i = 0; i < widget.title.length; i++) {
          s += t1[i][j];

          // print(s);
        }
        t10 = s / widget.title.length;
        // print("t10 :" + t10.toString());
        // print("j :" + j.toString());
        avg1.add(t10);
        s = 0;
      }
      print("objectobjectobjectobjectobjectobjectobject" + avg1.toString());

      setState(() {
        avg = avg1;
      });

      print("tttttt" + avg.toString());
      iaravg = avg[0].toStringAsFixed(3);
      leadavg = avg[1].toStringAsFixed(1);
      rfavg = avg[7].toStringAsFixed(3);
      frontrcravg = avg[2].toStringAsFixed(3);
      rearrcavg = avg[3].toStringAsFixed(3);
      axledfavg = avg[5].toStringAsFixed(3);
      rcratioavg = avg[6].toStringAsFixed(3);
      slipavg = avg[4].toStringAsFixed(3);

      typetest = test0[0][1].toString();

      print("ddddddddddddddddd" + typetest.toString());
      if (typetest.contains("1")) {
        iar = false;
        lead = true;
        frontrc = false;
        rearrc = false;
        slip = false;
        axeldiff = false;
        rcratio = false;
        rf = false;

        iaravg = "N/A";
        leadavg = avg[1].toStringAsFixed(1);
        rfavg = "N/A";
        frontrcravg = "N/A";
        rearrcavg = "N/A";
        axledfavg = "N/A";
        rcratioavg = "N/A";
        slipavg = "N/A";
      }
      if (typetest.contains("2")) {
        iar = false;
        lead = false;
        frontrc = false;
        rearrc = false;
        slip = true;
        axeldiff = false;
        rcratio = false;
        rf = false;

        iaravg = "N/A";
        leadavg = "N/A";
        rfavg = "N/A";
        frontrcravg = "N/A";
        rearrcavg = "N/A";
        axledfavg = "N/A";
        rcratioavg = "N/A";
        slipavg = avg[4].toStringAsFixed(2);
      }
      if (typetest.contains("3")) {
        var v1 = ((double.parse(test0[0][3 - 1]) / 4096)).toStringAsFixed(0);
        var v2 = ((double.parse(test0[0][5 - 1]) / 4096)).toStringAsFixed(0);
        v3 = v1.toString() + " / " + v2.toString();
        iar = false;
        lead = false;
        frontrc = false;
        rearrc = false;
        slip = false;
        axeldiff = true;
        rcratio = true;
        rf = false;
        iaravg = "N/A";
        leadavg = "N/A";
        rfavg = "N/A";
        frontrcravg = "N/A";
        rearrcavg = "N/A";
        axledfavg = avg[5].toStringAsFixed(2);
        rcratioavg = v3.toString();
        slipavg = "N/A";
      }
      if (typetest.contains("4")) {
        iar = true;
        lead = true;
        frontrc = false;
        rearrc = false;
        slip = false;
        axeldiff = false;
        rcratio = false;
        rf = true;

        iaravg = avg[0].toStringAsFixed(3);
        leadavg = avg[1].toStringAsFixed(1);
        rfavg = avg[7].toStringAsFixed(0);
        frontrcravg = "N/A";
        rearrcavg = "N/A";
        axledfavg = "N/A";
        rcratioavg = "N/A";
        slipavg = "N/A";
      }
      if (typetest.contains("5")) {
        iar = true;
        lead = false;
        frontrc = false;
        rearrc = false;
        slip = false;
        axeldiff = false;
        rcratio = false;
        rf = false;

        iaravg = avg[0].toStringAsFixed(3);
        leadavg = "N/A";
        rfavg = "N/A";
        frontrcravg = "N/A";
        rearrcavg = "N/A";
        axledfavg = "N/A";
        rcratioavg = "N/A";
        slipavg = "N/A";
      }
      var da1 = int.parse(test0[0][7].toString());
      var db1 = int.parse(test0[0][8].toString());
      var da = da1 / 100;
      var db = db1 / 100;
      var calculejson = {
        "Lead": leadavg.toString(),
        "IAR": iaravg.toString(),
        "Front RC": frontrcravg.toString(),
        "Rear RC": rearrcavg.toString(),
        "RC Ratio": rfavg.toString(),
        "Slip": slipavg.toString(),
        "Difference": axledfavg.toString(),
        "Ratio": rcratioavg.toString(),
        "Distance A": da.toString(),
        "Distance B": db.toString(),
      };
      print("ggg8gyu" + calculejson.toString());

      test = calculejson.toString();

      jsonCalculation = calculejson;

      ccc.add(leadavg.toString());
      ccc.add(iaravg.toString());
      ccc.add(frontrcravg.toString());
      ccc.add(rearrcavg.toString());
      ccc.add(rfavg.toString());
      ccc.add(slipavg.toString());
      ccc.add(axledfavg.toString());
      ccc.add(rcratioavg.toString());
      var tyrematchjson = {
        "TM_Inspection_id": "$rand_id",
        "Tyre_match_kit_id": id.toString(),
        "RS1 A": "${test0[0][2].toString()}",
        "RS2 A": "${test0[0][4].toString()}",
        "RS1 B": "${test0[0][3].toString()}",
        "RS2 B": "${test0[0][5].toString()}",
        "Distance_mode": dm.toString(),
        "AtmPresure": "${atmp * 0.01 / widget.title.length}",
        "Temperature": "${temp * 0.01 / widget.title.length}",
        "Air_moisture": "${airm / widget.title.length}",
        "Test_counter": "${typetest}",
      };
      print("888" + calculejson.toString());
      Provider.of<downloadFileProvider>(context, listen: false)
          .setCalculation(calculejson);

      Provider.of<downloadFileProvider>(context, listen: false)
          .setTyrematch(tyrematchjson);

      String pos;
      List long;
      List lat;
      List gg;
      var didi = await _determinePosition();
      print("998877" + didi.toString());
      do {
        didi = await _determinePosition();
      } while (didi == null);

      if (didi.toString().isNotEmpty) {
        gg = didi.toString().split(",");
        lat = gg[0].toString().split(":");
        long = gg[1].toString().split(":");

        pos = "${lat[1].toString()} , ${long[1].toString}";
      }
      jsonDetails = {
        "Session_name": widget.n1,
        "Location ": "${lat[1].toString()} ${long[1].toString()}",
        "Date": DateFormat('dd-MM-yyyy–kk-mm').format(now),
      };
      Provider.of<downloadFileProvider>(context, listen: false)
          .setDetails(jsonDetails);
      print("didi" + jsonDetails.toString());
    } catch (e) {}

    print("5455454" +
        Provider.of<downloadFileProvider>(context, listen: false)
            .calculation
            .toString());
    print("5455454" +
        Provider.of<downloadFileProvider>(context, listen: false)
            .details
            .toString());
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    rand_id = Random().nextInt(999999).toString() + "_$formattedDate";

    widget.n1 = Provider.of<downloadFileProvider>(context, listen: false).name;
    widget.c2 =
        Provider.of<downloadFileProvider>(context, listen: false).status;

    // widget.c2 = "true";

    WidgetsBinding.instance.addPostFrameCallback((_) => saveFile());
    print(";;;;;;;;;;;;" + widget.n1.toString());

    super.initState();
    print(
        "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy|||${widget.c2}");
  }

  int activateIndex = 0;
  List finish = [];
  Widget buildindicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activateIndex,
      count: 2,
      effect: SlideEffect(),
    );
  }

  Future<bool> exitConfirm() async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<bool> exitConfirm3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () {
              Navigator.of(context).pop();
            },
            child: AlertDialog(
              title: Text(
                "Do you want to make the tyre inspection now ? ",
                style: TextStyle(fontSize: 14),
              ),
              content: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          child: Text("Yes"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 50, 129, 54)),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => TyreInspection1()),
                            );
                          })),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 151, 17, 17)),
                          ),
                          child: Text(
                            "No",
                          ),
                          onPressed: () async {
                            var tyreInspection = {
                              "date_inspection": "N/A",
                              "hours": "N/A",
                              "RTD-FL": "N/A",
                              "RTD-RL": "N/A",
                              "RTD-FR": "N/A",
                              "RTD-RR": "N/A",
                              "Ip-FL": "N/A",
                              "Ip-RL": "N/A",
                              "Ip-FR": "N/A",
                              "Ip-RR": "N/A",
                              "Type-Damage-FL": "N/A",
                              "Type-Damage-RL": "N/A",
                              "Type-Damage-FR": "N/A",
                              "Type-Damage-RR": "N/A",
                              "Comments-damage-FL": "N/A",
                              "Comments-damage-RL": "N/A",
                              "Comments-damage-FR": "N/A",
                              "Comments-damage-RR": "N/A",
                              "Serial-number-FL": "N/A",
                              "Serial-number-RL": "N/A",
                              "Serial-number-FR": "N/A",
                              "Serial-number-RR": "N/A",
                              "Fitting-hours-FL": "N/A",
                              "Fitting-hours-RL": "N/A",
                              "Fitting-hours-FR": "N/A",
                              "Fitting-hours-RR": "N/A",
                            };
                            print("zzzzzz" + tyreInspection.toString());

                            var tyrematchjson = {
                              "TM_Inspection_id": "N/A",
                              "Tyre_match_kit_id": "N/A",
                              "RS1 A": "N/A",
                              "RS2 A": "N/A",
                              "RS1 B": "N/A",
                              "RS2 B": "N/A",
                              "Distance_mode": "N/A",
                              "AtmPresure": "N/A",
                              "Temperature": "N/A",
                              "Air_moisture": "N/A",
                              "Test_counter": "N/A",
                            };
                            DateTime now = DateTime.now();
                            String formattedDate =
                                DateFormat('dd-MM-yyyy–kk-mm-ss').format(now);
                            String pos;
                            List long;
                            List lat;
                            List gg;
                            var didi = await _determinePosition();
                            print("998877" + didi.toString());
                            do {
                              didi = await _determinePosition();
                            } while (didi == null);

                            if (didi.toString().isNotEmpty) {
                              gg = didi.toString().split(",");
                              lat = gg[0].toString().split(":");
                              long = gg[1].toString().split(":");
                            }
                            await Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .setName(formattedDate + "TI");
                            print("11111");
                            var jsonDetails = {
                              "Session_name": formattedDate + "TI",
                              "Location ":
                                  "${lat[1].toString()} ${long[1].toString()}",
                              "Date": formattedDate,
                            };
                            print("11111");

                            await Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .setDetails(jsonDetails);
                            await Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .setTyrematch(tyrematchjson);
                            print("object1");
                            await Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .setInputTyreInspection(tyreInspection);
                            print("object");
                            print("111111" +
                                await Provider.of<downloadFileProvider>(context,
                                        listen: false)
                                    .inputTyreInspection
                                    .toString());
                            print("ytytytytty" + ccc.toString());

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => InputPhotographs(
                                      check: "ohh", calcul: ccc)),
                            );
                            //  Navigator.of(context).pop();
                          }))
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  Future<bool> exitConfirm2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String path = prefs.getString('path');

    prefs.remove("path");

    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                "This will delete all your received data and calculated values ",
                style: TextStyle(fontSize: 14),
              ),
              content: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          child: Text("Proceed"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 50, 129, 54)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => Home()),
                                (_) => false);
                          })),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 151, 17, 17)),
                          ),
                          child: Text(
                            "Cancel",
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }))
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var top = Get.statusBarHeight;
    double h = MediaQuery.of(context).size.height;
    // return WillPopScope(
    //   onWillPop: exitConfirm2,
    //   child: Builder(builder: (context) {
    //  saveFile();
    return Center(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Container(
                      height: h * 0.96,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
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
                                    child: Provider.of<downloadFileProvider>(
                                                    context,
                                                    listen: false)
                                                .status ==
                                            "false"
                                        ? Image.asset("assets/images/basic.png")
                                        : Image.asset(
                                            "assets/images/advanced.png"),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  color:
                                      const Color.fromARGB(255, 127, 127, 127),
                                  child: Center(
                                    child: Text(
                                      "Calculations",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          iar == true
                              ? avg.isEmpty
                                  ? Text("empty")
                                  : Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 8.0),
                                            width: 140,
                                            child: Text(
                                              "IAR ",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 19, 107, 11)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              " ${avg[0].toStringAsFixed(3)}",
                                              style: GoogleFonts.lora(
                                                textStyle: styledata,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                              : Container(),
                          lead == true
                              ? avg.isEmpty
                                  ? Text("empty")
                                  : Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 8.0),
                                            width: 140,
                                            child: Text(
                                              "Lead % ",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 19, 107, 11)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              " ${avg[1].toStringAsFixed(1)}",
                                              style: GoogleFonts.lora(
                                                textStyle: styledata,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                              : Container(),
                          rf == true
                              ? avg.isEmpty
                                  ? Text("empty")
                                  : Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 8.0),
                                            width: 140,
                                            child: Text(
                                              "Axle Analysis",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 19, 107, 11)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              " ${avg[7].toStringAsFixed(3)}",
                                              style: GoogleFonts.lora(
                                                textStyle: styledata,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                              : Container(),
                          frontrc == true
                              ? widget.c2.toString() == "false"
                                  ? Container()
                                  : avg.isEmpty
                                      ? Text("empty")
                                      : Row(
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 8.0),
                                                width: 140,
                                                child: Text(
                                                  "Front RC ",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 19, 107, 11)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  " ${avg[2].round()}",
                                                  style: GoogleFonts.lora(
                                                    textStyle: styledata,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                              : Container(),
                          rearrc == true
                              ? widget.c2.toString() == "false"
                                  ? Container()
                                  : avg.isEmpty
                                      ? Text("empty")
                                      : Row(
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 8.0),
                                                width: 140,
                                                child: Text(
                                                  "Rear RC ",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 19, 107, 11)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  " ${avg[3].round()}",
                                                  style: GoogleFonts.lora(
                                                    textStyle: styledata,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                              : Container(),
                          slip == true
                              ? widget.c2.toString() == "false"
                                  ? Container()
                                  : avg.isEmpty
                                      ? Text("empty")
                                      : 1 == 1 //typetest.contains("2")
                                          ? Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(start: 8.0),
                                                    width: 140,
                                                    child: Text(
                                                      "Slip % ",
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    )),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color.fromARGB(
                                                              255,
                                                              19,
                                                              107,
                                                              11)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      " ${avg[4].toStringAsFixed(2)}",
                                                      style: GoogleFonts.lora(
                                                        textStyle: styledata,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container()
                              : Container(),
                          axeldiff == true
                              ? widget.c2.toString() == "false"
                                  ? Container()
                                  : avg.isEmpty
                                      ? Text("empty")
                                      : Row(
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 8.0),
                                                width: 140,
                                                child: Text(
                                                  "Axle difference ",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 19, 107, 11)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  " ${axledfavg}",
                                                  style: GoogleFonts.lora(
                                                    textStyle: styledata,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                              : Container(),
                          rcratio == true
                              ? widget.c2.toString() == "false"
                                  ? Container()
                                  : avg.isEmpty
                                      ? Text("empty")
                                      : Row(
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 8.0),
                                                width: 140,
                                                child: Text(
                                                  "RC ratio ",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                )),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 19, 107, 11)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  " ${v3}",
                                                  style: GoogleFonts.lora(
                                                    textStyle: styledata,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                              : Container(),

                          Column(children: [
                            Container(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 45,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFF4A8522)),
                                        ),
                                        onPressed: () async {
                                          exitConfirm3();
                                        },
                                        child: Text(
                                          "Next",
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Container(
                                    width: 140,
                                    height: 45,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xFF4A8522)),
                                      ),
                                      onPressed: () async {
                                        exitConfirm2();
                                      },
                                      child: Text(
                                        "Reject inspection",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //    image != null ? Image.file(image) : Text("no chosen image"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/Bridgestone-Logo.png",
                                width: 200,
                              ),
                            )
                          ]),
                          // Text("Scroll right for more details")
                          // SmoothPageIndicator(
                          //   controller: controller100,
                          //   count: 2,
                          //   effect: WormEffect(
                          //     dotHeight: 16,
                          //     dotWidth: 16,
                          //     type: WormType.thin,
                          //     // strokeWidth: 5,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
    // }

    //   ),
    //);

/*        body: Column(
          children: [
            Container(
              child: Text("${widget.title[0].text}"),
            ),
            SizedBox(
              height: 20,
            ),
            buildindicator()
          ],
        )*/
    // }
  }
}
