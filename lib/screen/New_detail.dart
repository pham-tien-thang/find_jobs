import 'dart:ui';

import 'package:find_jobs/item_app/Buttton_pair.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_new/Header2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class New_detail extends StatefulWidget {
  New_detail({Key key, this.title, this.content,this.img})
      : super(key: key);
  final String title;
  final String content;
  final String img;
  @override
  _new_detail createState() => _new_detail();
}

class _new_detail extends State<New_detail> {
  //String mail = sharedPrefs.mail;
  ScrollController scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // bool au() {
  //   if (widget.auth.length < 1) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
  final ScrollController scrollControllers = new ScrollController();
  bool h = false;
  _onUpdateScroll(ScrollMetrics metrics) {
    if (scrollControllers.offset > 0 && !h) {
      setState(() {
        h = true;
      });
    } else if (scrollControllers.offset <= 0) {
      setState(() {
        h = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: ButtonPair(
        s: scrollControllers,
        h: h,
      ),
      drawer: Drawer_findjobs(),
      key: _scaffoldKey,

      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          }
        },
        child: NestedScrollView(
          controller: scrollControllers,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back, // add custom icons also
                  ),
                ),
                actions: [
                  // IconButton(
                  //   icon: Icon(Icons.search),
                  //   onPressed: () {
                  //     showSearch(context: context, delegate: seach_bar());
                  //   },
                  // )
                ],
                expandedHeight: mda/4.25,
                floating: true,
                pinned: true,
                stretch: true,
                snap: false,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  // print('constraints=' + constraints.toString());
                  var top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(top <= 100? "Tin tức" : ""),
                    stretchModes: <StretchMode>[
                      StretchMode.zoomBackground,
                    ],
                    background:
                    Header2(img: "assets/new_header.jpg",),
                  );
                }),
              ),
            ];
          },
          body: SingleChildScrollView(
            //controller: scrollControllers,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Show_drawer(scaffoldKey: _scaffoldKey,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          widget.title.toUpperCase(),
                          style: TextStyle(
                              fontSize: mda / 24, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Divider(),
                      Image.network(
                        widget.img,
                        fit: BoxFit.fitWidth,
                        //fit: BoxFit.fitHeight,
                        // height: 250,
                      ),
                      Divider(),
                      Text(widget.content),
                      // Html(
                      //   data: widget.content,
                      //   onLinkTap: (link) async {
                      //     await launch(link);
                      //   },
                      // ),
                      //Text(widget.content,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
