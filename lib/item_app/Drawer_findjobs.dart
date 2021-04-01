import 'dart:ui';


import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:find_jobs/screen/LoginScreen.dart';
import 'package:find_jobs/screen/NewScreen.dart';
import 'package:find_jobs/screen/introduce_screen.dart';
import 'package:find_jobs/screen/job_detail/job_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// ignore: camel_case_types
class Drawer_findjobs extends StatefulWidget {
  Drawer_findjobs({Key key, this.title}) : super(key: key);
  final String title;
  String a;
  @override
  _drawer createState() => _drawer();
}

// ignore: camel_case_types
class _drawer extends State<Drawer_findjobs> {
  @override
  Widget build(BuildContext context) {
    sharedPrefs.init();
    double mda = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            height: MediaQuery.of(context).size.height / 4.5,
            child: Image.asset(
              'assets/header1.png',
              width: mda / 6,
              height: mda / 6,
            ),
            decoration: BoxDecoration(
              //color: Colors.blue,
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.1),
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: Row(
              children: [
                FlatButton(
                  child: Container(
                      width: 112,
                      height: 50,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(
                              sharedPrefs.check ? Icons.vpn_key : Icons.lock,
                              color: Colors.green,
                              size: 20.0,
                            ),
                          ),
                          Text(
                             "Tài khoản" ,
                            style: TextStyle(
                                fontSize: 15, color: Colors.green),
                          )
                        ],
                      )),
                  //color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
               Navigator.push(
                        context, new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
                  },
                ),
                Transform.rotate(
                  angle: -12.2,
                  child: VerticalDivider(),
                ),
                FlatButton(
                  child: Container(
                      width: 112,
                      height: 50,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(
                              sharedPrefs.check ?Icons.lock : Icons.vpn_key,
                              color: Colors.green,
                              size: 20.0,
                            ),
                          ),
                          Text(
                            "Đăng xuất",
                            style: TextStyle(
                                fontSize: 15, color: Colors.green),
                          )
                        ],
                      )),
                  //color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false);
                    removeValues();

                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 300,
                height: 40,
                child: FlatButton(
                  child:  Container(
                    width: 300,
                    height: 35,
                    child: Row(
                      children: [
                        Text(
                          ' Trang chủ',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  //color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                  },
                ),
              ),
              Divider(),
              Container(
                width: 300,
                height: 35,
                child: FlatButton(
                  child:  Container(
                    width: 300,
                    height: 35,
                    child: Row(
                      children: [
                        Text(
                          ' Tin tức ',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  //color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NewScreen()));
                  },
                ),
              ),
              Divider(),
              ConfigurableExpansionTile(
                animatedWidgetFollowingHeader: const Icon(
                  Icons.expand_more,
                  color: const Color(0xFF707070),
                ),
                header: GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
                    padding:EdgeInsets.fromLTRB(10, 8, 10, 8),
                    child: Container(
                      width: 240,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            " Danh mục việc làm IT",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                                fontWeight: FontWeight.normal),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                children: [
                  Divider(),
                  Container(
                    width: 300,
                    height: 35,
                    child: FlatButton(
                      child:  Container(
                        width: 300,
                        height: 35,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text(
                              ' Mobile developer (Android/IOS)',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      //color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {

                      },
                    ),
                  ),
                  //=========================================
                  Divider(),
                  Container(
                    width: 300,
                    height: 35,
                    child: FlatButton(
                      child:  Container(
                        width: 300,
                        height: 35,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text(
                              ' Game developer (C#,C++,Java...)',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      //color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();

                      },
                    ),
                  ),
                  //==========================
                  Divider(),
                  Container(
                    width: 300,
                    height: 35,
                    child: FlatButton(
                      child:  Container(
                        width: 300,
                        height: 35,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text(
                              ' Web developer',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      //color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();

                      },
                    ),
                  ),
                  //=================================
                ],
              ),


              Divider(),

              
              Container(
                width: 300,
                height: 35,
                child: FlatButton(
                  child:  Container(
                    width: 300,
                    height: 35,
                    child: Row(
                      children: [
                        Text(
                          ' Danh sách ứng viên',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  //color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailPage()));
                  },
                ),
              ),
              Divider(),
              Container(
                width: 300,
                height: 35,
                child: FlatButton(
                  child:  Container(
                    width: 300,
                    height: 35,
                    child: Row(
                      children: [
                        Text(
                          ' Giới thiệu',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  //color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IntroduceScreen()));
                  },
                ),
              ),
              Divider(),
              //===========

            ],
          ),
        ],
      ),
    );
  }
}
