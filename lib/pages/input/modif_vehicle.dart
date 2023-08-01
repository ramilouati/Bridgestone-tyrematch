// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_app/pages/search_vehicle.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../provider/download_file_provider.dart';
import '../read/bend.dart';

class ModifVehicle extends StatefulWidget {
  var BL;
  var vehicle;
  var data;
  var Details;
    var Image;

  ModifVehicle({Key key, this.BL, this.vehicle, this.data, this.Details,this.Image})
      : super(key: key);

  @override
  State<ModifVehicle> createState() => _ModifVehicleState();
}

class _ModifVehicleState extends State<ModifVehicle> {
  var _inputVehicle = {};
var selectionbrand=false;
var selectionmodel=false;
  var selectBrand;
  var selectModel;
  var Comment;
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;
  //String formattedDate = DateFormat('dd-MM-yyyy–kk-mm').format(know);
  List l = [];
  String value0;
  String dropdownValue1;
  String dropdownValue2;
  String dropdownValue3;
  String dropdownValue4;
  String dropdownValue5;
  String dropdownValue6;
  bool dual1;
    File image;

  bool dual2;
  List catalogdata;
  List catalogdata2;
  List catalogdata0;
  List catalogdata10;
  List<String> p1 = <String>['---'];
  List<String> prod1 = <String>['---'];
  List<String> p10 = <String>['---'];
  List<String> prod10 = <String>['---'];
  List<String> v = <String>['---'];
  List<String> v1 = <String>['---'];
  @override
  void initState() {
    widget.data.forEach((k, v) => l.add(Veh(k, v)));
    log("8888" + widget.data.toString());
    super.initState();
    selectBrand = l[0].value.toString();
    selectModel = l[1].value.toString();
        newbrand.text = l[2].value.toString();
        newmodel.text = l[3].value.toString();

    rpController.text = l[4].value.toString();
    nbrAxiesController.text = l[5].value.toString();
    _Axies1Controller.text = l[6].value.toString();
    _Axies2Controller.text = l[7].value.toString();
    dropdownValue1 = l[8].value.toString();
    dropdownValue3 = l[9].value.toString();
    dropdownValue5 = l[10].value.toString();

    dropdownValue2 = l[11].value.toString();
    dropdownValue4 = l[12].value.toString();
    dropdownValue6 = l[13].value.toString();
    Comments.text = l[16].value.toString();
    print(",,,," + l.toString());
    print("dropdownValue1" + dropdownValue1.toString());
    print("dropdownValue1" + dropdownValue2.toString());

    print("dropdownValue1" + dropdownValue3.toString());

    print("dropdownValue1" + dropdownValue4.toString());

    print("dropdownValue1" + dropdownValue5.toString());

    print("dropdownValue1" + dropdownValue6.toString());
    image=File(widget.Image.toString());
        image=File(widget.Image.toString());

  }

  modif() {}
  getCurrentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  String selectedApplication;

  var top = Get.statusBarHeight;
  bool active = false;
  final formKey = GlobalKey<FormState>();

  final imagepicker = ImagePicker();
  PickedFile _imageFile;
  uploadImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);

      setState(() {
        _imageFile = pickedImage;
        print(image.path.toString());
      });
    } else {}
  }

  Future<String> loadData2(List p) async {
    var data = await rootBundle.loadString("assets/data/Vehicle.json");
    setState(() {
      catalogdata2 = json.decode(data);
    });
    print("cat" + catalogdata2.length.toString());
    print(catalogdata2[0]["Brand"].toString());
    for (var i = 0; i < catalogdata2.length; i++) {
      print("ggggggggg" + catalogdata2[i]["Brand"].toString());
      p.add(catalogdata2[i]["Brand"].toString());
    }
    var seen = Set<String>();
    List<String> uniquelist = p.where((element) => seen.add(element)).toList();
    print("ffff" + uniquelist.toString());
    setState(() {
      v = uniquelist;
    });
    print("ffff1" + p.toString());

    return "success";
  }

  Future<String> loadData20(String val, List p) async {
    for (var i = 0; i < catalogdata2.length; i++) {
      if (catalogdata2[i].toString().contains(val)) {
        p.add(catalogdata2[i]["Model"].toString());
      }
    }
    var seen = Set<String>();
    List<String> uniquelist = p.where((element) => seen.add(element)).toList();
    print("ffff" + uniquelist.toString());
    setState(() {
      v1 = uniquelist;
    });
    print("ffff1" + p.toString());

    return "success";
  }

  Future<String> loadData(String val, List p) async {
    var data = await rootBundle.loadString("assets/data/$val.json");
    setState(() {
      catalogdata = json.decode(data);
    });
    print("cat" + catalogdata.length.toString());
    print(catalogdata[0]["Pattern"].toString());
    for (var i = 0; i < catalogdata.length; i++) {
      print("ggggggggg" + catalogdata[i]["Pattern"].toString());
      p.add(catalogdata[i]["Pattern"].toString());
    }
    var seen = Set<String>();
    List<String> uniquelist = p.where((element) => seen.add(element)).toList();
    print("ffff" + uniquelist.toString());
    setState(() {
      p1 = uniquelist;
    });
    print("ffff1" + p.toString());

    return "success";
  }

  Future<String> loadData0(String val, List p) async {
    var data = await rootBundle.loadString("assets/data/$val.json");
    setState(() {
      catalogdata0 = json.decode(data);
    });
    print("cat" + catalogdata0.length.toString());
    print(catalogdata0[0]["Pattern"].toString());
    for (var i = 0; i < catalogdata0.length; i++) {
      print("ggggggggg" + catalogdata0[i]["Pattern"].toString());
      p.add(catalogdata0[i]["Pattern"].toString());
    }
    var seen = Set<String>();
    List<String> uniquelist = p.where((element) => seen.add(element)).toList();
    print("ffff" + uniquelist.toString());
    setState(() {
      p10 = uniquelist;
    });
    print("ffff1" + p.toString());

    return "success";
  }

  Future<String> loadDataprod(String val, List p) async {
    for (var i = 0; i < catalogdata.length; i++) {
      if (catalogdata[i].toString().contains(val)) {
        p.add(catalogdata[i]["Product"].toString());
      }
    }
    var seen = Set<String>();
    List<String> uniquelist = p.where((element) => seen.add(element)).toList();
    print("ffff" + uniquelist.toString());
    setState(() {
      prod1 = uniquelist;
    });
    print("ffff1" + p.toString());

    return "success";
  }

  Future<String> loadDataprod0(String val, List p) async {
    for (var i = 0; i < catalogdata0.length; i++) {
      if (catalogdata0[i].toString().contains(val)) {
        p.add(catalogdata0[i]["Product"].toString());
      }
    }
    var seen = Set<String>();
    List<String> uniquelist = p.where((element) => seen.add(element)).toList();
    print("ffff" + uniquelist.toString());
    setState(() {
      prod10 = uniquelist;
    });
    print("ffff1" + p.toString());

    return "success";
  }

  TextEditingController rpController = TextEditingController();
  TextEditingController nbrAxiesController = TextEditingController();
  final TextEditingController _Axies1Controller = TextEditingController();
  final TextEditingController _Axies2Controller = TextEditingController();
   TextEditingController newbrand= TextEditingController();
   TextEditingController newmodel= TextEditingController();
   TextEditingController Comments= TextEditingController();
  List axies = [];
  Future<void> _showMyDialog(int i) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Axles weights '),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: 100,
                        child: Row(
                          children: [
                            Text('Axies 1 = '),
                            Expanded(
                                child: TextFormField(
                              controller: _Axies1Controller,
                              decoration: InputDecoration(
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
                            )),
                            Text(' Kg'),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Row(
                          children: [
                            Text('Axies 2 = '),
                            Expanded(
                                child: TextFormField(
                              controller: _Axies2Controller,
                              decoration: InputDecoration(
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
                            )),
                            Text(' Kg'),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF4A8522)),
                ),
                onPressed: () {
                  setState(() {
                    axies.addAll(
                        [_Axies1Controller.text, _Axies2Controller.text]);
                  });

                  Navigator.of(context).pop();
                },
                child: Text(
                  "Next",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var top = Get.statusBarHeight;
    double h6 = MediaQuery.of(context).size.height * 0.06;

print("dddd1998+1994"+selectBrand.toString()+"//"+selectModel.toString());


if (selectBrand.toString()=="OTHER" && selectModel.toString()=="OTHER") {
  selectionbrand=true;
  selectionmodel=true;
print("ramippppppp");
}else{
  selectionbrand=false;
    selectionmodel=false;
  //newbrand.clear();
   


}
// if (selectBrand.toString()!="OTHER") {
//   selectionbrand=false;
//     selectionmodel=true;

// }
if (selectBrand.toString()!="OTHER"&& selectModel.toString()=="OTHER" ) {
  selectionbrand=false;
    selectionmodel=true;

}


    if (v.length < 2) {
      loadData2(v);
    }

    double h = MediaQuery.of(context).size.height;
    return Center(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
              body: PageView(
                  controller: page,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: [
                Container(
                  child: Container(
                    child: Form(
                      key: formKey,
                      child: Center(
                        child: AnnotatedRegion<SystemUiOverlayStyle>(
                          value: SystemUiOverlayStyle.dark,
                          child: Scaffold(
                            body: SafeArea(
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  child: Container(
                                    height: h * 0.96,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 40.0,
                                                      vertical: 15),
                                                  child: Provider.of<downloadFileProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .status ==
                                                          "false"
                                                      ? Image.asset(
                                                          "assets/images/basic.png")
                                                      : Image.asset(
                                                          "assets/images/advanced.png"),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06,
                                                  color: const Color.fromARGB(
                                                      255, 127, 127, 127),
                                                  child: Center(
                                                    child: Text(
                                                      " Modify vehicle data",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              255, 255, 255)),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 22,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Brand',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child:
                                                        DropdownSearch<String>(
                                                      selectedItem: selectBrand,
                                                      popupProps:
                                                          PopupProps.menu(
                                                        showSearchBox: true,
                                                      ),
                                                      items: v,
                                                      onChanged:
                                                          (String newValue1) {
                                                        setState(() {
                                                          selectBrand =
                                                              newValue1;
                                                          v1 = ['---'];
                                                          selectModel = '---';
                                                                                                     if (selectBrand.toString()=="OTHER") {
  selectModel="OTHER";
    

}
                                                        });

                                                        loadData20(
                                                            selectBrand, v1);
                                                      },
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 5,
                                                                  vertical:
                                                                      10.0),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                        ),

                                                        // value: selectBrand,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Model',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child:
                                                        DropdownSearch<String>(
                                                      selectedItem: selectModel,
                                                      items: v1,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectModel = val;
                                                        });
                                                      },
                                                      popupProps:
                                                          PopupProps.menu(
                                                        showSearchBox: true,
                                                      ),
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 5,
                                                                  vertical:
                                                                      10.0),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                                                              SizedBox(height: 5,),

                                        selectionbrand==true ?  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'New Brand',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                enabled: selectionbrand,
                                         
                                                validator: (value) =>
                                                    value == null ||
                                                            value.isEmpty
                                                        ? 'Required'
                                                        : null,
                                                controller: newbrand,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Please specify the new Brand ",
                                                  hintStyle: TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 10.0),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ):Container(),
                                    SizedBox(height: 5,),
                                       selectionmodel==true ?  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'New Model',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                enabled: selectionmodel,
                                         
                                                validator: (value) =>
                                                    value == null ||
                                                            value.isEmpty
                                                        ? 'Required'
                                                        : null,
                                                controller: newmodel,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Please specify the new model",
                                                  hintStyle: TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 10.0),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ):Container(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Registration plate',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Form(
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      controller: rpController,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10.0),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Number of Axles',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      validator: (value) =>
                                                          value == null ||
                                                                  value.isEmpty
                                                              ? 'Required'
                                                              : null,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          nbrAxiesController,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10.0),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                            Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Comments',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: TextFormField(
                                          maxLines: 4,

                                                      validator: (value) =>
                                                          value == null ||
                                                                  value.isEmpty
                                                              ? 'Required'
                                                              : null,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          Comments,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10.0),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 42, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (formKey.currentState
                                                        .validate()) {
                                                      _showMyDialog(int.parse(
                                                          nbrAxiesController
                                                              .text));
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Add weight per axle',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF2E7402),
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 42, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Add vehicle photo',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: uploadImage,
                                                  child: CircleAvatar(
                                                    radius: 42,
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: CircleAvatar(
                                                        radius: 40,
                                                        backgroundImage: widget.Image ==
                                                                null
                                                            ? AssetImage(
                                                                "assets/images/camera.png")
                                                            : FileImage(File(
                                                                image.path)),
                                                        backgroundColor:
                                                            Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xFF4A8522)),
                                                ),
                                                onPressed: () {
                                                  page.animateToPage(
                                                      ++pageIndex,
                                                      duration: Duration(
                                                          milliseconds: 400),
                                                      curve: Curves
                                                          .linearToEaseOut);
                                                },
                                                child: Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                            //    image != null ? Image.file(image) : Text("no chosen image"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/images/Bridgestone-Logo.png",
                                                width: 200,
                                              ),
                                            )
                                          ]),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40.0, vertical: 15),
                                            child: Provider.of<downloadFileProvider>(
                                                            context,
                                                            listen: false)
                                                        .status ==
                                                    "false"
                                                ? Image.asset(
                                                    "assets/images/basic.png")
                                                : Image.asset(
                                                    "assets/images/advanced.png"),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            color: const Color.fromARGB(
                                                255, 127, 127, 127),
                                            child: Center(
                                              child: Text(
                                                "Modify Vehicle tyres",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255)),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          child: Image.asset(
                                              "assets/images/Sans.png"),
                                        ),
                                        Container(
                                          height: 300,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2) *
                                                      0.9,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Tyre Brand",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Theme(
                                                                data: ThemeData(
                                                                  textTheme: TextTheme(
                                                                      subtitle1:
                                                                          TextStyle(
                                                                              fontSize: 12)),
                                                                ),
                                                                child: DropdownSearch<
                                                                        String>(
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      showSearchBox:
                                                                          true,
                                                                    ),
                                                                    onChanged:
                                                                        (String
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownValue1 =
                                                                            newValue;
                                                                        p1 = [
                                                                          '---'
                                                                        ];
                                                                        dropdownValue3 =
                                                                            '---';
                                                                      });

                                                                      loadData(
                                                                          newValue,
                                                                          p1);
                                                                    },
                                                                    items: <
                                                                        String>[
                                                                      '---',
                                                                      'ALLIANCE',
                                                                      'BKT',
                                                                      'BRIDGESTONE',
                                                                      'CONTINENTAL',
                                                                      'FIRESTONE',
                                                                      'GOODYEAR',
                                                                      'KLEBER',
                                                                      'MICHELIN',
                                                                      'MITAS',
                                                                      'TITAN',
                                                                      'TRELLEBORG',
                                                                      'VREDESTEIN'
                                                                    ],
                                                                    selectedItem:
                                                                        dropdownValue1,
                                                                    dropdownDecoratorProps:
                                                                        DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                10.0),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                      ),
                                                                    )))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        //   width: MediaQuery.of(context).size.width / 2.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Tyre pattern",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Theme(
                                                                data: ThemeData(
                                                                  textTheme: TextTheme(
                                                                      subtitle1:
                                                                          TextStyle(
                                                                              fontSize: 13)),
                                                                ),
                                                                child: DropdownSearch<
                                                                        String>(
                                                                    selectedItem:
                                                                        dropdownValue3,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      showSearchBox:
                                                                          true,
                                                                    ),
                                                                    items: p1,
                                                                    onChanged:
                                                                        (String
                                                                            newValue1) {
                                                                      setState(
                                                                          () {
                                                                        dropdownValue3 =
                                                                            newValue1;
                                                                        prod1 =
                                                                            [
                                                                          '---'
                                                                        ];
                                                                        dropdownValue5 =
                                                                            '---';
                                                                      });

                                                                      loadDataprod(
                                                                          newValue1,
                                                                          prod1);
                                                                    },
                                                                    dropdownDecoratorProps:
                                                                        DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                10.0),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                      ),
                                                                    )))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        //   width: MediaQuery.of(context).size.width / 2.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Product",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Theme(
                                                                data: ThemeData(
                                                                  textTheme: TextTheme(
                                                                      subtitle1:
                                                                          TextStyle(
                                                                              fontSize: 13)),
                                                                ),
                                                                child: DropdownSearch<
                                                                        String>(
                                                                    items:
                                                                        prod1,
                                                                    selectedItem:
                                                                        dropdownValue5,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      showSearchBox:
                                                                          true,
                                                                    ),
                                                                    onChanged:
                                                                        (String
                                                                            newValue5) {
                                                                      setState(
                                                                          () {
                                                                        dropdownValue5 =
                                                                            newValue5;
                                                                      });
                                                                    },
                                                                    dropdownDecoratorProps:
                                                                        DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                10.0),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                      ),
                                                                    )))
                                                          ],
                                                        ),
                                                      ),

                                                      // Expanded(
                                                      //   //   width: MediaQuery.of(context).size.width / 2.4,
                                                      //   child: Row(
                                                      //     children: [
                                                      //       Text("Dual"),
                                                      //       Checkbox(
                                                      //         value: this.dual2,
                                                      //         onChanged: (bool value) {
                                                      //           setState(() {
                                                      //             this.dual2 = value;
                                                      //           });
                                                      //         },
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                VerticalDivider(
                                                  width: 10,
                                                  thickness: 1,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                Container(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2) *
                                                      0.9,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Tyre Brand",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Theme(
                                                                data: ThemeData(
                                                                  textTheme: TextTheme(
                                                                      subtitle1:
                                                                          TextStyle(
                                                                              fontSize: 13)),
                                                                ),
                                                                child: DropdownSearch<
                                                                        String>(
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      showSearchBox:
                                                                          true,
                                                                    ),
                                                                    onChanged:
                                                                        (String
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownValue2 =
                                                                            newValue;
                                                                        p10 = [
                                                                          '---'
                                                                        ];
                                                                        dropdownValue4 =
                                                                            '---';
                                                                      });

                                                                      loadData0(
                                                                          newValue,
                                                                          p10);
                                                                    },
                                                                    selectedItem:
                                                                        dropdownValue2,
                                                                    items: <
                                                                        String>[
                                                                      '---',
                                                                      'ALLIANCE',
                                                                      'BKT',
                                                                      'BRIDGESTONE',
                                                                      'CONTINENTAL',
                                                                      'FIRESTONE',
                                                                      'GOODYEAR',
                                                                      'KLEBER',
                                                                      'MICHELIN',
                                                                      'MITAS',
                                                                      'TITAN',
                                                                      'TRELLEBORG',
                                                                      'VREDESTEIN'
                                                                    ],
                                                                    dropdownDecoratorProps:
                                                                        DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                10.0),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                      ),
                                                                    )))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // width: MediaQuery.of(context).size.width / 2.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Tyre pattern",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Theme(
                                                                data: ThemeData(
                                                                  textTheme: TextTheme(
                                                                      subtitle1:
                                                                          TextStyle(
                                                                              fontSize: 13)),
                                                                ),
                                                                child: DropdownSearch<
                                                                        String>(
                                                                    onChanged:
                                                                        (String
                                                                            newValue1) {
                                                                      setState(
                                                                          () {
                                                                        dropdownValue4 =
                                                                            newValue1;
                                                                        prod10 =
                                                                            [
                                                                          '---'
                                                                        ];
                                                                        dropdownValue6 =
                                                                            '---';
                                                                      });

                                                                      loadDataprod0(
                                                                          newValue1,
                                                                          prod10);
                                                                    },
                                                                    items: p10,
                                                                    selectedItem:
                                                                        dropdownValue4,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      showSearchBox:
                                                                          true,
                                                                    ),
                                                                    dropdownDecoratorProps:
                                                                        DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                10.0),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                      ),
                                                                    )))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // width: MediaQuery.of(context).size.width / 2.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Product",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Theme(
                                                                data: ThemeData(
                                                                  textTheme: TextTheme(
                                                                      subtitle1:
                                                                          TextStyle(
                                                                              fontSize: 12)),
                                                                ),
                                                                child: DropdownSearch<
                                                                        String>(
                                                                    onChanged:
                                                                        (String
                                                                            newValue5) {
                                                                      setState(
                                                                          () {
                                                                        dropdownValue6 =
                                                                            newValue5;
                                                                      });
                                                                    },
                                                                    selectedItem:
                                                                        dropdownValue6,
                                                                    popupProps:
                                                                        PopupProps
                                                                            .menu(
                                                                      showSearchBox:
                                                                          true,
                                                                    ),
                                                                    items:
                                                                        prod10,
                                                                    dropdownDecoratorProps:
                                                                        DropDownDecoratorProps(
                                                                      dropdownSearchDecoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                10.0),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white,
                                                                      ),
                                                                    )))
                                                          ],
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   child: Row(
                                                      //     children: [
                                                      //       Text("Dual"),
                                                      //       Checkbox(
                                                      //         value: this.dual1,
                                                      //         onChanged: (bool value) {
                                                      //           setState(() {
                                                      //             this.dual1 = value;
                                                      //           });
                                                      //         },
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ],
                                    )),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFF4A8522)),
                                              ),
                                              onPressed: () async {
                                                         if (_Axies1Controller.text == "") {
                  _Axies1Controller.text = "_";
                }
                if (_Axies2Controller.text == "") {
                  _Axies2Controller.text = "_";
                }
                   if (newbrand.text == "") {
                  newbrand.text = "_";
                }
                    if (newmodel.text == "") {
                  newmodel.text = "_";
                }     if (Comments.text == "") {
                  Comments.text = "_";
                }

 
                                                _inputVehicle = {
                                                  "Brand":
                                                      selectBrand.toString(),
                                                  "Model":
                                                      selectModel.toString(),
                                                       "New brand" : newbrand.text.toString(),
                                                      "New model" : newmodel.text.toString(),

                                                  "Registration_plate":
                                                      rpController.text,
                                                  "Number_axles":
                                                      nbrAxiesController.text,
                                                  "w_axle1":
                                                      _Axies1Controller.text,
                                                  "w_axle2":
                                                      _Axies2Controller.text,
                                                  "TyreBrand_F":
                                                      dropdownValue1.toString(),
                                                  "TyrePattern_F":
                                                      dropdownValue3.toString(),
                                                  "TyreProduct_F":
                                                      dropdownValue5.toString(),
                                                  "TyreBrand_R":
                                                      dropdownValue2.toString(),

                                                  "TyrePattern_R":
                                                      dropdownValue4.toString(),
                                                  "TyreProduct_R":
                                                      dropdownValue6.toString(),

                                                  "date_creation":
                                                      getCurrentDate()
                                                          .toString(),
                                            "image_vehicle": "https://salesbridge.sharepoint.com/:i:/r/teams/BSEMIA-Tyrematch/Shared%20Documents/General/Tyrematch_reports/vehicle_"+rpController.text.toString()+".jpg",
                                  "Comments": Comments.text.toString(),

                                                };

                                                Provider.of<downloadFileProvider>(
                                                        context,
                                                        listen: false)
                                                    .saveFileV(
                                                        _inputVehicle,
                                                        "vehicle_${rpController.text}",
                                                        image);
                                                print("eeeee" +
                                                    _inputVehicle.toString());
                                                Provider.of<downloadFileProvider>(context, listen: false)
                                                    .settypehome("tractor");
                                                          print("fffffffffffff"+image.path.toString());
                             Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Bend(force: 1)));
                                                // exitConfirm3();
                                              },
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/Bridgestone-Logo.png",
                                              width: 200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]))),
    );
  }
}

class Veh {
  String Key;
  String value;

  Veh(this.Key, this.value);

  @override
  String toString() {
    return '{ ${this.Key}, ${this.value} }';
  }
}
