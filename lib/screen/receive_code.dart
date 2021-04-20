import 'dart:io';
import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/main.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ForgotPassword.dart';
import 'SignUp.dart';
// ignore: camel_case_types
class R_code extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tìm kiếm việc làm',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyR_code(),
    );
  }
}

class MyR_code extends StatefulWidget {
  MyR_code({Key key}) : super(key: key);
  @override
  _MyR_code createState() => _MyR_code();
}

class _MyR_code extends State<MyR_code> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rd = true;
  TextEditingController mail = new TextEditingController();
  //-----------call api
  call_login() async {
    setState(() {
      rd = false;
    });

    Api_findjobs login = new Api_findjobs(
        "/api/users/send-email-reset-password",
        {
          'email': mail.text,
        }
    );
    var res = await login.postMethod();
    print(res);
    if(!res['result']){
      showToast(res['message'].toString(), context, Colors.redAccent, Icons.clear);
      setState(() {
        rd = true;
      });
    }
    else if(res['result']){
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyForgotPassword(email: mail.text,)));
      showToast("Kiểm tra email", context, Colors.green, Icons.check);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quên mật khẩu"),
      ),
      key: _scaffoldKey,
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 120, 15, 120),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.25,
                color: Colors.grey.shade100,
                child: Container(
                  color: Colors.white,

                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "QUÊN MẬT KHẨU",
                        style: TextStyle(
                            fontSize: mda / 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Stack(
                          alignment: const Alignment(0.9, 0.0),
                          children: [
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: mail,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Nhập email tài khoản của bạn",
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.green.shade700, width: 1.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.green.shade700, width: 1.0)),
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Colors.green.shade700, width: 1.0)),
                                //  fillColor: Colors.red,
                                hintText: 'Nhập email tài khoản của bạn',
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Icon(
                                Icons.email,
                                size: mda / 15,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: FlatButton(
                          child: Text(
                            rd ?'Lấy mã':'Đang lấy mã...',
                            style: TextStyle(fontSize: mda / 25),
                          ),
                          color: rd ? Colors.green.shade700 : Colors.black45,
                          textColor: Colors.white,
                          onPressed: () {
                            call_login();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
