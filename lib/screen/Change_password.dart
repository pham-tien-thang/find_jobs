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

class Change_password extends StatefulWidget {
  Change_password({Key key}) : super(key: key);
  @override
  _Change_password createState() => _Change_password();
}

class _Change_password extends State<Change_password> {
  TextEditingController mat_khau_cu = new TextEditingController();
  TextEditingController mat_khau_moi = new TextEditingController();
  TextEditingController mat_khau_moi2 = new TextEditingController();
  bool obs_mat_khau_cu = true;
  bool obs_mat_khau_moi = true;
  bool obs_mat_khau_moi2 = true;
  bool rd = true;
_obcuretext (int n){
  print(n.toString());
  if(n==1){
   setState(() {
     obs_mat_khau_cu = !obs_mat_khau_cu;
   });
  }
  else if(n==2){
  setState(() {
    obs_mat_khau_moi = !obs_mat_khau_moi;
  });
  }
  else if(n==3){
 setState(() {
   obs_mat_khau_moi2 = !obs_mat_khau_moi2;
 });
  }
}
call_change() async{
  Api_findjobs login = new Api_findjobs(
      "/api/users/change-password",
      {
        'userId': sharedPrefs.user_id,
        'oldPassword': mat_khau_cu.text.toString(),
        'newPassword': mat_khau_moi.text.toString(),
      }
  );
  var res = await login.postMethod();
  if(!res['result']){
    showToast("Sai mật khẩu cũ", context, Colors.red, Icons.cancel);
    setState(() {
      rd = true;
    });
  }
  else if(res['result']){
    showToast("Hoàn tất", context, Colors.green, Icons.check);
    setState(() {
      rd = true;
    });
    Navigator.of(context).pop();
  }
  print(res);
  }
vaidate(){
  if(mat_khau_cu.text.length<1){
    showToast("Nhập mật khẩu cũ", context, Colors.red, Icons.cancel);
  }
  else if(mat_khau_moi.text.length<6){
    showToast("Mật khẩu ít nhất 6 ký tự", context, Colors.red, Icons.cancel);
  }
  else if(mat_khau_moi2.text!=mat_khau_moi.text){
    showToast("Nhập lại mật khẩu", context, Colors.red, Icons.cancel);
  }
  else{
      print('chay vao else');
        setState(() {
      rd  = false;
    });
    call_change();
    };
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
        title: Text("Đổi mật khẩu"),
        backgroundColor: Colors.green,
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.of(context).pop();
        },
        ),
      ),
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
               // height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade100,
                child: Container(
                  color: Colors.white,

                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ĐỔI MẬT KHẨU",
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
                              controller: mat_khau_cu,
                              obscureText: obs_mat_khau_cu,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Mật khẩu cũ",
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
                                hintText: 'Mật khẩu cũ',
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _obcuretext(1);
                              },
                              child: Container(
                                width: 30,
                                child: Icon(
                                  Icons.lock_rounded,
                                  size: mda / 15,
                                  color: obs_mat_khau_cu?Colors.green.shade700:Colors.greenAccent,
                                ),
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
                              controller: mat_khau_moi,
                              obscureText: obs_mat_khau_moi,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Mật khẩu mới",
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
                                hintText: 'Mật khẩu mới',
                              ),
                            ),
                            GestureDetector(
                              onTap:(){
                               _obcuretext(2);
                              },
                              child: Container(
                                width: 30,
                                child: Icon(
                                  Icons.lock,
                                  size: mda / 15,
                                  color: obs_mat_khau_moi
                                      ? Colors.green.shade700
                                      : Colors.greenAccent,
                                ),
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
                              controller: mat_khau_moi2,
                              obscureText: obs_mat_khau_moi2,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Nhập lại mật khẩu mới",
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
                                hintText: 'Nhập lại mật khẩu mới',
                              ),
                            ),
                            GestureDetector(
                              onTap:(){
                               _obcuretext(3);
                              },
                              child: Container(
                                width: 30,
                                child: Icon(
                                  Icons.lock,
                                  size: mda / 15,
                                  color: obs_mat_khau_moi2
                                      ? Colors.green.shade700
                                      : Colors.greenAccent,
                                ),
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
                          color: rd?Colors.green.shade700:Colors.grey,
                          textColor: Colors.white,
                          onPressed: () {
                           vaidate();
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
