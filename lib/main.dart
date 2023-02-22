import 'package:flutter/material.dart';

import 'package:flutter_blue_app/pages/login.dart';
import 'package:flutter/services.dart';

import 'package:flutter_blue_app/provider/download_file_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';
import 'dart:async';

import 'MainPage.dart';

bool islogin = false;
const primaryColor = Color.fromARGB(255, 0, 0, 0);
//Wakelock.enable();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => downloadFileProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "splash screen",

          home: FirstActivity(),
          //  home: Test(),

          //    home: InputPhotographs(),
          theme: ThemeData(
            primaryColor: primaryColor,
          ),
          //   home: InputInspection(),
        )),
  );
}

class FirstActivity extends StatefulWidget {
  FirstActivity({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstActivityState();
}

class _FirstActivityState extends State<FirstActivity> {
  bool _visible = false;

  @override
  void initState() {
    clearShare();
    print("Shared clear");
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Timer(Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    });
  }

  clearShare() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,

        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Image.asset("assets/images/anime.png"),
        //  height: 200,
        //  margin: EdgeInsets.only(top: 120),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Login(),
    );
  }
}
