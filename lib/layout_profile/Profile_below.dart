import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/layout_profile/Add_edu.dart';
import 'package:find_jobs/layout_profile/Add_exp.dart';
import 'package:find_jobs/layout_profile/Experence_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Education_list.dart';
import 'Tittle_divider.dart';




class Profile_below extends StatefulWidget {
  Profile_below({Key key, this.my_acc,this.data
  }) : super(key: key);
var data;
  final bool my_acc;
  @override
  _Profile_below createState() => _Profile_below();
}

class _Profile_below extends State<Profile_below> {
  show_dialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0),

              ), //this right here
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.green,
                          Colors.blue,
                        ],
                      ),
                    borderRadius:BorderRadius.circular(10),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("THÊM CÔNG TY",
                              style:TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Add_exp()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
  //String mail = sharedPrefs.mail;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  call_api_tinh(String id_tinh)async{

  if(id_tinh=="0"){
    return "chưa cập nhật";
  }
  else{
    Api_findjobs a = new Api_findjobs("/api/states-provinces", {
      "":""
    },);
    var res = await a.getMethod();
    var huyen = await call_api_huyen(id_tinh,  widget.data['data']['user']['addressDistrictId'].toString());
    for(int i = 0 ;i<res['stateProvinces'].length;i++){
      if(res['stateProvinces'][i]['stateProvinceId']==id_tinh){
        return huyen+","+res['stateProvinces'][i]['name']+".";
      }
    }
  }
  }
  call_api_huyen(String id_tinh,String id_huyen)async{

    if(id_huyen=="0"){
      return "chưa cập nhật";
    }
    else{
      Api_findjobs a = new Api_findjobs("/api/districts/get-districts-by-state-province-id", {
        "stateProvinceId":id_tinh
      },);
      var res = await a.postMethod();
      var xa = await call_api_xa(id_tinh, id_huyen, widget.data['data']['user']['addressSubdistrictId'].toString());
      for(int i = 0 ;i<res['districts'].length;i++){
        if(res['districts'][i]['districtId']==id_huyen){
          print(res['districts'][i]['name'].toString());
          return xa+","+res['districts'][i]['name'].toString();
        }
      }
    }
  }
  call_api_xa(String id_tinh,String id_huyen,String id_xa)async{

    if(id_xa=="0"){
      return "chưa cập nhật";
    }
    else{
      Api_findjobs a = new Api_findjobs("/api/subdistricts/get-subdistricts-by-district-id", {
        "districtId":id_huyen
      },);
      var res = await a.postMethod();
      for(int i = 0 ;i<res['subdistricts'].length;i++){
        if(res['subdistricts'][i]['subdistrictId']==id_xa){
          //print(res['districts'][i]['name'].toString());
          return res['subdistricts'][i]['name'].toString();
        }
      }
    }
  }
  Future<void> _makePhoneCall(String contact) async {
    String telScheme = 'tel:$contact';
    if (await canLaunch(telScheme)) {
      await launch(telScheme);
    } else {
      throw 'Không thể gọi  $telScheme';
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
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: mda/1.4,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50))

            ),

            child: Center(
              child: Text("Thông tin liên hệ".toUpperCase(),
                style: TextStyle(
                    fontSize: mda/25,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ),
          //birth

          //place

          //phone
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: GestureDetector(
                    onTap: (){
                      widget.data['data']['user']['phone'].toString()=="null"?
                         showToast("chưa cập nhật", context, Colors.redAccent, Icons.phone)
                          :_makePhoneCall(widget.data['data']['user']['phone'].toString());
                    },
                    child: Image.asset("assets/call.gif",
                    width: 30,
                      height: 30,
                    ),
                  ),
                  // Icon(
                  //   Icons.phone_in_talk,
                  //   color: Colors.lightBlue,
                  //   size: 25.0,
                  // ),
                ),
                Text(widget.data['data']['user']['phone'].toString()=="null"?"chưa cập nhật":widget.data['data']['user']['phone'].toString(),
                  style: TextStyle(
                      fontSize: mda/25
                  ),
                )
              ],
            ),
          ),
          //mail
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(
                    Icons.mail,
                    color: Colors.lightBlue,
                    size: 25.0,
                  ),
                ),
                Text(widget.data['data']['user']['email'].toString()=="null"?"chưa cập nhật":widget.data['data']['user']['email'].toString(),
                  style: TextStyle(
                      fontSize: mda/25
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(
                    Icons.place,
                    color: Colors.lightBlue,
                    size: 25.0,
                  ),
                ),
                FutureBuilder(
                  future: call_api_tinh(widget.data['data']['user']['addressStateProvinceId'].toString()=="null"
                  ?"0":widget.data['data']['user']['addressStateProvinceId'].toString()
                  ),
                  builder: (context,snapshot){

                      return snapshot.hasData?Container(
                      width: mda/1.4,
                      child: Text(snapshot.data,
                        style: TextStyle(
                            fontSize: mda/25
                        ),
                        maxLines: 3,

                      ),
                    ):Text("Đang tải...");
                  }
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,20),
            child: TitleDividerSmall(title: "mục tiêu nghề nghiệp:"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,20),
            child: Container(
                width: mda,
                child: Text(widget.data['data']['user']['careerObjective'].toString()=="null"?"chưa cập nhật"
                    :widget.data['data']['user']['careerObjective'].toString()
                  ,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 15,)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,20),
            child: TitleDividerSmall(title: "mô tả bản thân:"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10,0,10,20),
            child: Container(
                width: mda,
                child: Text(widget.data['data']['user']['resumeSummary'].toString()=="null"?"chưa cập nhật"
                    :widget.data['data']['user']['resumeSummary'].toString()
                  ,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 15,)),
          ),
          Container(
            width: mda/1.4,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50))

            ),

            child: Center(
              child: Text("Kinh nghiệm làm việc".toUpperCase(),
                style: TextStyle(
                    fontSize: mda/25,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ),
          widget.my_acc?Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: (){

            show_dialog();

                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    Text("Thêm mới",
                      style: TextStyle(color: Colors.green),)
                  ],
                ),
              ),
            ],
          ):Container(),
       widget.data['data']['experiences'].length<1?Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text("Chưa cập nhật"),
       ):Experence_list(my_acc: widget.my_acc,data: widget.data,count: widget.data['data']['experiences'].length,),
          // Text("chưa có gì"),
          //experience(exp: widget.exp,),
          Container(
            width: mda/1.4,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50))

            ),

            child: Center(
              child: Text("Học vấn".toUpperCase(),
                style: TextStyle(
                    fontSize: mda/25,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.my_acc?Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: (){

                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 20.0,
                        ),
                        Text("Thêm mới",
                          style: TextStyle(color: Colors.green),)
                      ],
                    ),
                  ),
                ],
              ):Container(),

            ],
          ),
          widget.data['data']['experiences'].length<1?Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Chưa cập nhật"),
          ):Education(my_acc: widget.my_acc,data: widget.data,count: widget.data['data']['education'].length,)
          //Text("chưa có gì"),

        ],
      ),
    );
  }

}