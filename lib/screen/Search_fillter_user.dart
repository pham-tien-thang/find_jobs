import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/item_app/Regulations.dart';
import 'package:find_jobs/model_thang/Approved_model.dart';
import 'package:find_jobs/model_thang/Jobsnew_candicate.dart';
import 'package:find_jobs/model_thang/Saraly_model.dart';
import 'package:find_jobs/model_thang/Skill_jobs.dart';
import 'package:find_jobs/model_thang/Unapproved_model.dart';
import 'package:find_jobs/model_thang/User_fillter.dart';
import 'package:find_jobs/model_thang/job_new_model.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:find_jobs/screen/job_detail/job_detail_page.dart';
import 'package:find_jobs/tab_in_approve/Candicate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Search_fillter_user extends StatefulWidget {
  Search_fillter_user({Key key,}) : super(key: key);


  @override
  _Search_fillter_user createState() => _Search_fillter_user();
}

class _Search_fillter_user extends State<Search_fillter_user> {
  List<DropdownMenuItem<String>> _AddressdropDownMenuItems ;
  List<DropdownMenuItem<String>> _EducationdropDownMenuItems ;
  List<DropdownMenuItem<String>> _SkilldropDownMenuItems ;
  List<DropdownMenuItem<String>> _saralydropDownMenuItems ;
  String curren_address;
  String curren_skill;
  String curren_education;
  String curren_saraly;
  Future _all;
  bool search = false;
  List<User_fillter> list_all=[];
  List<User_fillter> list_search=[];
  List address = [
  ];
  List skill = [
    "Tất cả",
    "Lập trình di động",
    "Lập trình game",
    "Lập trình Web"
  ];
  Saraly_model curren_saraly_model;
  List<Saraly_model> list_luong=[
    new Saraly_model(0, 100000000),
    new Saraly_model(0, 5000000),
    new Saraly_model(5000000, 10000000),
    new Saraly_model(10000000, 20000000),
    new Saraly_model(20000000, 100000000)
  ];
  List luong = [
    "Tất cả",
    "0-5 triệu",
    "5-10 triệu",
    "10-20 triệu",
    "Trên 20 triệu"
  ];
  List education = [
    "Tất cả",
    "Trên đại học",
    "Đại học",
    "Cao đẳng",
  ];

  List<DropdownMenuItem<String>> getaddressDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in address) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> geteducationDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in education) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> getskillDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in skill) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> getsaralyDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in luong) {
      items.add(drop(de));
    }
    return items;
  }
  Widget drop(String d) {
    return new DropdownMenuItem(
        value: d,
        child: Center(
          child:Text(
            d,
            style: TextStyle(fontSize: 14,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }

  call_all()async{
    Api_findjobs getall = new Api_findjobs("/api/users", {
      "":""
    });
    var res_tinh = await call_tinh();
    if(res_tinh['result']){
      var res_all = await getall.getMethod();
if(res_all['result']){
  if(res_all['users'].length>0){
    list_all.clear();
    for(int i = 0 ; i < res_all['users'].length;i++){
      List<Skill_jobs> list_sk = [];
    //  print(res_all['users'][i]['addressStateProvince']);
      //====có skill
     if(res_all['users'][i]['skills'].length>0){

       list_sk.clear();
       for(int c=0; c < res_all['users'][i]['skills'].length;c++){
         Skill_jobs j  = new Skill_jobs(name: res_all['users'][i]['skills'][c]['skillName']);
         list_sk.add(j);
       }
       print("co skill");
     }
     //===k co skill
     else{
       list_sk.clear();
       print(" k co skill");
     }
     User_fillter u = new User_fillter(res_all['users'][i]['fullName'],
         res_all['users'][i]['avatarUrl'].toString(),
         res_all['users'][i]['id'] as int,
         res_all['users'][i]['gender'].toString(),
         res_all['users'][i]['expectedSalaryInVnd'].toString(),
         res_all['users'][i]['addressStateProvince'].toString(),
         res_all['users'][i]['levelOfEducationName'].toString(),
         res_all['users'][i]['birthdayInMilliseconds'],
         list_sk);
     list_all.add(u);
     print(list_all.length.toString()+"người");
    }
    showToast(" Đã tải người dùng", context, Colors.green, Icons.check);
    return 1;
  }
  else{
    showToast("Không có người dùng", context, Colors.red, Icons.cancel);
    return 1;
  }
}
else{
  showToast("Lấy danh sách thất bại", context, Colors.red, Icons.cancel);
  return 1;
}
    }
    else {
      showToast("Lấy danh sách tỉnh thất bại", context, Colors.red, Icons.cancel);
      return 1;
    }
  }
  String tuoi(int milis){
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    var dateConvert = new DateTime.fromMillisecondsSinceEpoch(
        milis );
    String t = formatter.format(dateConvert);
    return t;
  }
  call_tinh()async{
    setState(() {
      address.clear();
    });
    Api_findjobs get_api_tinh = new Api_findjobs("/api/states-provinces", {
      "":""
    },);
    var res = await get_api_tinh.getMethod();
    address.add("Tất cả địa chỉ");
    for(int i = 0 ; i<res['stateProvinces'].length;i++){
      address.add(res['stateProvinces'][i]['name']);
    }
    setState(() {
      curren_address = address[0];
      _AddressdropDownMenuItems = getaddressDropDownMenuItems();
    });
    return res;
  }
  void changedaddressDropDownItem(String selectedCity) {
    setState(() {
      curren_address = selectedCity;
    });
   call_search();
  }
  void changedskillDropDownItem(String selectedCity) {
    setState(() {
      curren_skill = selectedCity;
    });
   call_search();
  }
  void changedsaralyDropDownItem(String selectedCity) {
    setState(() {
      curren_saraly = selectedCity;
    });
    for(int  i = 0 ; i < luong.length;i++){
      if(curren_saraly==luong[i]){
        setState(() {
          curren_saraly_model = list_luong[i];
          print(curren_saraly_model.min.toString()+"đến"+curren_saraly_model.max.toString());
        });
       call_search();
      }
    }
  }
  void changededucationDropDownItem(String selectedCity) {
    setState(() {
      curren_education  = selectedCity;
    });
   call_search();
  }
  call_search(){
    setState(() {
      search = true;
      list_search.clear();
    });
    Skill_jobs c = new Skill_jobs(name: curren_skill);
   for(int i = 0 ; i < list_all.length;i++){
  if(

  ( curren_address =="Tất cả địa chỉ"?true:list_all.elementAt(i).address.toString() == curren_address.toString())
      && (curren_education=="Tất cả"?true:list_all.elementAt(i).level.toString() == curren_education)
      &&curren_saraly =="Tất cả"?true:
  (list_all.elementAt(i).salary.toString()=="null"
      ?false
      :(int.parse(list_all.elementAt(i).salary.toString())<=curren_saraly_model.max&&
      int.parse(list_all.elementAt(i).salary.toString())>=curren_saraly_model.min))
    &&(curren_skill =="Tất cả"?true:list_all.elementAt(i).skill.any((e) => e.name == c.name))
  ){
    list_search.add(list_all[i]);
    print(list_search.length.toString());


  }
  else{
    print(" k ok");
  }
   }

  }
  settext(){
    setState(() {
      curren_saraly_model= list_luong[0];
      curren_saraly = luong[0];
      curren_skill = skill[0];
      curren_education = education[0];
    });

    _saralydropDownMenuItems = getsaralyDropDownMenuItems();
    _EducationdropDownMenuItems = geteducationDropDownMenuItems();
    _SkilldropDownMenuItems = getskillDropDownMenuItems();
  }
  String _saraly(String l){
    if(l.length>6){
      String a = l.substring(0,l.length-6);
      return a + " triệu VNĐ";
    }
    else {
      return l;
    }
  }
  @override
  void initState() {
    settext();
    _all = call_all();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double mda_h = MediaQuery.of(context).size.height;
    double mda = MediaQuery.of(context).size.width;
    // show_noiquy(mda, mda_h);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.green,
        title: Text("Tìm ứng viên"),
      ),
      body: FutureBuilder(
        future: _all,
        builder: (context,snapshot){
          return  snapshot.hasData?SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.green,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: mda,
                        //color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:  MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Địa chỉ",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Center(
                                      child: DropdownButton(
                                        value: curren_address,
                                        items: _AddressdropDownMenuItems,
                                        onChanged: changedaddressDropDownItem,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Trình độ",style: TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton(
                                      value: curren_education,
                                      items: _EducationdropDownMenuItems,
                                      onChanged: changededucationDropDownItem,
                                    ),
                                  ],
                                ) ,
                              ],
                            ),
                            Row(
                              mainAxisAlignment:  MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Kỹ năng chuyên môn",style: TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton(
                                      value: curren_skill,
                                      items: _SkilldropDownMenuItems,
                                      onChanged: changedskillDropDownItem,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Mức lương",style: TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton(
                                      value: curren_saraly,
                                      items: _saralydropDownMenuItems,
                                      onChanged: changedsaralyDropDownItem,
                                    ),
                                  ],
                                ) ,
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  SingleChildScrollView(
                    child: Container(
                      height: mda_h/1.75,
                      child: _listjobs(),
                      decoration:  BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ):Center(child: Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: SpinKitCircle(
              color: Colors.green,
              size: 50,
            ),
          ),);
        },
      ),
    );

  }
  Widget _listjobs(){
    return
    Padding(
      padding: const EdgeInsets.only(right: 40),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: search?list_search.length:list_all.length,
        scrollDirection: Axis.vertical,
        controller: new ScrollController(),
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context)=>profile(my_acc: false,id:search?
              list_search.elementAt(index).id.toString():list_all.elementAt(index).id.toString())));
            },
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width / 5,
                                    height: MediaQuery.of(context).size.width / 7,
                                    child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:search?( list_search.elementAt(index).avatar.toString()=="null"
                                            ? AssetImage(
                                            'assets/user_null.jpg')
                                            : NetworkImage(
                                            list_search.elementAt(index).avatar.toString()
                                        )):(
                                            list_all.elementAt(index).avatar.toString()=="null"
                                                ? AssetImage(
                                                'assets/user_null.jpg')
                                                : NetworkImage(
                                                list_all.elementAt(index).avatar.toString()
                                            )
                                        ),
                                        backgroundColor: Colors.transparent),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(context, new MaterialPageRoute(builder: (context)=>profile(my_acc: false,id:search?
                                        list_search.elementAt(index).id.toString():list_all.elementAt(index).id.toString())));
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            'Xem hồ sơ',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    30,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      search?list_search.elementAt(index).name:list_all.elementAt(index).name,
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width / 24,
                                          color: Colors.blue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          search?Text(list_search.elementAt(index).gender.toString()=="null"?"Chưa rõ giới tính"
                                              :"Giới tính: "+list_search.elementAt(index).gender.toString())
                                              :Text(list_all.elementAt(index).gender.toString()=="null"?"Chưa rõ giới tính"
                                              :"Giới tính: "+list_all.elementAt(index).gender.toString()),
                                          search?Text(list_search.elementAt(index).tuoi.toString()=="null"?"Chưa rõ năm sinh"
                                              :"Năm sinh: "+tuoi(list_search.elementAt(index).tuoi))
                                              :Text(list_all.elementAt(index).tuoi.toString()=="null"?"Chưa rõ năm sinh"
                                              :"Năm sinh: "+tuoi(list_all.elementAt(index).tuoi)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );;
        },
      ),
    );

  }
}
