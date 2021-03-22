import 'dart:io';

import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/layout_profile/Tittle_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';




class Profile_above extends StatefulWidget {

  Profile_above({Key key,this.data
    ,this.my_acc
  }) : super(key: key);
   var data;
   final bool my_acc;
  @override
  _Profile_above createState() => _Profile_above();
}

class _Profile_above extends State<Profile_above> {
  final formatter = new NumberFormat("#,###");
  //String mail = sharedPrefs.mail;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
String birthday(String fromdata){
  DateTime now = new DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  var dateConvert = new DateTime.fromMillisecondsSinceEpoch(
      int.parse(fromdata) );
  String t = formatter.format(dateConvert);
  return t;
}
  String gender(String fromdata){
    if(fromdata=="1"){
      return"nam";
    }
   if(fromdata=="0"){
     return "nữ";
   }
   else return"không xác định";
  }
  String typeofwork(String fromdata){
    if(fromdata=="1"){
      return"Full time";
    }
    if(fromdata=="2"){
      return "Part time";
    }
    if(fromdata=="3"){
      return "Free lance";
    }
    else return"Không rõ";
  }
  String graduate(String fromdata){
    if(fromdata=="1"){
      return"Không rõ";
    }
    if(fromdata=="2"){
      return "Trên đại học";
    }
    if(fromdata=="3"){
      return "Đại học";
    }
    if(fromdata=="4"){
      return "Cao đẳng";
    }
    else return"Không rõ";
  }
  String skill(var fromdata){
  String t = "";
 for(int i=0; i <fromdata.length;i++){
   if(fromdata.length<=1||i ==fromdata.length-1 ){
     t+=fromdata[i]['skillName'].toString()+".";
   }
   else
   {
     t += fromdata[i]['skillName'].toString()+",";
   }
 }
 return t ;
  }
  @override
  Widget build(BuildContext context) {
    sharedPrefs.init();
    double mda = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),

            ),
            Container(
              width: mda/1.4,
              height: 50,
              decoration: BoxDecoration(
            color: Colors.blue,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50))

              ),

              child: Center(
                child: Text("HỒ SƠ CÁ NHÂN",
                  style: TextStyle(
                      fontSize: mda/25,
                      fontWeight: FontWeight.bold
                  ),),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Họ và tên:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['fullName'].toString()=="null"
                      ?"chưa cập nhật"
                        :widget.data['data']['user']['fullName'].toString()
                      ,style: TextStyle(
                      fontSize: mda/25,
                    ),),
                  ],
                ),
              )

            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.cake,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ngày sinh:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['birthdayInMilliseconds'].toString()=="null"
                      ?"chưa cập nhật"
                        :birthday(widget.data['data']['user']['birthdayInMilliseconds'].toString())
                      ,style: TextStyle(
                      fontSize: mda/25,
                    ),),
                  ],
                ),
              )

            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.accessibility_rounded,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Giới tính:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['genderId'].toString()=="null"?
                      "chưa cập nhật":gender(widget.data['data']['user']['genderId'].toString()),style: TextStyle(
                      fontSize: mda/25,
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mức lương mong muốn:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['expectedSalaryInVnd'].toString()=="null"
                      ? "chưa cập nhật"
                        :formatter.format(widget.data['data']['user']['expectedSalaryInVnd'])+" VNĐ"
                      ,style: TextStyle(
                      fontSize: mda/25,
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.insert_invitation,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Loại hình công việc:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['typeOfWorkId'].toString()=="null"?
                        "chưa cập nhật"
                      :typeofwork(widget.data['data']['user']['typeOfWorkId'].toString())
                      ,style: TextStyle(
                      fontSize: mda/25,
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.school,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trình độ học vấn:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['graduatedEducationId'].toString()=="null"?"chưa cập nhật"
                      :graduate(widget.data['data']['user']['graduatedEducationId'].toString()),style: TextStyle(
                      fontSize: mda/25,
                    ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Số năm kinh nghiệm:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(widget.data['data']['user']['yearsOfExperiences'].toString()=="null"?"chưa cập nhật"
                        :widget.data['data']['user']['yearsOfExperiences'].toString()+" Năm",
                      style: TextStyle(
                        fontSize: mda/25,
                      ),),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Row(
            children: [
              Icon(
                Icons.android,
                color: Colors.lightBlue,
                size: mda/12,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kỹ năng chuyên môn:" ,style: TextStyle(
                        fontSize: mda/25,
                        fontWeight: FontWeight.bold
                    ),),
                    Container(
                      width: mda/1.5,
                      child: Text(widget.data['data']['jobSkills'].length==0?"chưa cập nhật"
                          :skill(widget.data['data']['jobSkills']),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: mda/25,
                        ),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),


        //1
        //2
        //3
      ],
    );
  }

}
