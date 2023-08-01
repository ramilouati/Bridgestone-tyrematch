// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/services.dart';
import 'package:flutter_archive/flutter_archive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blue_app/pages/test.dart';
import 'package:flutter_blue_app/provider/download_file_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import '../home.dart';

class InputPhotographs extends StatefulWidget {
  var BL;
  var tyreId;
  var inspectionId;
  var st;
  var check;
  var calcul;
  InputPhotographs(
      {Key key,
        this.BL,
        this.tyreId,
        this.inspectionId,
        this.calcul,
        this.st,
        this.check})
      : super(key: key);

  @override
  State<InputPhotographs> createState() => _InputPhotographsState();
}

class _InputPhotographsState extends State<InputPhotographs> {


  List verify1;
  PickedFile _imageFile;
  String imgn;
  DateTime now = DateTime.now();
  String pathimg;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  double ratingTraction = 0;
  double ratingRoadComfort = 0;
  double ratingVibration = 0;
  double ratingSoilCare = 0;
  var PhotographsData;
   var newPath;
  final TextEditingController _commentsController = TextEditingController();
  Map _inputPerformance = {};
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

  List l1;

  @override
  void initState() {
    super.initState();
    print("tttt" + widget.calcul.toString());

    l1 = widget.calcul;

    print("tttt" + l1.toString());
  }
  Future<void> _deleteCacheDir() async {
    log("i am working");
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);}


    final appDir = await getApplicationSupportDirectory();
    if (appDir.existsSync()) {


      appDir.deleteSync(recursive: true);


    }}


  setpa() async {
    print("setpa");
    Directory directory;
    String newPath = "";
    var pathlist = await ExternalPath.getExternalStorageDirectories();
    if (pathlist.length > 1) {
      newPath = pathlist[1];
    } else {
      newPath = pathlist[0];
    }


    // if (Provider.of<downloadFileProvider>(this.context, listen: false).p1 ==
    //     null) {
          print("setpa1");
      if (Provider.of<downloadFileProvider>(this.context, listen: false).name !=
          null) {
        String formattedDate = DateFormat('MM-dd–kk-mm').format(now);
        SharedPreferences prefs1 = await SharedPreferences.getInstance();
        String path = prefs1.getString('path');

        newPath = newPath +
            "/bridge/" +
            "$formattedDate" +
            Provider.of<downloadFileProvider>(this.context, listen: false).name;
        print("pathpathpathpathpath1 : $newPath");

        await Provider.of<downloadFileProvider>(this.context, listen: false)
            .setP1(newPath);
      } else {
        print("here5");
        String formattedDate = DateFormat('yyyy-MM-dd–kk-mm').format(now);

        SharedPreferences prefs1 = await SharedPreferences.getInstance();
        String path = prefs1.getString('path');
        print("ali" + newPath.toString());
        newPath = newPath + "/bridge/" + "$formattedDate" + "_TyreInspection";
        print("pathpathpathpathpath2 : $newPath");

        await Provider.of<downloadFileProvider>(this.context, listen: false)
            .setP1(newPath);
      }
   // }


  }

  var vers = {"Version": "1.0.12"};

  @override
  Widget build(BuildContext context) {
    var hk =
        Provider.of<downloadFileProvider>(context, listen: false).performance;
    if (hk != null) {
      _commentsController.text = hk[4].toString();
      ratingTraction=hk[0];
      ratingRoadComfort=hk[1];
      ratingVibration=hk[2];
      ratingSoilCare=hk[3];


    }

    double h6 = MediaQuery.of(context).size.height * 0.06;
    double h = MediaQuery.of(context).size.height;
    var _provider = Provider.of<downloadFileProvider>(context);
    return Center(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
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
                                    child: widget.check == "ohh"
                                        ? Center(
                                      child: Text(
                                        "Verify the results",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                        : Center(
                                      child: Text(
                                        "Tyre Performance",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    height:
                                    MediaQuery.of(context).size.height * 0.06,
                                    color: Color.fromARGB(255, 127, 127, 127),
                                  ),
                                ],
                              ),
                            ),
                            widget.st == null
                                ? Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Results of calculations :",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    !l1[0].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "Lead %",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[0]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[1].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "IAR",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[1]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[2].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "Front RC",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[2]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[3].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "Rear RC",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[3]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[4].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "R/F RC Ratio",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[4]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[5].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "Slip",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[5]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[6].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "Axle Difference",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[6]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                    !l1[7].toString().contains("N/A")
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "Right/Left",
                                              style: TextStyle(
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Text(
                                            "${l1[7]}",
                                            style:
                                            TextStyle(fontSize: 22),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(),
                                  ],
                                ),
                              ),
                            )
                                : Container(),
                            widget.st != null
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: 90,
                                      child: Text(
                                        'Traction',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "LOW",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        child: RatingBar.builder(
                                            initialRating:
                                            hk != null ? hk[0] : 0,
                                            updateOnDrag: true,
                                            minRating: 1,
                                            itemSize: 33.0,
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xFF4A8522),
                                            ),
                                            onRatingUpdate: (rating) {
                                              ratingTraction = rating;
                                            }),
                                      )),
                                  Text(
                                    "HIGH",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                            widget.st != null
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: 90,
                                      child: Text(
                                        'Road \ncomfort',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "LOW",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        child: RatingBar.builder(
                                            initialRating:
                                            hk != null ? hk[1] : 0,
                                            updateOnDrag: true,
                                            minRating: 1,
                                            itemSize: 33.0,
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xFF4A8522),
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                ratingRoadComfort = rating;
                                              });
                                            }),
                                      )),
                                  Text(
                                    "HIGH",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                            widget.st != null
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: 90,
                                      child: Text(
                                        'Vibration',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "LOW",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        child: RatingBar.builder(
                                            initialRating:
                                            hk != null ? hk[2] : 0,
                                            updateOnDrag: true,
                                            minRating: 1,
                                            itemSize: 33.0,
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              color:
                                              const Color(0xFF4A8522),
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                ratingVibration = rating;
                                              });
                                            }),
                                      )),
                                  Text(
                                    "HIGH",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                            widget.st != null
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: 90,
                                      child: Text(
                                        'Soil care',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "LOW",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        child: RatingBar.builder(
                                            initialRating:
                                            hk != null ? hk[3] : 0,
                                            updateOnDrag: true,
                                            minRating: 1,
                                            itemSize: 33.0,
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xFF4A8522),
                                            ),
                                            onRatingUpdate: (rating) {
                                              ratingSoilCare = rating;
                                            }),
                                      )),
                                  Text(
                                    "HIGH",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      widget.st != null
                                          ? Row(
                                        children: [
                                          Text(
                                            "Add inspection picture",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: imageProfile(context))
                                        ],
                                      )
                                          : Container(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      widget.st != null
                                          ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              'Comments',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Flexible(
                                              flex: 2,
                                              child: Container(
                                                  child: TextFormField(
                                                      controller:
                                                      _commentsController,
                                                      keyboardType:
                                                      TextInputType
                                                          .multiline,
                                                      maxLines: 2,
                                                      decoration: const InputDecoration(
                                                          enabledBorder: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black)),
                                                          focusedBorder: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black))))))
                                        ],
                                      )
                                          : Container(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 100,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xFF4A8522)),
                                          ),
                                          onPressed: () async {
         if (_commentsController.text =="") {
                  _commentsController.text="_";
                }
                                            setpa();
                                            try {
                                              SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

         
          














                                              // Provider.of<downloadFileProvider>(
                                              //     context,
                                              //     listen: false)
                                              //     .downloadFile(
                                              //     Provider.of<downloadFileProvider>(
                                              //         context,
                                              //         listen: false)
                                              //         .inputVehicule,
                                              //     "Vehicles");

                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                false, // user must tap button!

                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    content: SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          ElevatedButton(
                                                              onPressed: () {

                                                                verify1 = [
                                                                  ratingTraction,
                                                                  ratingRoadComfort,
                                                                  ratingVibration,
                                                                  ratingSoilCare,
                                                                  _commentsController
                                                                      .text
                                                                ];

                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setperformance(
                                                                    verify1);

                                                                Navigator.of(
                                                                    context)
                                                                    .pop();

                                                                Navigator.of(
                                                                    context)
                                                                    .pop(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                          Test(
                                                                            j: true,
                                                                          )),
                                                                );
                                                              },
                                                              style: ButtonStyle(
                                                                backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    const Color(
                                                                        0xFF4A8522)),
                                                              ),
                                                              child: Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.edit),
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Text(
                                                                        "Verify",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            20),
                                                                      ),
                                                                    ],
                                                                  ))),
                                                          ElevatedButton(
                                                              onPressed: () async {
                                                                SharedPreferences
                                                                prefs4 =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                                var a = prefs4
                                                                    .getString(
                                                                    "fname");
                                                                var b = prefs4
                                                                    .getString(
                                                                    "lname");
                                                                var c = prefs4
                                                                    .getString(
                                                                    "email");
                                                                var d = prefs4
                                                                    .getString(
                                                                    "Country");

                                                                var inputUser = {
                                                                  "First name":
                                                                  a.toString(),
                                                                  "Last name":
                                                                  b.toString(),
                                                                  "Email":
                                                                  c.toString(),
                                                                  "Country":
                                                                  d.toString()
                                                                };
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setInputuser(
                                                                    inputUser);

                                                                var st = {
                                                                  "stat": 0
                                                                };
                                                                _inputPerformance =
                                                                {
                                                                  "Traction":
                                                                  ratingTraction
                                                                      .toString(),
                                                                  "Road comfort":
                                                                  ratingRoadComfort
                                                                      .toString(),
                                                                  "Vibration":
                                                                  ratingVibration
                                                                      .toString(),
                                                                  "Soil care":
                                                                  ratingSoilCare
                                                                      .toString(),
                                                                  "Comments":
                                                                  _commentsController
                                                                      .text,
                                                                };

                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setPerformance(
                                                                    _inputPerformance);

                                                                log("1448"+_inputPerformance.toString());
                                                                log("1449"+Provider.of<
                                                                    downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .inputPerformance.toString());
                                                                if (PhotographsData== null) {
                                                                  PhotographsData = {

                                                                    "photo": "https://salesbridge.sharepoint.com/:i:/r/teams/BSEMIA-Tyrematch/Shared%20Documents/General/Tyrematch_reports/no_picture.jpg",
                                                                  };
                                                                }
                                                                var jsonFile = {
                                                                  "User": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputuser,
                                                                  "Vehicles": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputVehicule,

                                                                  "Tyre_match_Inspection":
                                                                  Provider.of<downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .Tyrematch,
                                                                  "Tyre_inspections": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputTyreInspection,
                                                                  "Calculations": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .calculation,
                                                                  "Details": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .details,

                                                                  "Performance": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputPerformance.toString(),
                                                                  "Photographs":
                                                                  PhotographsData,
                                                                  "App_version":
                                                                  vers,
                                                                };
                                                                //houni

                                                                log("1447 $jsonFile");
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .downloadFile(jsonFile, "Final report");
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .downloadFile(
                                                                    st,
                                                                    "notsend");

                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage1 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage10 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage2 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage20 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage3 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage30 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage4 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage40 =
                                                                "---";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial1Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial2Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial3Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial4Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour1Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour2Controller.text =
                                                                "";
   Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour3Controller.text =
                                                                "";                                                               
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour4Controller.text =
                                                                "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked1 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked2 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked3 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked4 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage1Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage2Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage3Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage4Controller
                                                                    .text = "";
                                                                var gg = {};

                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setCalculation(
                                                                    gg);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setDetails(gg);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setTyrematch(
                                                                    gg);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setPerformance(
                                                                    null);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setperformance(
                                                                    null);
                                                                //          await Provider.of<downloadFileProvider>(
                                                                //     context,
                                                                //     listen:
                                                                //         false)
                                                                // .setP1(
                                                                //     null);
                                                                await Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setName(
                                                                    null);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setInputTyreInspection(
                                                                    "");
                                                                _inputPerformance
                                                                    .clear();

                                                                _deleteCacheDir();
                                                                await Provider.of<downloadFileProvider>(context, listen: false)
                                                                    .setReserved_image(null);
                                                                Navigator.of(
                                                                    context)
                                                                    .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder: (_) =>
                                                                            Home(
                                                                              color: false,
                                                                            )),
                                                                        (_) =>
                                                                    false);



                                                              },
                                                              style: ButtonStyle(
                                                                backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    const Color(
                                                                        0xFF4A8522)),
                                                              ),
                                                              child: Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.save),
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Text(
                                                                        "Save & Quit",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            20),
                                                                      ),
                                                                    ],
                                                                  ))),
                                                          ElevatedButton(
                                                              onPressed: () async {
                                                                var st = {
                                                                  "stat": 0
                                                                };
                                                                _inputPerformance =
                                                                {
                                                                  "Traction":
                                                                  ratingTraction
                                                                      .toString(),
                                                                  "Road comfort":
                                                                  ratingRoadComfort
                                                                      .toString(),
                                                                  "Vibration":
                                                                  ratingVibration
                                                                      .toString(),
                                                                  "Soil care":
                                                                  ratingSoilCare
                                                                      .toString(),
                                                                  "Comments":
                                                                  _commentsController
                                                                      .text,
                                                                };
                                                                print("star" +
                                                                    _inputPerformance
                                                                        .toString());
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setPerformance(
                                                                    _inputPerformance);
                                                                SharedPreferences
                                                                prefs4 =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                                var a = prefs4
                                                                    .getString(
                                                                    "fname");
                                                                var b = prefs4
                                                                    .getString(
                                                                    "lname");
                                                                var c = prefs4
                                                                    .getString(
                                                                    "email");
                                                                var d = prefs4
                                                                    .getString(
                                                                    "Country");

                                                                var inputUser = {
                                                                  "First name":
                                                                  a.toString(),
                                                                  "Last name":
                                                                  b.toString(),
                                                                  "Email":
                                                                  c.toString(),
                                                                  "Country":
                                                                  d.toString()
                                                                };
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setInputuser(
                                                                    inputUser);
                                                                print("jjjj888j" +
                                                                    inputUser
                                                                        .toString());

                                                                if (PhotographsData== null) {
                                                                  PhotographsData = {

                                                                    "photo": "https://salesbridge.sharepoint.com/:i:/r/teams/BSEMIA-Tyrematch/Shared%20Documents/General/Tyrematch_reports/no_picture.jpg",
                                                                  };
                                                                }
                                                                var jsonFile = {
                                                                  "User": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputuser,
                                                                  "Vehicles": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputVehicule,
                                                                  "Tyre_match_Inspection":
                                                                  Provider.of<downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .Tyrematch,
                                                                  "Tyre_inspections": await Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputTyreInspection,
                                                                  "Calculations": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .calculation,
                                                                  "Details": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .details,
                                                                  "Performance": Provider.of<
                                                                      downloadFileProvider>(
                                                                      context,
                                                                      listen:
                                                                      false)
                                                                      .inputPerformance,
                                                                  "Photographs":
                                                                  PhotographsData,
                                                                  "App_version":
                                                                  vers,
                                                                };

                                                                print(
                                                                    "uuuuuuuuuuuuuuuuuuuuuuuuuu|| ${jsonFile}");
                                                                await Provider.of<downloadFileProvider>(context,listen:false).downloadFile(jsonFile,"Final report");
                                                                var p = Provider.of<
                                                                    downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .p1
                                                                    .path;
                                                                print(p.toString());

                                                                final dataDir =
                                                                Directory(p);


                                                                try {

                                                                  List<String> ooi =
                                                                  [];

                                                                  // if (pathimg !=
                                                                  //     null) {
                                                                  //   ooi.add(p +
                                                                  //       "/Final report.json");
                                                                  //   ooi.add(p +
                                                                  //       pathimg);
                                                                  //   print("111111 " +
                                                                  //       p +
                                                                  //       pathimg
                                                                  //           .toString());
                                                                  // } else {
                                                                  //   print("222222");
                                                                  //   ooi.add(p +

                                                                  //       "/Final report.json");
                                                                  // }
                                                           var newPath100;
    var pathlist = await ExternalPath.getExternalStorageDirectories();
          if (pathlist.length > 1) {
            newPath100 = pathlist[1];
          }
          
           else {
            newPath100 = pathlist[0];
          }
    
         newPath100= newPath100+"/bridge/vehicle/vehicle_"+Provider.of<downloadFileProvider>(this.context, listen: false)
            .inputVehicule["Registration_plate"].toString()+".jpg";
          log("herehereherehere636556" + newPath100.toString());

                                                                  ooi.clear();
                                                                  for (var i = 0; i < Directory(p).listSync().length; i++) {
                                                                    ooi.add(Directory(p).listSync()[i].path.toString());
                                                                  }

                                                               ooi.add(newPath100);
                                                                  print("eee1998"+ooi.toString());
                                                                //    ooi.add(newPath.toString());

                                                                  print("ttty" +
                                                                      ooi.toString());
                                                                  ooi.removeWhere((element) => element.toString().contains("Vehicles.json"));
                                                                  final Email
                                                                  sendEmail =
                                                                  Email(
                                                                    body: ' ',
                                                                    subject:
                                                                    'Final report',
                                                                    recipients: [
                                                                      'oussama.fersi2.ext@bridgestone.eu'
                                                                    ],
                                                                    attachmentPaths:
                                                                    ooi,
                                                                    isHTML: false,
                                                                  );

                                                                  print("ttty" +
                                                                      ooi.toString());
                                                                  await FlutterEmailSender
                                                                      .send(
                                                                      sendEmail);
                                                                } catch (e) {
                                                                  print(e);
                                                                }
                                                                List<String>
                                                                _listModifyFolder =
                                                                [
                                                                  "tyres",
                                                                  "inspections",
                                                                  "tyrematchInspections",
                                                                  "vehicles",
                                                                  "calculation"
                                                                ];
                                                                print(
                                                                    "pppppppppppp: ${p.toString()}");

                                                                // await prefs.clear();
                                                                _listModifyFolder =
                                                                [];
                                                                var gg = {};
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage1 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage10 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage2 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage20 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage3 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage30 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage4 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .typeDamage40 =
                                                                "---";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setCalculation(
                                                                    gg);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setDetails(gg);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setTyrematch(
                                                                    gg);

                                                                      Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial1Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial2Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial3Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .serial4Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour1Controller.text =
                                                                "";
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour2Controller.text =
                                                                "";
   Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour3Controller.text =
                                                                "";                                                               
  Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .fettinghour4Controller.text =
                                                                "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage1Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage2Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage3Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .commentsDamage4Controller
                                                                    .text = "";
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked1 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked2 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked3 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .ischaked4 =
                                                                false;
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setInputTyreInspection(
                                                                    "");
                                                                _inputPerformance
                                                                    .clear();
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setPerformance(
                                                                    null);
                                                                Provider.of<downloadFileProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .setperformance(
                                                                    null);

                                                                _deleteCacheDir();
                                                                await Provider.of<downloadFileProvider>(context, listen: false)
                                                                    .setReserved_image(null);
                                                                Navigator.of(
                                                                    context)
                                                                    .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder: (_) =>
                                                                            Home(
                                                                              color: false,
                                                                            )),
                                                                        (_) =>
                                                                    false);
                                                              },
                                                              style: ButtonStyle(
                                                                backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    const Color(
                                                                        0xFF4A8522)),
                                                              ),
                                                              child: Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.send),
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Text(
                                                                        "Save & Send",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            20),
                                                                      ),
                                                                    ],
                                                                  ))),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } catch (e) {
                                              print(",,,,,,,,,,,," + e.toString());
                                            }
                                          },
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/Bridgestone-Logo.png",
                                width: 200,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))));
  }

  Widget imageProfile(context) {
    var im =  Provider.of<downloadFileProvider>(context, listen: false)
        .reserved_image;
    if (im != null){
      var tt = im.toString().split("/");
      print("18888(1547)"+im.toString());
      print("18888(1548)"+tt[tt.length-1].toString());

      PhotographsData = {

        "photo": "https://salesbridge.sharepoint.com/:i:/r/teams/BSEMIA-Tyrematch/Shared%20Documents/General/Tyrematch_reports/${tt[tt.length-1].toString()}",
      };

    }
    return Center(
      child: InkWell(
        onTap: () {
          //bottomSheet(context);
          //  takePhoto(ImageSource.camera, context);
          // showModalBottomSheet(

          //   context: context,
          //   builder: ((builder) => ),
          // );
        },
        child: Stack(children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: _imageFile != null
                ?  FileImage(File(_imageFile.path))
                :im ==null ? AssetImage("assets/images/camera.png"):FileImage(File(im.toString())) ,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                //takePhoto(ImageSource.camera, context);

                // print("objectobjectobjectobjectobjectobject" +
                //     _isVisible.toString());
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet(context)),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          ),
        ]
        ),
      ),
    );
  }

  Widget bottomSheet(context) {

    return


      Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Choose Profile photo",
              style: TextStyle(
                fontSize: 20.0,),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>
            [
              Expanded(child: Container()),
              ElevatedButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera, context);
                },
                label: Text("Camera"),
              ),
              Expanded(child: Container()),
              ElevatedButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery, context);

                },
                label: Text("Gallery"),
              ),
              Expanded(child: Container()),
            ])
          ],
        ),
      );
  }

  void takePhoto(ImageSource source, context) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );

    setState(() {
      _imageFile = pickedFile;
    });
    if (_imageFile == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cal99 =
        Provider.of<downloadFileProvider>(context, listen: false).name;
    imgn = cal99;
    String dir = dirname(_imageFile.path);
    if (cal99 == null) {
      cal99 = "photo";
    }
    String newPath = join(dir, cal99 + '.jpg');
    pathimg = '/' + cal99 + '.jpg';

    if (Provider.of<downloadFileProvider>(context, listen: false).typehome ==
        "search") {
      Directory directory;

      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage )|| await _requestPermission(Permission.manageExternalStorage)) {
          String newPath = "";
          var pathlist = await ExternalPath.getExternalStorageDirectories();
          if (pathlist.length > 1) {
            newPath = pathlist[1];
          } else {
            newPath = pathlist[0];
          }
          print("herehereherehere" + pathlist.toString());
          print('iciiiiiiiiiiiiiiiiiiiiiiiiiii');

          String formattedDate = DateFormat('yyyy-MM-dd–kk-mm').format(now);

          SharedPreferences prefs1 = await SharedPreferences.getInstance();

          String path = prefs1.getString('path');
          print("pathpathpathpathpath : $path");

          newPath = newPath + "/bridge/" + "$formattedDate" + "_TyreInspection";
          await Provider.of<downloadFileProvider>(context, listen: false)
              .setP1(newPath);

          print("directorydirectorydirectory : $directory");

          directory = Directory(newPath);
          print("jnlsjlsssssssssssssssssssssssssssssssssssssssssssss" +
              newPath.toString());
          String po = newPath.toString() + '/' + pathimg;
          await Provider.of<downloadFileProvider>(context, listen: false)
              .setReserved_image(po);

          log( await Provider.of<downloadFileProvider>(context, listen: false).reserved_image.toString());
          print("18888(1702)"+po.toString());
          PhotographsData = {

            "photo": "https://salesbridge.sharepoint.com/:i:/r/teams/BSEMIA-Tyrematch/Shared%20Documents/General/Tyrematch_reports/$po",
          };
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('path', newPath.toString());
        } else {
          //  return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          // return false;
        }
      }

      new Directory(
          Provider.of<downloadFileProvider>(context, listen: false).p1.path)
          .createSync();
      var newPath = await File(_imageFile.path).copy(
          '${Provider.of<downloadFileProvider>(context, listen: false).p1.path}/' +
              cal99 +
              '.jpg');
    } else {
      new Directory(
          Provider.of<downloadFileProvider>(context, listen: false).p1.path)
          .createSync();
      var newPath = await File(_imageFile.path).copy(
          '${Provider.of<downloadFileProvider>(context, listen: false).p1.path}/' +
              cal99 +
              '.jpg');
      var h =
          Provider.of<downloadFileProvider>(context, listen: false).p1.path +
              '/' +
              cal99 +
              '.jpg';
      print("18888(1740)"+h.toString());
      var tt = h.toString().split("/");
      print("18888(1740)"+tt[tt.length-1].toString());

      PhotographsData = {

        "photo": "https://salesbridge.sharepoint.com/:i:/r/teams/BSEMIA-Tyrematch/Shared%20Documents/General/Tyrematch_reports/${tt[tt.length-1].toString()}",
      };
      print("rami158" + h.toString());
    }

    final result = await ImageGallerySaver.saveFile(
      newPath,
    );
    Navigator.pop(context);
  }

}
