import 'dart:io';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/item_app/BottomNavigation.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_home/Header_home.dart';
import 'package:find_jobs/layout_home/Newest_candicate.dart';
import 'package:find_jobs/layout_home/Newest_jobs.dart';
import 'package:find_jobs/layout_home/Slider.dart';
import 'package:find_jobs/main.dart';
import 'package:find_jobs/screen/LoginScreen.dart';
import 'package:find_jobs/screen/Search_keywword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'Detail_user.dart';
import 'SignUp.dart';

// ignore: camel_case_types
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Việc làm IT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key}) : super(key: key);

  @override
  _MyHomeScreen createState() => _MyHomeScreen();
}

class _MyHomeScreen extends State<MyHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isVisible = true;
  ScrollController scrollControllers = new ScrollController();
  bool rd = true;
  bool _obscuretext = true;
  bool check = false;
  int gr = 1;
  TextEditingController mail = new TextEditingController();
  TextEditingController pw = new TextEditingController();

  void _toggle() {
    setState(() {
      _obscuretext = !_obscuretext;
      print(_obscuretext);
    });
  }

  //----thoat
  show_dialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Thoát ứng dụng ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            exit(0);
                          },
                          child: Text(
                            "Đồng ý",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.green,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Hủy",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  //----------bottom
  ontapbottom(int index) {
    setState(() {
      if (index == 0) {}
      if (index == 2) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => profile(
                      my_acc: true,
                    )));
      }
      if (index == 1) {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Search_keywword()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    scrollControllers.addListener(() {
      if (scrollControllers.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible)
          setState(() {
            _isVisible = false;
            print("**** $_isVisible up");
          });
      }
      if (scrollControllers.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible)
          setState(() {
            _isVisible = true;
            print("**** $_isVisible down");
          });
      }
    });
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar:  Visibility(
          visible: _isVisible,
          child: BottomNavigationcustom(selectedIndex:0,tap: ontapbottom,)
      ),
      key: _scaffoldKey,
      drawer: Drawer_findjobs(),
      body:WillPopScope(
        onWillPop: (){show_dialog();},
        child: SingleChildScrollView(
          controller: scrollControllers,
          child: Column(
            children: [
              header(),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     child: Column(
                       children: [
                         Slide(),
                         Container(
                           height: MediaQuery.of(context).size.height-100,
                           child: DefaultTabController(
                             length: 2,
                             child: Scaffold(
                               appBar: PreferredSize(
                                 preferredSize: Size(double.infinity,35),
                                 child: Padding(
                                   padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                   child: Container(
                                     color: Colors.grey.withOpacity(0.1),
                                     child: TabBar(
                                       indicatorColor: Colors.green,
                                       labelColor: Colors.green,
                                       isScrollable: true,
                                       unselectedLabelColor: Colors.grey,
                                       tabs: [
                                         Tab(child: Text("Việc làm IT mới nhất"),),
                                         Tab(child: Text("Ứng viên mới nhất"),),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),

                               body: TabBarView(
                                 children: [
                                   //VIEC LAM TRONG NUOC
                                   SingleChildScrollView(
                                     physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                     child: Column(
                                       children: [
                                        Newest_jobs(),
                                       ],
                                     ),
                                   ),
                                   SingleChildScrollView(
                                     physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                     child: Column(
                                       children: [
                                         Newest_Candicate(),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
