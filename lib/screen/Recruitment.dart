import 'dart:io';
import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/main.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:find_jobs/tab_in_approve/Approved.dart';
import 'package:find_jobs/tab_in_approve/Candicate_tab.dart';
import 'package:find_jobs/tab_in_approve/Not_approved.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'SignUp.dart';



// ignore: camel_case_types

class Recruitment extends StatefulWidget {
  Recruitment({Key key}) : super(key: key);
  @override
  _Recruitment createState() => _Recruitment();
}

class _Recruitment extends State<Recruitment> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double mda = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Tuyển dụng"),
          bottom:  TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            controller: _tabController,
            isScrollable: true,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(child: Text("Tin của bạn"),),
              Tab(child: Text("Chờ phê duyệt"),),
              Tab(child: Text("Ứng viên"),),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
          Approved(),
            Not_approved(),
            Candicate_tab()
          ],
        ),
      ),
    );
  }

}
