import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/download_file_provider.dart';
import '../input/input_photograph.dart';
import 'container_checkbox.dart';

class TyreInspectionBody extends StatefulWidget {
  var j;
  TyreInspectionBody({Key key, this.j}) : super(key: key);

  @override
  State<TyreInspectionBody> createState() => _TyreInspectionBodyState();
}

class _TyreInspectionBodyState extends State<TyreInspectionBody> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _hourController = TextEditingController();
  TextEditingController _rtdOneController = TextEditingController();
  TextEditingController _rtdTwoController = TextEditingController();
  TextEditingController _rtdTreeController = TextEditingController();
  TextEditingController _rtdFourController = TextEditingController();
  TextEditingController _ipOneController = TextEditingController();
  TextEditingController _ipTwoController = TextEditingController();
  TextEditingController _ipThreeController = TextEditingController();
  TextEditingController _ipFourController = TextEditingController();

  getCurrentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  void initState() {
    _dateController.text = getCurrentDate().toString();

    if (widget.j == true) {
      var data = Provider.of<downloadFileProvider>(context, listen: false)
          .inputTyreInspection;
      print("ali" + data.toString());
    }
    super.initState();
  }

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

  Map tyreInspection = {};

  final TextEditingController _commentsDamage1Controller =
      TextEditingController();
  final TextEditingController _commentsDamage2Controller =
      TextEditingController();
  final TextEditingController _commentsDamage3Controller =
      TextEditingController();
  final TextEditingController _commentsDamage4Controller =
      TextEditingController();
  final TextEditingController _commentsSerial1Controller =
      TextEditingController();
  final TextEditingController _commentsSerial2Controller =
      TextEditingController();
  final TextEditingController _commentsSerial3Controller =
      TextEditingController();
  final TextEditingController _commentsSerial4Controller =
      TextEditingController();

  final TextEditingController _fittingHours1 = TextEditingController();
  final TextEditingController _fittingHours2 = TextEditingController();
  final TextEditingController _fittingHours3 = TextEditingController();
  final TextEditingController _fittingHours4 = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: SizedBox(
                  width: w / 5,
                  child: Text(
                    'Date',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Flexible(
                  child: TextFormField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: SizedBox(
                  width: w / 5,
                  child: Text(
                    'Hours',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Flexible(
                child: TextFormField(
                  validator: (value) => value.isEmpty ? 'Required' : null,
                  keyboardType: TextInputType.number,
                  controller: _hourController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Container(
              height: h / 2.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Sans2.png",
                    ),
                    fit: BoxFit.contain),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerCheckbox(
                            typeDamage: Provider.of<downloadFileProvider>(
                                    context,
                                    listen: false)
                                .typeDamage1,
                            typeDage10: Provider.of<downloadFileProvider>(
                                    context,
                                    listen: false)
                                .typeDamage10,
                            p: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .p10,
                            controllerComments: _commentsDamage1Controller,
                            controllerSerial: _commentsSerial1Controller,
                            fittinghour: _fittingHours1,
                            id: 1,
                            controllerRtd: _rtdOneController,
                            controllerIp: _ipOneController,
                            isChaked: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .ischaked1,
                          ),
                          ContainerCheckbox(
                            typeDamage: Provider.of<downloadFileProvider>(
                                    context,
                                    listen: false)
                                .typeDamage2,
                            typeDage10: Provider.of<downloadFileProvider>(
                                    context,
                                    listen: false)
                                .typeDamage20,
                            p: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .p20,
                            controllerComments: _commentsDamage2Controller,
                            controllerSerial: _commentsSerial2Controller,
                            fittinghour: _fittingHours2,
                            id: 2,
                            card1: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .card2,
                            card2: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .card,
                            card3: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .card3,
                            card4: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .card4,
                            controllerRtd: _rtdTwoController,
                            controllerIp: _ipTwoController,
                            isChaked: Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .ischaked2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContainerCheckbox(
                          typeDamage: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .typeDamage3,
                          typeDage10: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .typeDamage30,
                          p: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .p30,
                          controllerComments: _commentsDamage3Controller,
                          controllerSerial: _commentsSerial3Controller,
                          fittinghour: _fittingHours3,
                          id: 3,
                          controllerRtd: _rtdTreeController,
                          controllerIp: _ipThreeController,
                          isChaked: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .ischaked3,
                        ),
                        ContainerCheckbox(
                          typeDamage: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .typeDamage4,
                          typeDage10: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .typeDamage40,
                          p: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .p40,
                          controllerComments: _commentsDamage4Controller,
                          controllerSerial: _commentsSerial4Controller,
                          fittinghour: _fittingHours4,
                          id: 4,
                          controllerRtd: _rtdFourController,
                          controllerIp: _ipFourController,
                          isChaked: Provider.of<downloadFileProvider>(context,
                                  listen: false)
                              .ischaked4,
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Container(
            width: 100,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF4A8522)),
              ),
              onPressed: () async {
                if (formkey.currentState.validate()) {
                  if (Provider.of<downloadFileProvider>(context, listen: false)
                          .typehome ==
                      "search") {
                    var calculejson = {
                      "Lead": "N/A",
                      "IAR": "N/A",
                      "Front RC": "N/A",
                      "Rear RC": "N/A",
                      "RC Ratio": "N/A",
                      "Slip": "N/A",
                      "Difference": "N/A",
                      "Ratio": "N/A",
                      "Distance A": "N/A",
                      "Distance B": "N/A"
                    };
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

                    var jsonDetails = {
                      "Session_name": formattedDate + "TI",
                      "Location ": "${lat[1].toString()} ${long[1].toString()}",
                      "Date": formattedDate,
                    };

                    Provider.of<downloadFileProvider>(context, listen: false)
                        .setCalculation(calculejson);

                    Provider.of<downloadFileProvider>(context, listen: false)
                        .setDetails(jsonDetails);
                    Provider.of<downloadFileProvider>(context, listen: false)
                        .setTyrematch(tyrematchjson);
                  }
                  setState(() {
                    tyreInspection = {
                      "date_inspection": "${_dateController.text}",
                      "hours": "${_hourController.text}",
                      "RTD-FL": "${_rtdOneController.text}",
                      "RTD-RL": "${_rtdTwoController.text}",
                      "RTD-FR": "${_rtdTreeController.text}",
                      "RTD-RR": "${_rtdFourController.text}",
                      "Ip-FL": "${_ipOneController.text}",
                      "IP-RL": "${_ipTwoController.text}",
                      "IP-FR": "${_ipThreeController.text}",
                      "IP-RR": "${_ipFourController.text}",
                      "Type-Damage-FL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).id_damage1}",
                      "Type-Damage-RL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).id_damage2}",
                      "Type-Damage-FR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).id_damage3}",
                      "Type-Damage-RR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).id_damage4}",
                      "Comments-damage-FL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).commentsDamage1Controller.text}",
                      "Comments-damage-RL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).commentsDamage2Controller.text}",
                      "Comments-damage-FR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).commentsDamage3Controller.text}",
                      "Comments-damage-RR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).commentsDamage4Controller.text}",
                      "Serial-number-FL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).serial1Controller.text}",
                      "Serial-number-RL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).serial2Controller.text}",
                      "Serial-number-FR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).serial3Controller.text}",
                      "Serial-number-RR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).serial4Controller.text}",
                      "Fitting-hours-FL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).fettinghour1Controller.text}",
                      "Fitting-hours-RL":
                          "${Provider.of<downloadFileProvider>(context, listen: false).fettinghour2Controller.text}",
                      "Fitting-hours-FR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).fettinghour3Controller.text}",
                      "Fitting-hours-RR":
                          "${Provider.of<downloadFileProvider>(context, listen: false).fettinghour4Controller.text}",
                    };
                  });
                  Provider.of<downloadFileProvider>(context, listen: false)
                      .setInputTyreInspection(tyreInspection);

                  var st = 1;
                  if (widget.j == true) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => InputPhotographs(
                              st: st,
                            )));
                  }
                }
              },
              child: const Text(
                "Next",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
