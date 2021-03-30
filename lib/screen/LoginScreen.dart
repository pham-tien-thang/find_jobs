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
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tìm kiếm việc làm',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyLoginScreen(),
    );
  }
}

class MyLoginScreen extends StatefulWidget {
  MyLoginScreen({Key key}) : super(key: key);
  @override
  _MyLoginScreen createState() => _MyLoginScreen();
}

class _MyLoginScreen extends State<MyLoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
  show_dialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(20.0),
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
                      child: Text("Thoát ứng dụng ?",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
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
                          color:Colors.green,
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
  //-----------call api
  call_login() async {
    setState(() {
      rd = false;
    });

    Api_findjobs login = new Api_findjobs(
      "/api/users/login",
      {
        'email': mail.text,
        'password': pw.text,
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
      print(res['userInfo'][0]['fullName']+res['userInfo'][0]['id'].toString());
      sharedPrefs.addStringToSF(res['userInfo'][0]['id'].toString(),
          res['userInfo'][0]['fullName'],
          res['userInfo'][0]['password'],
          res['userInfo'][0]['email'],
          res['userInfo'][0]['phone']
      );
      sharedPrefs.remember(mail.text, pw.text, check);
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>HomeScreen()));
      showToast("Đăng nhập thành công", context, Colors.greenAccent, Icons.check);
    }
  }
  remember() async {
    bool save = await sharedPrefs.r_save;
    if (save) {
      bool value = await sharedPrefs.r_save_value;
      setState(() {
        check = value;
        if (value) {
          setState(() {
            mail.text = sharedPrefs.r_mail;
            pw.text = sharedPrefs.r_pass;
          });
        } else {
          setState(() {
            mail.text = "";
            pw.text = "";
          });
        }
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    remember();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,

      body:WillPopScope(
onWillPop: (){show_dialog();},
        child: SingleChildScrollView(
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
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade100,
            child: Container(
              color: Colors.white,

              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ĐĂNG NHẬP",
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
                            labelText: "Email",
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
                            hintText: 'Email',
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
                          controller: pw,
                          obscureText: _obscuretext,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Mật khẩu",
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
                            hintText: 'Mật khẩu',
                          ),
                        ),
                        GestureDetector(
                          onTap: _toggle,
                          child: Container(
                            width: 30,
                            child: Icon(
                              Icons.lock,
                              size: mda / 15,
                              color: _obscuretext
                                  ? Colors.green.shade700
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: check,
                            onChanged: (v) {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              setState(() {
                                check = !check;
                              });
                            },
                          ),
                          Text(
                            "Ghi nhớ mật khẩu",
                            style: TextStyle(
                              fontSize: mda / 25,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                        },
                        child: Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                              fontSize: mda / 25,
                              color: Colors.green.shade700,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: FlatButton(
                      child: Text(
                        rd ?'Đăng nhập':'Đang đăng nhập...',
                        style: TextStyle(fontSize: mda / 25),
                      ),
                      color: rd ? Colors.green.shade700 : Colors.black45,
                      textColor: Colors.white,
                      onPressed: () {
                       // call_login();
                        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>HomeScreen()));
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chưa có tài khoản?",
                        style: TextStyle(fontSize: mda / 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.push(
                              context, new MaterialPageRoute(builder: (context) => Mydangky()));
                        },
                        child: Text(
                          "Đăng ký ngay",
                          style: TextStyle(
                            fontSize: mda / 25,
                            color: Colors.green.shade700,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
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
