import 'dart:async';

import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:find_jobs/screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/Preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/home': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        // '/second': (context) => SecondScreen(),
      },
      title: 'Việc làm It',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  void chuyen(){  _timer = new Timer(const Duration(milliseconds: 3000), () {
    print(sharedPrefs.check.toString());
      sharedPrefs.check?
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => HomeScreen()))
        :
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => LoginScreen()))
    ;

  });}
@override
  void initState() {
    // TODO: implement initState
chuyen();
print('aaaa2');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sharedPrefs.init();
    return Scaffold(
      body: MultiRepositoryProvider(

        providers: [

        ],
        child: MultiBlocProvider(

          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Image.asset("assets/logo.png")
          ),
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
