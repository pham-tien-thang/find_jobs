import 'dart:ui';

import 'package:find_jobs/item_app/BottomNavigation.dart';
import 'package:find_jobs/item_app/Buttton_pair.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_new/Header2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'Detail_user.dart';
import 'HomeScreen.dart';


class Search_keywword extends StatefulWidget {
  Search_keywword({Key key, this.data})
      : super(key: key);
  var data;

  @override
  _Search_keywword createState() => _Search_keywword();
}

class _Search_keywword  extends State<Search_keywword> with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Tìm việc làm'),
    new Tab(text: 'Tìm ứng viên'),
  ];
  ontapbottom(int index) {
    setState(() {
      if (index == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
      }
      if (index == 2) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => profile(
                  my_acc: true,
                )));
      }
      if (index == 1) {
        // Navigator.push(
        //     context, new MaterialPageRoute(builder: (context) => Search_keywword()));
      }
    });
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child:
        Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Builder(
                builder: (context) => IconButton(icon: Icon(Icons.dehaze), onPressed: (){
                  Scaffold.of(context).openDrawer();
                }),
           ),

                Center(
                  child: Stack(
                    alignment: Alignment(1, 0),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),

                        width:MediaQuery.of(context).size.width-100,
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                            hintText: 'Từ khóa...',
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.search), onPressed: (){
                        print(_tabController.index.toString()+ "là tab");
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationcustom(selectedIndex:1,tap: ontapbottom,),
      drawer: Drawer_findjobs(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    controller: _tabController,
                    indicatorColor: Colors.green,
                    labelColor: Colors.green,
                    //isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    tabs:myTabs.map((Tab tab) {
                      return new Center(child: new Text(tab.text));
                    }).toList(),
                  ),
                ),
              ),
            ),

            body: TabBarView(
              controller: _tabController,
              children: [
                //VIEC LAM TRONG NUOC
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                     Center(child: Text("A"))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      Center(child: Text("data"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
