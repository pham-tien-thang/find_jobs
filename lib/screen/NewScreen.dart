import 'dart:ui';
import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/item_app/Buttton_pair.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_new/Header2.dart';
import 'package:find_jobs/layout_new/new_lazy.dart';
import 'package:find_jobs/model/News_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//void main() => runApp(MyApp());

// ignore: camel_case_types
class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      body: MyNewScreen(),
    );
  }
}

class MyNewScreen extends StatefulWidget {
  MyNewScreen({Key key}) : super(key: key);
  @override
  _MyNewScreen createState() => _MyNewScreen();
}

class _MyNewScreen extends State<MyNewScreen> {
  int _nextPage = 1;
  bool _loading = true;
  bool _canLoadMore = true;
  static const double _endReachedThreshold2 = 100;
  static const int _itemsPerPage2 = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ScrollController scrollController = new ScrollController();
  final ScrollController scrollControllers = new ScrollController();
  bool check = false;
  int gr = 1;
  List<New_model> _newmd = [];
  bool h = false;
  int page = 1;
  _onUpdateScroll(ScrollMetrics metrics) {
    if (scrollControllers.offset > 40&& !h) {
      setState(() {
        h = true;
        scr=true;
      });
    } else if (scrollControllers.offset <= 0&& h) {
      setState(() {
        h = false;
        scr=false;
      });
    }
  }
  bool scr = false;
  void _onScroll() {
    if (!scrollControllers.hasClients || _loading) return;
    final thresholdReached =
        scrollControllers.position.extentAfter < _endReachedThreshold2;
    if (thresholdReached) {
      setState(() {
        page++;
      });
      getnewapi();
    }
  }
  Widget _buildnewItem(BuildContext context, int index) {
    return new_lazy(_newmd[index]);
  }
  void getnewapi() async{
    _loading = true;
    Api_findjobs api_new = new Api_findjobs("/api/news", {
      'perpage ': '5',
      'page':page.toString(),

    },);
    var res = await api_new.postMethod() ;
    if(res['newsArr'].length<1){
      setState(() {
        _canLoadMore = false;
      });   }
    else{
      setState(() {
        _loading = false;
        for(int i=0 ; i<res['newsArr'].length;i++ ){
          New_model a = New_model.fromJson(res,i);
          if(!_newmd.contains(a)){
            _newmd.add(a);}
          print("da add page"+i.toString()+"new md co"+_newmd.length.toString()+"cai" );
        }
      });}

  }


  @override
  void initState() {
    getnewapi();
    scrollControllers.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scr?
      AppBar(
        title: Text("Tin tức"),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     // showSearch(context: context, delegate: seach_bar());
          //   },
          // )
        ],
      )
          :PreferredSize(
        preferredSize: Size(double.infinity, MediaQuery.of(context).size.width/4),
        child:
        Stack(
            alignment: Alignment(-1, -1),
            children: [

              Header2(img: "assets/new_header.jpg",),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:Icon(Icons.arrow_back,
                        color: Colors.white,),// add custom icons also
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.search,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     // showSearch(context: context, delegate: seach_bar());
                    //   },
                    // )
                  ],
                ),
              ),
            ]
        ),
      ),
      key: _scaffoldKey,
      drawer: Drawer_findjobs(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          }
        },
        child: SingleChildScrollView(
          controller: scrollControllers,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //header
                Divider(),
                //bodytintuc
                Container(
                  child: Column(children: [
                    // banner
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          //listnewmodel
                          CustomScrollView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            controller: new ScrollController(),
                            slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  _buildnewItem,
                                  childCount: _newmd.length,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: _canLoadMore
                                    ? Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  child:  Center(
                                      child: SpinKitCircle(
                                        color: Colors.green,
                                        size: 50,
                                      )
                                  ),
                                )
                                    : SizedBox(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),

              ]),
        ),
      ),
      floatingActionButton: ButtonPair(
        s: scrollControllers,
        h: h,
        phone: false,
      ),
    );
  }
}
