// ignore_for_file: unnecessary_statements
import 'dart:developer';

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_app/pages/home.dart';
import 'package:flutter_blue_app/pages/slide_page.dart';
import 'package:flutter_blue_app/provider/download_file_provider.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;
  var color;
  var c2;
  ChatPage({this.server, this.color, this.c2});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;
  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  BluetoothConnection connection;

  List<_Message> messages = [];
  String _messageBuffer = '';
  var op = 0;
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  var dt = DateTime.now();
  int cnt = 0;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  List test = [];
  List<Row> two = [];
  bool rigeda7 = false;
  List error = [];
  List one = [];
  List duplicateList = [];
  List indexList = [];
  List iar = [];

  test1() {
    var errorMsg;
    var testchaine;
    error = [];
    for (var i in test) {
      if (i != null) {
        errorMsg = i;
        testchaine = i.split(RegExp(r"\s+|,\s+"));
        //erreur-comment
        if (testchaine.length < 15) {
          error.add(errorMsg);
        }
      }
    }
  }

  Set testy;
  List az = [];
  int x1 = 0;
  bool isDisconnecting = false;

  calcule(String j) {
    List test;
    var iar;
    var iar1;
    var iar2;
var iar3;
    var name;
    test = j.split(",");
    if (test[0] == "") {
      test.removeAt(0);
    }



    if (test[1].toString().contains("&1")) {
      iar = ((((double.parse(test[4 - 1]) / double.parse(test[6 - 1])) /
                  (double.parse(test[3 - 1]) / double.parse(test[5 - 1]))) -
              1) *
          100);
                    iar =iar.toStringAsFixed(2);

     // iar = (double.parse(test[4 - 1]) / double.parse(test[6 - 1]));
      name = "Lead %:";
    }
    if (test[1].toString().contains("&2")) {
      var da1100 = int.parse(test[7].toString());
      var db1100 = int.parse(test[8].toString());
       var da200 = da1100 / 100;
       var db200 = db1100 / 100;



print("testt787"+test.toString());
      name = "\n Distance A: ${da200} \n Distance B: ${db200} \n Slip % :";
      var f1 = (((double.parse(test[4 - 1]) / 4096) +
              (double.parse(test[6 - 1]) / 4096)) /2);
      print("# 1" + f1.toString());
      var da = ((double.parse(test[9 - 1]) / f1));
      print("# 2" + da.toString());

      var f2 = (((double.parse(test[3 - 1]) / 4096) +
              (double.parse(test[5 - 1]) / 4096)) /
          2);
      print("#" + f2.toString());

      var db = ((double.parse(test[8 - 1]) / f2));
      print("#" + db.toString());

      var iar1 = ((1 - (da / db)) * 100);
      iar = iar1.toStringAsFixed(0);
    }
    if (test[1].toString().contains("&3")) {

        var v1 = ((double.parse(test[3 - 1]) / 4096)).toStringAsFixed(3);
        var v2 = ((double.parse(test[5 - 1]) / 4096)).toStringAsFixed(3);
        var v3 = v1.toString() + " \nRight : " + v2.toString();

      name = "\nLeft : "+v3+
      
      "\nAxle diffrence :";
      iar = ((double.parse(test[3 - 1]) / 4096) -
          (double.parse(test[5 - 1]) / 4096));
          iar =iar.toStringAsFixed(3);
    }

        if (test[1].toString().contains("&4")) {
      iar1 = ((double.parse(test[8 - 1]) * 10) /
          (double.parse(test[3 - 1]) / 4096));
      iar2 = ((double.parse(test[8 - 1]) * 10) /
          (double.parse(test[5 - 1]) / 4096));
 iar3 = ((((double.parse(test[4 - 1]) / double.parse(test[6 - 1])) /
                  (double.parse(test[3 - 1]) / double.parse(test[5 - 1]))) -
              1) *
          100);
      iar = (double.parse(test[4 - 1]) / double.parse(test[6 - 1]));
                iar =iar.toStringAsFixed(4);

      name = "\n RC F : " +
          iar1.toStringAsFixed(0) +
          " \n RC R : " +
          iar2.toStringAsFixed(0) +
          " \n LEAD % : "+
          iar3.toStringAsFixed(2) +
          " \n IAR  : ";
    }
    if (test[1].toString().contains("&5")) {
      iar = (double.parse(test[3 - 1]) / double.parse(test[5 - 1]));
      name = "IAR :";
      iar=iar.toStringAsFixed(4);
    }
    var yy = test[14];
    var tt = yy[1];
    return "M[${test[1].toString().substring(2, 3)}]   $name ${iar}";
  }

  duplicate() async {
    test = messages.map((e) {
   
        if ('#'.allMatches(e.text).length > 1) {
          print('#'.allMatches(e.text).length);
          int a1 = e.text.indexOf("#");

          var g = e.text.substring(0, a1 + 1).trim();
          var g1 = e.text.substring(a1 + 2).trim();

          messages.removeWhere(
              (element) => element.text.toUpperCase().contains("BT SAY"));
          messages.removeWhere(
              (element) => element.text.toUpperCase().contains("BT DONE!"));
          messages.removeWhere((element) => element.text.contains("\n"));
          messages.removeWhere((element) => element == e);
          messages.add(_Message(e.whom, g.toString()));
          messages.add(_Message(e.whom, g1.toString()));
        }
   

      if (!e.text.toString().toUpperCase().contains("BT SAY") &&
          !e.text.toString().toUpperCase().contains("BT DONE!") &&
          e.text.toString().isNotEmpty) {
        return e.text.toString().trim();
      }
      print("score--test"+test.length.toString());
      print("score--messages"+messages.length.toString());
      if (test.length >= 6 ) {
        rigeda7 = true;
        timer?.cancel();

      }
    }).toList();
    
    
    test.remove(null);
    test = test.toSet().toList();

    test.remove(" ");
    if (mounted) {
      setState(() {
        List three = [];

        two = List.generate(test.length, (index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: test[index] == null
                ? []
                : <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                              (text) {
                                three = test[index].split(RegExp(r"\s+|,\s+"));

                                print("jjjjjjjjj" + test[index].toString());

                                return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                              }((1 + index).toString() +
                                  "/6  " +
                                  calcule(test[index]).toString()),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          width: 240.0,
                          decoration: BoxDecoration(
                              color:

                                  //erreur-comment
                                  16 != three.length ? Colors.red : Colors.grey,
                              borderRadius: BorderRadius.circular(7.0)),
                        ),
                        //erreur-comment
                        16 != three.length
                            ? Text(
                                'Wrong message',
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox(
                                width: 1,
                              )
                      ],
                    ),
                    Container(
                      height: 40,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              messages.removeWhere((item) =>
                                  item.text.toString().trim() ==
                                  test[index].toString().trim());

                              test.removeAt(index);
                            });
                           // setState(() {
                              rigeda7 = false;
                              if (test.length<6) {
                                      timer.isActive?null: timer = Timer.periodic(Duration(microseconds: 500),
                                  (_) {
                                duplicate();
                                test1();
                              });
                              }
                       
                           // });

                            print("ùùùùùùùùùùùùùùùùùùùùùùùùù" +
                                test.length.toString());
                          },
                          child: Image.asset("assets/images/delete.png")),
                    ),
                  ],
          );
        });
      });
    }
    test.remove(null);

    print("test: $test 99999");
  }

  var n1;
  Timer timer;
  @override
  void initState() {
    super.initState();
    n1 = Provider.of<downloadFileProvider>(context, listen: false).name;
    rigeda7 = false;
if (test.length<6) {
     timer = Timer.periodic(Duration(microseconds: 500), (_) {
      duplicate();
      test1();
    });
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

    BluetoothConnection.toAddress(widget.server.address)
        .then((_connection) async {
      await _requestPermission(Permission.bluetooth);
      await _requestPermission(Permission.bluetoothAdvertise);
      await _requestPermission(Permission.bluetoothConnect);
      await _requestPermission(Permission.bluetoothScan);
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print("oooooooooooo" + error.toString());
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  Future<bool> exitConfirm() async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                "Do you want to start the calculations?",
                style: TextStyle(fontSize: 18),
              ),
              content: Row(
                children: [
                  SizedBox(
                    width: 35,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          child: Text("Yes",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 28, 59, 100))),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(0, 1, 2, 1),
                            elevation: 0,
                          ),
                          onPressed: () {
                            var n1 = Provider.of<downloadFileProvider>(context,
                                    listen: false)
                                .name;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Slidepage(
                                        title: test,
                                        c1: widget.color,
                                        c2: widget.c2,
                                        n1: n1)));

                                        timer?.cancel();
                          })),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(0, 1, 2, 1),
                            elevation: 0,
                          ),
                          child: Text(
                            "No",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 243, 53, 53)),
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

  Future<void> showAlert(BuildContext context) async {
    timer?.cancel();
    var _isVisible = true;
    if (!test.contains(null)) {
      if (test.length >= 1 && error.isEmpty) {
        _isVisible = true;
      }
    } else {
      if (test.length >= 1 && error.isEmpty) {
        _isVisible = true;
      }
    }
    showDialog <void>(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 150,
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      "End Test !!!",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      "assets/images/check.png",
                      height: 120,
                    )
                  ],
                )),
              ),
              actions: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(0, 1, 2, 1),
                        elevation: 0,
                      ),
                      onPressed: _isVisible ? () => exitConfirm() : null,
                      child: Text('Calculations',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 243, 53, 53))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(0, 1, 2, 1),
                        elevation: 0,
                      ),
                      onPressed: () {
                        setState(() {
                          rigeda7 = false;
                        });
                        for (var i = 0; i < op + 1; i++) {
                          Navigator.of(context).pop();
                          op = op - 1;
                          print("oooopppp" + op.toString());
                        }
                      },
                      child: Text("Back",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    ),
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // if (rigeda7== false && test.length<6) {
      
    // }
    var _isVisible = false;
    if (!test.contains(null)) {
      if (test.length >= 1 && error.isEmpty) {
        _isVisible = true;
      }
    } else {
      if (test.length >= 1 && error.isEmpty) {
        _isVisible = true;
      }
    }
    if (test.indexOf(null) != -1) test.removeAt(test.indexOf(null));
    print("open oooooooooooooooooooooooooooooooooooooooooo||" +
        cnt.toString() +
        "|" +
        rigeda7.toString());
    if (rigeda7 == true && cnt == 0) {
      print("open dialogggggggggggggggggggggg||" + cnt.toString());
      op = op + 1;
      print("1455");
      timer?.cancel();
      Future.delayed(Duration.zero, () => showAlert(context));
      rigeda7 == true;
    }


    test.remove(null);
 

    double h = MediaQuery.of(context).size.height;
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
                    children: <Widget>[
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Home(
                                        color: widget.color,
                                      )));
                            },
                            child: InkWell(
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
                                    : Image.asset("assets/images/advanced.png"),
                              ),
                            ),
                          ),
                          isConnecting == false
                              ? Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.fiber_manual_record,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "Connected",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      color: Color.fromARGB(255, 127, 127, 127),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.fiber_manual_record,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "Disconnected",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      color: Color.fromARGB(255, 127, 127, 127),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed:
                                  _isVisible ? () => exitConfirm() : null,
                              child: Text('Calculations  '),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 9, 83, 9),
                                elevation: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: top / 2,
                      // ),

                      two.isEmpty
                          ? Container()
                          : Flexible(
                              child: ListView(
                                  padding: const EdgeInsets.all(12.0),
                                  controller: listScrollController,
                                  children: two),
                            ),
                      Row(
                        children: [],
                      ),
                      SizedBox(
                        height: 100,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/Bridgestone-Logo.png",
                          width: 200,
                        ),
                      ), // Container(
                      //     width: 150,
                      //     child: Image.asset("assets/images/Bridgestone-Logo.png"))
                    ],
                  ),
                )),
          ),
        ),
      ),
    ));
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }
}
