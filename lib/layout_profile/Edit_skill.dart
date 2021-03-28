import 'dart:convert';
import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Edit_skill extends StatefulWidget {
  Edit_skill({Key key,this.data}) : super(key: key);
  var data;
  @override
  _Edit_skill createState() => _Edit_skill();
}

class _Edit_skill extends State<Edit_skill> {
  String id = sharedPrefs.user_id.toString();
  bool ready  = true;
bool check_mob = false;
bool check_web = false;
bool check_game = false;
call_edit() async {
  setState(() {
    ready = false;
  });
  String url2 = "https://find-job-app.herokuapp.com/api/job-skills-of-candidate/set-user-job-skills";
  String skill1=check_mob?'1,':"";
  String skill2=check_game?'2,':"";
  String skill3=check_web?'3,':"";
  String arrskill= skill1+skill2+skill3;
  String sub = arrskill.substring(0,arrskill.length>1?arrskill.length-1:0);
String json ='{"userId":"$id","jobSkillIdArr":['+sub+']}';
  Map pr = {"requestDataJsonString":"$json"};
    Response response = await post(url2, body: pr);
  print(jsonDecode(response.body));
Navigator.of(context).pop();
showToast("Vuốt xuống để cập nhật", context, Colors.greenAccent, Icons.arrow_circle_down_outlined);
  setState(() {
    ready= true;
  });
}
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

            ),

            child: Column(

              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(value: check_mob, onChanged: (v) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        setState(() {
                          check_mob = !check_mob;
                        });
                      },),
                    ),
                    Text("Lập trình di động")
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(value: check_web, onChanged: (v) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                      }
                      setState(() {
                        check_web = !check_web;
                      });
                      },),
                    ),
                    Text("Lập trình web")
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(value: check_game, onChanged: (v) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          check_game = !check_game;
                        });
                      },),
                    ),
                    Text("Lập trình game")
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Hủy",
                    style: TextStyle(color: Colors.white),
                  ),
                  color:Colors.red,
                ),
                RaisedButton(
                  onPressed: () {
                    ready?call_edit():null;
                  },
                  child: Text(
                    "Đồng ý",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: ready?Colors.green:Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
