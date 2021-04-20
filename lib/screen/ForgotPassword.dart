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
import 'SignUp.dart';
// ignore: camel_case_types


class MyForgotPassword extends StatefulWidget {
  MyForgotPassword({Key key,this.email}) : super(key: key);
  String email;
  @override
  _MyForgotPassword createState() => _MyForgotPassword();
}

class _MyForgotPassword extends State<MyForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rd = true;
  TextEditingController mail = new TextEditingController();
  TextEditingController code = new TextEditingController();
  //-----------call api
  call_login() async {
    setState(() {
      rd = false;
    });

    Api_findjobs login = new Api_findjobs(
        "/api/users/reset-password",
        {
          'email': widget.email,
          'tokenStringFromRequest': code.text,
          'newPassword': mail.text,
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
Navigator.pop(context);
showToast("Đã thay đổi mật khẩu", context, Colors.green, Icons.check);
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
                        "THAY ĐỔI MẬT KHẨU",
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
                              controller: code,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Nhập mã",
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
                                hintText: 'Nhập mã',
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Stack(
                          alignment: const Alignment(0.9, 0.0),
                          children: [
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: mail,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Nhập Mật khẩu mới",
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
                                hintText: 'Nhập Mật khẩu mới',
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
                            rd ?'Thay đổi':'Đang thay đổi...',
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
