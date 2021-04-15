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
import 'package:find_jobs/model_thang/arr_dropbutton.dart';
import 'package:find_jobs/model_thang/job_new_model.dart';
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

class Search_jobs extends StatefulWidget {
  Search_jobs({Key key,this.type }) : super(key: key);
  int type;

  @override
  _Search_jobs createState() => _Search_jobs();
}

class _Search_jobs extends State<Search_jobs> {
  List<DropdownMenuItem<String>> _AddressdropDownMenuItems ;
  List<DropdownMenuItem<String>> _positiondropDownMenuItems ;
  List<DropdownMenuItem<String>> _timedropDownMenuItems ;
  List<DropdownMenuItem<String>> _saralydropDownMenuItems ;
  List<DropdownMenuItem<String>> _huyendropDownMenuItems ;
  List<DropdownMenuItem<String>> _ngonngudropDownMenuItems ;
  String curren_address;
  String curren_position;
  String curren_huyen;
  String curren_time;
  String curren_saraly;
  String curren_language;
  Future _all;
  bool search = false;
  bool load= false;
  List<Job_mew_model> list_all=[];
  List<Job_mew_model> list_search=[];
  List<Job_mew_model> list_hienthi=[];
  List address = [
  ];
  List id_tinh = [];
  List huyen = [];
  List position = [
    "Tất cả",
    "Thực tập",
    "Mới đi làm",
    "Nhân viên",
    "Quản lý"
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
  List type_of_w = [
    "Tất cả",
    "Full-time",
    "Part-time",
    "Freelance",
  ];
  List<DropdownMenuItem<String>> gethuyenDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in huyen) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> getngonnguDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in ngonngu) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> getaddressDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in address) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> getpositionDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in position) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> gettimeDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in type_of_w) {
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
            style: TextStyle(fontSize: 12,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
String f(){
  if(widget.type==1){
    return "Lập trình di động";
  }
  else if(widget.type==2){
    return "Lập trình game";
  }
  else if(widget.type==3){
    return "Lập trình Web";
  }
}
  String type(){
   if(widget.type==1){
     return "Mobile";
   }
   else if(widget.type==2){
     return "Game";
   }
   else if(widget.type==3){
     return "Web";
   }
 }
 call_all()async{
    Api_findjobs getall = new Api_findjobs("/api/job-news/approved-job-news", {
      "":""
    });
    var res_tinh = await call_tinh();
if(res_tinh['result']){
var res_all = await getall.getMethod();
if(res_all['result']){
  //check null
 if(res_all['jobNewsArr'].length>0){
   //add model
   print("chạy addmodel");

 list_all.clear();
   for( int i = 0 ;i<res_all['jobNewsArr'].length;i++){
   List <Skill_jobs> list_skill=[];
//check skill
   if(res_all['jobNewsArr'][i]['requiredSkills'].length>0){
     list_skill.clear();
     //add_skill
    for(int c = 0 ;c<res_all['jobNewsArr'][i]['requiredSkills'].length;c++){

      if(res_all['jobNewsArr'][i]['requiredSkills'][c]['skillName'].toString().contains(f())){
        Skill_jobs s = new Skill_jobs(name: res_all['jobNewsArr'][i]['requiredSkills'][c]['skillName']);
        list_skill.add(s);
        print(list_skill.length.toString()+"length skill");
      }

    }
     print("co skill");
   }
   else{
     print("null skill");
   }

if(list_skill.length>0){

  Job_mew_model j = new Job_mew_model(res_all['jobNewsArr'][i]['companyName'],
    res_all['jobNewsArr'][i]['jobShortDescription'],
    res_all['jobNewsArr'][i]['jobNewsId'] as int,
    res_all['jobNewsArr'][i]['stateProvinceName'],
    res_all['jobNewsArr'][i]['jobTitleName'],
  res_all['jobNewsArr'][i]['salaryInVnd'].toString(),
    res_all['jobNewsArr'][i]['typeOfWorkName'],
    res_all['jobNewsArr'][i]['districtName'].toString(),
    list_skill,
  );
  list_all.add(j);
  print(list_all.length.toString()+"cong viec"+f());
}
else {
  print("không phai"+f());
}

   }
   print(res_all);
   return res_all;
 }
 print("null");
 return 1;
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
 call_huyen(String idtinh)async{

    setState(() {
      load = true;
      huyen.clear();
      huyen.add("Tất cả");
    });
    Api_findjobs get_api_huyen = new Api_findjobs("/api/districts/get-districts-by-state-province-id", {
      "stateProvinceId":idtinh
    },);
    var res = await get_api_huyen.postMethod();
    for(int i = 0 ; i<res['districts'].length;i++){
      huyen.add(res['districts'][i]['name']);
    }
    setState(() {
      curren_huyen = huyen[0];
      _huyendropDownMenuItems = gethuyenDropDownMenuItems();
      load = false;
    });
 }
  call_tinh()async{
    setState(() {
      address.clear();
      id_tinh.clear();
    });
    Api_findjobs get_api_tinh = new Api_findjobs("/api/states-provinces", {
      "":""
    },);
    var res = await get_api_tinh.getMethod();
    address.add("Tất cả địa chỉ");
    huyen.add("Tất cả");
    for(int i = 0 ; i<res['stateProvinces'].length;i++){
      address.add(res['stateProvinces'][i]['name']);
      id_tinh.add(res['stateProvinces'][i]['stateProvinceId']);
    }
    setState(() {
      curren_huyen = huyen[0];
      curren_address = address[0];
      _AddressdropDownMenuItems = getaddressDropDownMenuItems();
      _huyendropDownMenuItems = gethuyenDropDownMenuItems();
    });
    return res;
  }
  void changedaddressDropDownItem(String selectedCity) {
if(!load){
  setState(() {
    curren_address = selectedCity;
  });
  if(curren_address != "Tất cả địa chỉ"){
    huyen.clear();
    for(int i = 0; i < address.length ;i++){

      if(curren_address == address[i]){
        print(id_tinh[i-1].toString()+address[i]);
        call_huyen(id_tinh[i-1].toString());
        break;
      }
    }
//  call_huyen(idtinh)
  }
  else{
    setState(() {
      huyen.clear();
      huyen.add("Tất cả");
      curren_huyen = huyen[0];
      _huyendropDownMenuItems = gethuyenDropDownMenuItems();
    });
  }
  call_search();
}
else{
  showToast("Đang làm mới huyện", context, Colors.orange, Icons.replay_circle_filled);
}
  }
  void changedpositionDropDownItem(String selectedCity) {
    setState(() {
curren_position = selectedCity;
    });
    call_search();
  }
  void changedhuyenDropDownItem(String selectedCity) {
   if(!load){
     setState(() {
       curren_huyen = selectedCity;
     });
     call_search();
   }
   else{
     showToast("Đang làm mới huyện", context, Colors.orange, Icons.replay_circle_filled);
   }
  }
  void changedngonnguDropDownItem(String selectedCity) {
  setState(() {
    curren_language = selectedCity;
  });
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
  void changedtimeDropDownItem(String selectedCity) {
    setState(() {
curren_time  = selectedCity;
    });
    call_search();
  }
  call_search(){
    setState(() {
      search = true;
      list_search.clear();
    });
    for(int i = 0 ; i< list_all.length;i++){
      print(i);
      if(
      (curren_address=="Tất cả địa chỉ"?true:list_all.elementAt(i).address == curren_address)&&
           (curren_huyen=="Tất cả"?true:list_all.elementAt(i).huyen == curren_huyen)&&
          (curren_position=="Tất cả"?true:list_all.elementAt(i).position == curren_position)&&
          ( curren_time=="Tất cả"?true:list_all.elementAt(i).time == curren_time)&&
   (int.parse(list_all.elementAt(i).saraly)<=curren_saraly_model.max&&int.parse(list_all.elementAt(i).saraly)>=curren_saraly_model.min)
      ){
        list_search.add(list_all[i]);
      }
      else{
       // print(list_all.elementAt(i).time);
      }
    }
    print("có"+list_search.length.toString()+"kết quả");
  }
  settext(){
    setState(() {
      curren_language = ngonngu[0];
      curren_saraly_model= list_luong[0];
      curren_saraly = luong[0];
      curren_time = type_of_w[0];
      curren_position = position[0];
    });
_ngonngudropDownMenuItems = getngonnguDropDownMenuItems();
    _saralydropDownMenuItems = getsaralyDropDownMenuItems();
    _timedropDownMenuItems = gettimeDropDownMenuItems();
    _positiondropDownMenuItems = getpositionDropDownMenuItems();
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
        title: Text("Lập trình "+type()),
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
                                    Text("Tỉnh/TP",style: TextStyle(fontWeight: FontWeight.bold),),
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
                                    Text("Quận/huyện",style: TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton(
                                      value: curren_huyen,
                                      items: _huyendropDownMenuItems,
                                      onChanged: changedhuyenDropDownItem,
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
                                    Text("Thời gian",style: TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton(
                                      value: curren_time,
                                      items: _timedropDownMenuItems,
                                      onChanged: changedtimeDropDownItem,
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
                            ),
                            Row(
                              mainAxisAlignment:  MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Ngôn ngữ",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Center(
                                      child: DropdownButton(
                                        value: curren_language,
                                        items: _ngonngudropDownMenuItems,
                                        onChanged: changedngonnguDropDownItem,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Chức vụ",style: TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton(
                                      value: curren_position,
                                      items: _positiondropDownMenuItems,
                                      onChanged: changedpositionDropDownItem,
                                    ),
                                  ],
                                ) ,
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  SingleChildScrollView(
                    child: Container(
                      height: mda_h/1.5,
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: search?list_search.length:list_all.length,
        scrollDirection: Axis.vertical,
        controller: new ScrollController(),
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context)=>JobDetailPage(id: search?list_search.elementAt(index).id:list_all.elementAt(index).id)));
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
                              width: MediaQuery.of(context).size.width / 4.5,
                              child: Container(
                                  height: MediaQuery.of(context).size.width / 5,
                                  width:MediaQuery.of(context).size.width / 5 ,
                                  child: Image.asset("assets/jobs_item.png")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      search?list_search.elementAt(index).company_name.toUpperCase():list_all.elementAt(index).company_name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width / 20,
                                          color: Colors.blue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(search?"CÔNG VIỆC: "+list_search.elementAt(index).title:"CÔNG VIỆC: "+list_all.elementAt(index).title),
                                          Text(search?"MỨC LƯƠNG: "+_saraly(list_search.elementAt(index).saraly).toString():"MỨC LƯƠNG: "+_saraly(list_all.elementAt(index).saraly).toString())
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
