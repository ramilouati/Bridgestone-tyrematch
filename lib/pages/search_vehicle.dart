import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_app/pages/Item.dart';
import 'package:flutter_blue_app/pages/pervehicle.dart';
import 'package:flutter_blue_app/pages/tyre%20inspection/tyre_inspection.dart';
import 'package:provider/provider.dart';
import '../provider/download_file_provider.dart';
import 'MyCostumForm.dart';
import 'home.dart';
import 'input/input_vehicle.dart';

class SearchVehicle extends StatefulWidget {
  SearchVehicle({Key key, this.color, this.force}) : super(key: key);
  var color;
  var force;

  @override
  State<SearchVehicle> createState() => _SearchVehicleState();
}

class _SearchVehicleState extends State<SearchVehicle> {
  final TextEditingController _lnameController = TextEditingController();

  List _vehicles = [];
  List _foundUsers = [];
  var p100;

  @override
  void initState() {
    getdata();

    super.initState();
  }

  void getdata() async {
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa7");
    await Provider.of<downloadFileProvider>(context, listen: false)
        .fctListVehicles();

    _vehicles = await Provider.of<downloadFileProvider>(context, listen: false)
        .listVehicles;

    p100 = await Provider.of<downloadFileProvider>(context, listen: false)
        .vehicleimagepath;
    print("oooooooooooo" + _vehicles.toString());

    setState(() {
      _foundUsers = _vehicles;
    });
  }

  List results = [];

  void _runFilter(String _lnameController3) {
    print(_lnameController3.toString());

    if (_lnameController3.toString().isEmpty) {
      results = _vehicles;
    } else {
      results = _vehicles
          .where((user) => user
              .toString()
              .toLowerCase()
              .contains(_lnameController3.toString().toLowerCase()))
          .toList();

      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" +
          results.toString());
    }
    setState(() {
      _foundUsers = results;
      print("objectobjectobjectobjectobjectobjectobjectobjectobjectobject" +
          _foundUsers.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 15),
                  child:
                      Provider.of<downloadFileProvider>(context, listen: false)
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
                    "My vehicles",
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.67,
                child: TextFormField(
                  controller: _lnameController,
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black38,
                          width: 10,
                        )),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 85,
                height: 55,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF4A8522)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => InputVehicle()));
                    },
                    child: Text(
                      "New vehicle",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _foundUsers.isEmpty
                      ? Center(
                          child: Text(
                          "Empty",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ))
                      : SingleChildScrollView(
                          child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print("rami+${_foundUsers[index]}");
                                  Provider.of<downloadFileProvider>(context,
                                          listen: false)
                                      .setInputVehicule(_foundUsers[index]);

                                  var etat = Provider.of<downloadFileProvider>(
                                          context,
                                          listen: false)
                                      .typehome;
                                  print("7777777777" + etat.toString());

                                  if (etat == "wifi") {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => MyWidget(
                                                // BL: "yes",
                                                // vehicle: _foundUsers[index],
                                                )));
                                  }
                                  if (etat == "tractor") {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => TyreInspection(
                                                details: _foundUsers[index]
                                                    ['Registration_plate'],
                                                date: _foundUsers[index]
                                                    ['date_creation'],
                                                fsize: _foundUsers[index]
                                                    ['TyreProduct_F'],
                                                rsize: _foundUsers[index]
                                                    ['TyreProduct_R'],
                                                data: _foundUsers[index])));
                                  }
                                  if (etat == "search") {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => TyreInspection1(
                                                // BL: "yes",
                                                // vehicle: _foundUsers[index],
                                                )));
                                  }
                                },
                                child: Card(
                                  color: Color.fromARGB(226, 255, 255, 255),
                                  child: // list tile here ....SearchVehicle
                                      CustomListItemTwo(
                                    thumbnail:
                                        File(Provider.of<downloadFileProvider>(
                                                                context,
                                                                listen: false)
                                                            .vehicleimagepath
                                                            .toString() +
                                                        "/vehicle_${_foundUsers[index]['Registration_plate']}.jpg")
                                                    .existsSync() ==
                                                true
                                            ? Image.file(
                                                File(Provider.of<
                                                                downloadFileProvider>(
                                                            context,
                                                            listen: false)
                                                        .vehicleimagepath
                                                        .toString() +
                                                    "/vehicle_${_foundUsers[index]['Registration_plate']}.jpg"),
                                                width: 150,
                                                fit: BoxFit.fill,
                                                height: 200,
                                              )
                                            : Image.asset(
                                                "assets/images/tractor.png",
                                                width: 150,
                                                fit: BoxFit.fill,
                                                height: 200,
                                              ),
                                    title:
                                        '${_foundUsers[index]['Registration_plate'].toString()}\n',
                                    subtitle:
                                        '${_foundUsers[index]['TyreProduct_F'].toString()}\n \n${_foundUsers[index]['TyreProduct_R'].toString()}',
                                    // author: 'Flutter',
                                    publishDate:
                                        '${_foundUsers[index]['date_creation'].toString()}',
                                    // readDuration: '12 mins',
                                  ),
                                ),
                              );
                            },
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
      ]),
    ));
  }
}
