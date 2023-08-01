import 'dart:io';
import 'package:flutter_blue_app/main.dart';
import 'package:location/location.dart' as loc;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_app/pages/home.dart';
import 'package:flutter_blue_app/pages/input_user/input_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:external_path/external_path.dart';

import '../provider/download_file_provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  bool status = false;
  bool statusc = false;
  String password = "123456";
  String password1 = "1234567";
  var data;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future login() async {
    try {
      if (password == _passwordController.text) {
        data = "Success";
        Provider.of<downloadFileProvider>(context, listen: false)
            .setStatut("false");
      }
      if (password1 == _passwordController.text) {
        data = "Success";
        Provider.of<downloadFileProvider>(context, listen: false)
            .setStatut("true");
      }

      if (data == 'Success') {
        Fluttertoast.showToast(
            msg: "login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InputUser()));
        final snackBar = SnackBar(
          content: Text(
              " You are connected as a ${Provider.of<downloadFileProvider>(context, listen: false).status == "false" ? 'Standard user' : 'Advanced user'}"),
          backgroundColor:
              Provider.of<downloadFileProvider>(context, listen: false)
                          .status ==
                      "true"
                  ? Color.fromARGB(255, 119, 28, 22)
                  : Color.fromARGB(255, 24, 71, 110),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Fluttertoast.showToast(
            msg: "Password incorrect",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 179, 5, 5),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (error) {}
  }

  loc.Location location =
      loc.Location(); //explicit reference to the Location class
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
    Permission.location.request();
    print("gggps" + location.serviceEnabled().toString());
  }

  @override
  void initState() {
    _checkGps();

    statusc = false;
    status = false;
    crt();
    super.initState();
    getper();
  }

  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        await permission.request();
      }
    }
    return false;
  }

  crt() async {
    Directory directory;
    String newPath = "";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on1 ${androidInfo.manufacturer}');
      if (androidInfo.manufacturer.toString() == "HUAWEI") {
        if (await _requestPermission(Permission.storage)) {
          var pathlist = await ExternalPath.getExternalStorageDirectories();
          if (pathlist.length > 1) {
            newPath = pathlist[1];
          } else {
            newPath = pathlist[0];
          }
          print("herehereherehere" + pathlist.toString());

          String np2 = newPath + "/bridge/vehicle";
          newPath = newPath + "/bridge/user";

          print("eeeeeeeeeeeeeeeeee" + newPath);
          directory = Directory(newPath);
          await directory.create(recursive: true);
          directory = Directory(np2);
          await directory.create(recursive: false);
        }
      }

      if (!androidInfo.manufacturer.toString().contains("HUAWEI")) {
        var path = await ExternalPath.getExternalStorageDirectories();
        if (path.length > 1) {
          newPath = path[1];
        } else {
          newPath = path[0];
        }
        print("herehereherehere" + path.toString());
        String np2 = newPath + "/bridge/vehicle";
        newPath = newPath + "/bridge/user";

        print("eeeeeeeeeeeeeeeeee" + newPath);
        directory = Directory(newPath);
        await directory.create(recursive: true);
        directory = Directory(np2);
        await directory.create(recursive: false);
        File(newPath.toString() + "/hh.txt");
      }

      // newPath = newPath + "/bridge/user";
      //    print("directodirectodirecto" + newPath.toString());

      //  directory = Directory(newPath);
      directory.create(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login1.jpg"),
                        fit: BoxFit.cover)),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  //    appBar: AppBar(),
                  body: Form(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 50,
                                shadowColor: Colors.black,
                                color: Colors.white,
                                child: SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Image.asset(
                                                  "assets/images/BS.jpg")),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(24.0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 2.0,
                                                blurRadius: 4.0,
                                                color: Color(0xfFD0CECE),
                                              ),
                                            ],
                                          ),
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 20),
                                            autocorrect: false,
                                            obscureText: _obscureText,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              suffixIcon: new GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _obscureText =
                                                        !_obscureText;
                                                  });
                                                },
                                                child: new Icon(
                                                  _obscureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  size: 15,
                                                ),
                                              ),
                                              hintStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                              hintText: 'Enter password',
                                              fillColor:
                                                  const Color(0xfFD0CECE),
                                              filled: true,
                                              isDense: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            controller: _passwordController,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xFF4A8522)),
                                          ),
                                          onPressed: () async {
                                            if (status == false) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool('color', status);

                                              login();
                                            } else {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setString(
                                                  'color', status.toString());
                                              login();
                                            }
                                          },
                                          child: const Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 80,
                                        child: Image.asset(
                                            "assets/images/logo2.png")),
                                    Text(
                                      "Better farming with Bridgestone",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
