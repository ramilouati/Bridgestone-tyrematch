import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_blue_app/pages/search_vehicle.dart';

class Bend extends StatefulWidget {
  var force;
  Bend({Key key, this.force}) : super(key: key);

  @override
  State<Bend> createState() => _BendState();
}

class _BendState extends State<Bend> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => SearchVehicle(
                    force: 1,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CircularProgressIndicator(),
            Text("Processing")
          ],
        ),
      ),
    );
  }
}
