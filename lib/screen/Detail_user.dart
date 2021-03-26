import 'dart:io';
import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/item_app/BottomNavigation.dart';
import 'package:find_jobs/item_app/Buttton_pair.dart';
import 'package:find_jobs/layout_profile/Profile_above.dart';
import 'package:find_jobs/layout_profile/Profile_below.dart';
import 'package:find_jobs/model/Option.dart';
import 'package:find_jobs/screen/Change_password.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:fluttertoast/fluttertoast.dart';

class profile extends StatefulWidget {
  profile({Key key,this.my_acc,this.id}) : super(key: key);
  final bool my_acc;
  String id;
  @override
  _profile createState() => _profile();
}

class _profile extends State<profile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //user_Infomation user_infomationn = new user_Infomation();
  int type;
  int solan =0;
  bool scr = false;
  ScrollController scrollControllers = new ScrollController();
  bool _isVisible = true;
  bool h = false;
  String contact;
  call_api_detail()async{
    Api_findjobs a = new Api_findjobs(widget.my_acc?"/api/users/details-get-id":"/api/users/details-get-id", {
      //'userId': ,
      'userId': widget.my_acc?sharedPrefs.user_id.toString():widget.id,
    },);
var res = await a.postMethod();

    return res;
  }
  Future<void> _refresh() async {
   call_api_detail();
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    if (scrollControllers.offset > 40&& !h) {
      setState(() {
        h = true;
      //  print(scrollControllers.offset.toString()+"hien len============="); // scr=true;
      });
    } else if (scrollControllers.offset <= 10&& h) {
      setState(() {
        h = false;
        //print(scrollControllers.offset.toString()+"khong hien len============="); // sc
      });
    }

  }
  @override
  void initState() {
    scrollControllers.addListener(() {
      if (scrollControllers.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if(_isVisible)
          setState(() {
            _isVisible = false;
            print("**** $_isVisible up");
          });
      }
      if (scrollControllers.position.userScrollDirection ==
          ScrollDirection.forward) {
        if(!_isVisible)
          setState(() {
            _isVisible = true;
            print("**** $_isVisible down");
          });
      }
    });
    // solan =0;
    // super.initState();
    // list_exp.clear();
    // list_edu.clear();
    //call_api_detail();
    print('innit');
  }
  // void Action(String choice){
  //
  //   if(choice == Option.signout||choice == "Đăng nhập"){
  //     removeValues();
  //     Navigator.pushReplacement(
  //         context, new MaterialPageRoute(builder: (context) => dangnhap() ));
  //
  //   }else if(choice == Option.listus){
  //     Navigator.push(
  //         context, new MaterialPageRoute(builder: (context) => job_apply() ));
  //
  //   }
  //   else if(choice == Option.find_jobs){
  //     Navigator.push(
  //         context, new MaterialPageRoute(builder: (context) => Job_Find_People_Page() ));
  //
  //   }
  // }
  ontapbottom (int index){
    setState(() {
      if (index == 0) {

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
      }
      if (index == 2) {
        widget.my_acc?null:Navigator.push(
            context, new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
      }
      if (index == 1) {
        // Navigator.push(
        //     context, new MaterialPageRoute(builder: (context) => Job_Find_People_Page()));
      }
    });
  }
  void Action(String choice){

    if(choice == Option.doi_mat_khau){
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Change_password() ));

    }
    // else if(choice == Option.listus){
    //   Navigator.push(
    //       context, new MaterialPageRoute(builder: (context) => job_apply() ));
    //
    // }
    // else if(choice == Option.find_jobs){
    //   Navigator.push(
    //       context, new MaterialPageRoute(builder: (context) => Job_Find_People_Page() ));
    //
    // }
  }
  @override
  Widget build(BuildContext context) {
    sharedPrefs.init();
call_api_detail();
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: ButtonPair( s: scrollControllers,
        h: h,
      ),
      key: _scaffoldKey,
      bottomNavigationBar: Visibility(
          visible: _isVisible,
          child: BottomNavigationcustom(selectedIndex: widget.my_acc?2:2,tap: ontapbottom,)),
      // appBar: AppBar(
      //     title: Text('Tài khoản'),
      //     actions: <Widget>[
      //       PopupMenuButton<String>(
      //         onSelected: Action,
      //         itemBuilder: (BuildContext context){
      //           return sharedPrefs.check?Option.choices.map((String choice){
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Row(
      //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Container(
      //                       margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //                       child: Text(choice)
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }).toList():
      //           Option.choices2.map((String choice){
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Row(
      //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Container(
      //                       margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //                       child: Text(choice)
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }).toList();
      //         },
      //       )
      //     ]
      // ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) =>
          //         MyApp()), (Route<dynamic> route) => false);
        },
        child: FutureBuilder(
            future: call_api_detail(),
            builder: (context, snapshot){
              return  snapshot.hasData?
              NestedScrollView(
                controller: scrollControllers,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: widget.my_acc?<Widget>[
                        PopupMenuButton<String>(
                          onSelected: Action,
                          itemBuilder: (BuildContext context){
                            return Option.choices.map((String choice){
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(choice)
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        )
                      ]:null,
                      expandedHeight: 176.0,
                      floating: true,
                      pinned: true,
                      snap: false,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        // print('constraints=' + constraints.toString());
                        var top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          title: Text(top <= 100 ? snapshot.data['data']['user']['fullName'].toString() : ""),
                          background:
                          Stack(alignment: Alignment(-0.9, 0.9), children: [
                            Stack(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: top*1.5,
                                    child: snapshot.data['data']['user']['avatarUrl'].toString()=="null"?Image.asset(
                                      'assets/bg_null.jpg',
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment.topLeft,
                                    ):Image.network(snapshot.data['data']['user']['avatarUrl'].toString(),
                                        fit:BoxFit.cover
                                    )
                                ),
                                GestureDetector(
                                  onTap: (){
                                    // showToast("Xin chào "+user_infomationn.pro.full_name.toString(), context, Colors.amber, Icons.favorite);
                                  },
                                  onDoubleTap: (){
                                    // showToast("Xin chào "+user_infomationn.pro.full_name.toString()+" 😁", context, Colors.amber, Icons.favorite);
                                  },
                                  child: Container(
                                    // height: mda/14,
                                    width: mda,
                                    //
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius:BorderRadius.only(
                                          bottomLeft:Radius.circular(top/1.75),
                                          //  bottomRight: Radius.circular(top/1.5),
                                        )
                                      // ),
                                      //only(bottomLeft: Radius.circular(mda/1),bottomRight: Radius.circular(mda/1)),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      // Navigator.pushReplacement(context,
                                      //     new MaterialPageRoute(builder: (context) => edit_information(avatar:
                                      //     user_infomationn.pro.avatar_name.toString()=="null"?"":"https://vieclamquangbinh.gov.vn/static"+
                                      //         user_infomationn.pro.avatar_path
                                      //         +user_infomationn.pro.avatar_name,
                                      //       us: user_infomationn,
                                      //     )));
                                    },
                                    child: snapshot.data['data']['user']['avatarUrl'].toString()=="null"?Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                            radius: mda/12,
                                            backgroundImage: AssetImage('assets/user_null.jpg'),
                                          ),
                                        ),
                                        widget.my_acc?Container(
                                          height: mda/14,
                                          width: mda/14,
                                          //
                                          decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(mda)
                                            //only(bottomLeft: Radius.circular(mda/1),bottomRight: Radius.circular(mda/1)),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: mda/25,
                                          ),
                                        ):Container(
                                          width: 1,
                                          height: 1,
                                        ),
                                      ],
                                    ):Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 15.0,
                                                  offset: Offset(0.0, 1)
                                              )
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: mda/12,
                                            backgroundImage: NetworkImage(snapshot.data['data']['user']['avatarUrl'].toString(),),
                                          ),
                                        ),
                                        Container(

                                          height: mda/14,
                                          width: mda/14,
                                          //
                                          decoration: BoxDecoration(

                                              color: Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(mda)
                                            //only(bottomLeft: Radius.circular(mda/1),bottomRight: Radius.circular(mda/1)),
                                          ),
                                          child:    Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: mda/25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                    child: Container(
                                      width: mda/1.5,
                                      child: Text(snapshot.data['data']['user']['fullName'].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: mda/20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          // backgroundColor: Colors.black87.withOpacity(0.5)
                                        ),
                                      ),
                                    ),
                                  )
                                ],

                              ),
                            ),
                          ]),
                        );
                      }),
                    ),
                  ];
                },
                body: RefreshIndicator(
                  onRefresh: _refresh,
                  child: NotificationListener <ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification) {
                        _onUpdateScroll(scrollNotification.metrics);
                      }
                    },
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                          Profile_above(data: snapshot.data,my_acc: widget.my_acc,),
                            Profile_below(data: snapshot.data,my_acc:widget.my_acc ,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  :Center(child: CircularProgressIndicator());
            }
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
