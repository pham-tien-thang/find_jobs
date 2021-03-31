import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// ignore: camel_case_types
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tìm kiếm việc làm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mydangky(),
    );
  }
}

class Mydangky extends StatefulWidget {
  Mydangky({Key key}) : super(key: key);

  @override
  _Mydangky createState() => _Mydangky();
}

class _Mydangky extends State<Mydangky> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool iconD = false;
  //int gr = 0;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController pw = new TextEditingController();
  TextEditingController re_pw = new TextEditingController();
  bool ready= true;
  bool _obscuretext = true;
  bool _obscuretext2 = true;
  void _toggle(int p){
    setState(() {
      if( p ==1){
        _obscuretext=!_obscuretext;
      }
      else if (p ==2){
        _obscuretext2 =!_obscuretext2;
      }
      else {
        //showToast("lỗi", context, Colors.red, Icons.clear);
      }
    });
  }
  //----validate repass
  validatePassword(){
    if(re_pw.text!=pw.text){
      return false;
    }
    else return true;
  }
  //------------call api
  signup()async{
    if (validatePassword()){
      setState(() {
        ready = false;
      });

      Api_findjobs login = new Api_findjobs(
          "/api/users/create",
          {
            'email': mail.text,
            'password': pw.text,
            'fullName':name.text,
            'phone':phone.text
          }
      );
      var res = await login.postMethod();
      print(res);
      if(!res['result']){
        showToast(res['message'].toString(), context, Colors.redAccent, Icons.clear);
        setState(() {
          ready = true;
        });
      }
      else if(res['result']){
        // Navigator.push(
        //     context, new MaterialPageRoute(builder: (context) => Mydangky()));
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>LoginScreen()));
        showToast("Đăng ký thành công", context, Colors.greenAccent, Icons.check);
      }
    }
    else{
      showToast("Nhập lại mật khẩu", context, Colors.redAccent, Icons.clear);
    }

  }
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      //drawer: drawer(),
      appBar: AppBar(
        title: Text('Đăng ký'),

      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
            onTap: (){
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      }
      },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade100,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Text(
                  "ĐĂNG KÝ",
                  style: TextStyle(
                      fontSize: mda / 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Stack(
                    alignment: const Alignment(0.9, 0.0),
                    children: [
                      TextField(
                        controller: name,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Họ và tên",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          //  fillColor: Colors.red,
                          hintText: 'Họ và tên',
                        ),
                      ),
                      Container(
                        width: 30,
                        child: Icon(
                          Icons.person,
                          size: mda / 15,
                          color: Colors.green,
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
                        keyboardType: TextInputType.number,
                        controller: phone,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Số điện thoại",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          //  fillColor: Colors.red,
                          hintText: 'Số điện thoại',
                        ),
                      ),
                      Container(
                        width: 30,
                        child: Icon(
                          Icons.phone,
                          size: mda / 15,
                          color: Colors.green,
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
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          labelText: "Sử dụng email của bạn",
                          hintStyle: null,
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          //  fillColor: Colors.red,
                          hintText: 'Email',
                        ),
                      ),
                      Container(
                        width: 30,
                        child: Icon(
                          Icons.email,
                          size: mda / 15,
                          color: Colors.green,
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
                                  color: Colors.green, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          //  fillColor: Colors.red,
                          hintText: 'Mật khẩu',
                        ),
                      ),
                      GestureDetector(
                        onTap:()=> _toggle(1),
                        child: Container(
                          width: 30,
                          child: Icon(
                            Icons.lock,
                            size: mda / 15,
                            color:  _obscuretext?Colors.green.shade700:Colors.green,
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
                        controller: re_pw,
                        obscureText: _obscuretext2,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Nhập lại mật khẩu",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.0)),
                          //  fillColor: Colors.red,
                          hintText: 'Nhập lại mật khẩu',
                        ),
                      ),
                      GestureDetector(
                        onTap:  ()=>_toggle(2),
                        child: Container(
                          width: 30,
                          child: Icon(
                            Icons.lock,
                            size: mda / 15,
                            color: _obscuretext2?Colors.green.shade700:Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: FlatButton(
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: mda / 25),
                    ),
                    color:ready?Colors.green:Colors.black45,
                    textColor: Colors.white,
                    onPressed: ()  {
                        signup();
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
