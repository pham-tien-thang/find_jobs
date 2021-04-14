import 'dart:io';
import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/item_app/BottomNavigation.dart';
import 'package:find_jobs/item_app/Buttton_pair.dart';
import 'package:find_jobs/layout_profile/Profile_above.dart';
import 'package:find_jobs/layout_profile/Profile_below.dart';
import 'package:find_jobs/layout_profile/Update_profile.dart';
import 'package:find_jobs/model/Option.dart';
import 'package:find_jobs/screen/Change_password.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:find_jobs/screen/LoginScreen.dart';
import 'package:find_jobs/screen/Recruitment.dart';
import 'package:find_jobs/screen/Search_keywword.dart';
import 'package:find_jobs/screen/my_apply_job/my_apply_jobs_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class profile extends StatefulWidget {
  profile({Key key,this.my_acc,this.id}) : super(key: key);
  final bool my_acc;
  String id;
  @override
  _profile createState() => _profile();
}

class _profile extends State<profile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //user_Infomation user_infomationn = new user_Infomation();
  int type;
  int solan =0;
  bool scr = false;
  ScrollController scrollControllers = new ScrollController();
  bool _isVisible = true;
  bool h = false;
  String contact;
  Future _detail;
  String candicate='';
  String mail_candicate;
  DateTime now = new DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String birth(String b){
    var dateConvert = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(b) );
    String t = formatter.format(dateConvert);
    return t;
  }
  call_api_detail()async{
    String ten;  String gioitinh;  String luong;  String time;  String bangcap;  String year_exp;  String mota;
    String ngaysinh;  String diachi;  String phone;  String mail;  String muctieu=""; String kynang="";

    Api_findjobs a = new Api_findjobs(widget.my_acc?"/api/users/details-get-id":"/api/users/details-get-id", {
      //'userId': ,
      'userId': widget.my_acc?sharedPrefs.user_id.toString():widget.id,
    },);
var res = await a.postMethod();
    print(res);
    var ungvien = res['data']['user'];
print(res['data']['jobSkills'].toString());
   // =========================
    if( res['data']['jobSkills'].length>0){
   for(int i= 0;i< res['data']['jobSkills'].length ;i++){
     if(res['data']['jobSkills'].length<=1||i ==res['data']['jobSkills'].length-1 ){
       kynang +=res['data']['jobSkills'][i]['skillName'].toString()+".";
     }
     else
     {
       kynang += res['data']['jobSkills'][i]['skillName'].toString()+", ";
     }
   }
    }
    else{

        kynang = "chưa có";

    }

ten = res['data']['user']['fullName'].toString()=="null"?"chưa có":res['data']['user']['fullName'].toString();
gioitinh = res['data']['user']['gender'].toString()=="null"?"chưa có":res['data']['user']['gender'].toString();
luong = res['data']['user']['expectedSalaryInVnd'].toString()=="null"?"chưa có":res['data']['user']['expectedSalaryInVnd'].toString();
time = res['data']['user']['typeOfWork'].toString()=="null"?"chưa có":res['data']['user']['typeOfWork'].toString();
bangcap = res['data']['user']['graduatedEducation'].toString()=="null"?"chưa có": res['data']['user']['graduatedEducation'].toString();
year_exp = res['data']['user']['yearsOfExperiences'].toString()=="null"?"chưa có":res['data']['user']['yearsOfExperiences'].toString();
mota = res['data']['user']['resumeSummary'].toString()=="null"?"chưa có":res['data']['user']['resumeSummary'].toString();
diachi = res['data']['user']['stateProvinceName'].toString()=="null"?"chưa có":res['data']['user']['stateProvinceName']+", "+res['data']['user']['districtName']+", "+res['data']['user']['subdistrictName'];
phone = res['data']['user']['phone'].toString()=="null"?"chưa có":res['data']['user']['phone'].toString();
mail = res['data']['user']['email'].toString()=="null"?"chưa có":res['data']['user']['email'].toString();
mail_candicate = res['data']['user']['email'].toString()=="null"?"chưa có":res['data']['user']['email'].toString();
muctieu = res['data']['user']['careerObjective'].toString()!="null"?"chưa có":res['data']['user']['careerObjective'].toString();
ngaysinh = res['data']['user']['birthdayInMilliseconds'].toString()=="null"?"chưa có":birth(res['data']['user']['birthdayInMilliseconds'].toString());
candicate = "Họ và tên: "+ten+"\n"
    "Giới tính: "+gioitinh+"\n"
    "Ngày sinh: "+ngaysinh+"\n"
    "Mức lương: "+luong+"\n"
    "Bằng cấp: "+bangcap+"\n"
    "Số năm kinh nghiệm: "+year_exp+"\n"
    "Mô tả: "+mota+"\n"
    "Địa chỉ: "+diachi+"\n"
    "Số điện thoại: "+phone+"\n"
    "Email: "+mail+"\n"
    "Kỹ năng: "+kynang
;

    return res;
  }
  Future<void> _refresh() async {
    _detail = call_api_detail();
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    if (scrollControllers.offset > 40&& !h) {
      setState(() {
        h = true;
      //  print(scrollControllers.offset.toString()+"hien len============="); // scr=true;
      });
    } else if (scrollControllers.offset <= 10&& h) {
      setState(() {
        h = false;
        //print(scrollControllers.offset.toString()+"khong hien len============="); // sc
      });
    }

  }

  @override
  void initState() {
    _detail = call_api_detail();
    scrollControllers.addListener(() {
      if (scrollControllers.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if(_isVisible)
          setState(() {
            _isVisible = false;
            print("**** $_isVisible up");
          });
      }
      if (scrollControllers.position.userScrollDirection ==
          ScrollDirection.forward) {
        if(!_isVisible)
          setState(() {
            _isVisible = true;
            print("**** $_isVisible down");
          });
      }
    });
    print('innit');
  }

  ontapbottom (int index){
    setState(() {
      if (index == 0) {

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
      }
      if (index == 2) {
        widget.my_acc?null:Navigator.push(
            context, new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
      }
      if (index == 1) {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Search_keywword()));
      }
    });
  }
  void Action(String choice){
    if(choice == Option.doi_mat_khau){
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Change_password() ));
    }
    else if(choice == Option.dang_xuat){
      removeValues();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
    }
    else if(choice == Option.dang_tin){
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Recruitment() ));

    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApplyJobsPage()));
    }
  }
  void sendmail(String s) async{
 if(s=="Lưu hồ sơ"){
   var receiver = sharedPrefs.email;
   final Email email = Email(
     body: candicate,
     subject: 'Cv ứng viên',
     recipients: [receiver],
     isHTML: false,
   );
   print('da tao 1 mail');
   await FlutterEmailSender.send(email);
 }else{
   final Email email = Email(
     body: "Nhập nội dung...",
     subject: 'Tuyển dụng',
     recipients: [mail_candicate],
     isHTML: false,
   );
   print('da tao 1 mail');
   await FlutterEmailSender.send(email);
 }
  }
  @override
  Widget build(BuildContext context) {
    sharedPrefs.init();
_detail = call_api_detail();
    print("A");
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: ButtonPair( s: scrollControllers,
        h: h,
      ),
      key: _scaffoldKey,
      bottomNavigationBar: Visibility(
          visible: _isVisible,
          child: BottomNavigationcustom(selectedIndex: widget.my_acc?2:2,tap: ontapbottom,)),
      // appBar: AppBar(
      //     title: Text('Tài khoản'),
      //     actions: <Widget>[
      //       PopupMenuButton<String>(
      //         onSelected: Action,
      //         itemBuilder: (BuildContext context){
      //           return sharedPrefs.check?Option.choices.map((String choice){
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Row(
      //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Container(
      //                       margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //                       child: Text(choice)
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }).toList():
      //           Option.choices2.map((String choice){
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Row(
      //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Container(
      //                       margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //                       child: Text(choice)
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }).toList();
      //         },
      //       )
      //     ]
      // ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) =>
          //         MyApp()), (Route<dynamic> route) => false);
        },
        child: FutureBuilder(
            future: _detail,
            builder: (context, snapshot){
              return  snapshot.hasData?
              NestedScrollView(
                controller: scrollControllers,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: widget.my_acc?<Widget>[
                        PopupMenuButton<String>(
                          onSelected: Action,
                          itemBuilder: (BuildContext context){
                            return Option.choices.map((String choice){
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(choice)
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        )
                      ]:<Widget>[
                        PopupMenuButton<String>(
                          onSelected: sendmail,
                          itemBuilder: (BuildContext context){
                            return Option.sender_mail.map((String choice){
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(choice)
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        )
                      ],
                      expandedHeight: 176.0,
                      floating: true,
                      pinned: true,
                      snap: false,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        // print('constraints=' + constraints.toString());
                        var top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          title: Text(top <= 100 ? snapshot.data['data']['user']['fullName'].toString() : ""),
                          background:
                          Stack(alignment: Alignment(-0.9, 0.9), children: [
                            Stack(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: top*1.5,
                                    child: snapshot.data['data']['user']['avatarUrl'].toString()=="null"?Image.asset(
                                      'assets/bg_null.jpg',
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment.topLeft,
                                    ):Image.network(snapshot.data['data']['user']['avatarUrl'].toString(),
                                        fit:BoxFit.cover
                                    )
                                ),
                                GestureDetector(
                                  onTap: (){
                                    // showToast("Xin chào "+user_infomationn.pro.full_name.toString(), context, Colors.amber, Icons.favorite);
                                  },
                                  onDoubleTap: (){
                                    // showToast("Xin chào "+user_infomationn.pro.full_name.toString()+" 😁", context, Colors.amber, Icons.favorite);
                                  },
                                  child: Container(
                                    // height: mda/14,
                                    width: mda,
                                    //
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius:BorderRadius.only(
                                          bottomLeft:Radius.circular(top/1.75),
                                          //  bottomRight: Radius.circular(top/1.5),
                                        )
                                      // ),
                                      //only(bottomLeft: Radius.circular(mda/1),bottomRight: Radius.circular(mda/1)),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      widget.my_acc?Navigator.pushReplacement(context,
                                          new MaterialPageRoute(builder: (context) => Update_profile(data: snapshot.data,
                                          ))):null;
                                    },
                                    child: snapshot.data['data']['user']['avatarUrl'].toString()=="null"?Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                            radius: mda/12,
                                            backgroundImage: AssetImage('assets/user_null.jpg'),
                                          ),
                                        ),
                                        widget.my_acc?Container(
                                          height: mda/14,
                                          width: mda/14,
                                          //
                                          decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(mda)
                                            //only(bottomLeft: Radius.circular(mda/1),bottomRight: Radius.circular(mda/1)),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: mda/25,
                                          ),
                                        ):Container(
                                          width: 1,
                                          height: 1,
                                        ),
                                      ],
                                    ):Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 15.0,
                                                  offset: Offset(0.0, 1)
                                              )
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: mda/12,
                                            backgroundImage: NetworkImage(snapshot.data['data']['user']['avatarUrl'].toString(),),
                                          ),
                                        ),
                                        Container(

                                          height: mda/14,
                                          width: mda/14,
                                          //
                                          decoration: BoxDecoration(

                                              color: Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(mda)
                                            //only(bottomLeft: Radius.circular(mda/1),bottomRight: Radius.circular(mda/1)),
                                          ),
                                          child:    Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: mda/25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                                    child: Container(
                                      width: mda/1.5,
                                      child: Text(snapshot.data['data']['user']['fullName'].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: mda/20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          // backgroundColor: Colors.black87.withOpacity(0.5)
                                        ),
                                      ),
                                    ),
                                  )
                                ],

                              ),
                            ),
                          ]),
                        );
                      }),
                    ),
                  ];
                },
                body: RefreshIndicator(
                  onRefresh: _refresh,
                  child: NotificationListener <ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification) {
                        _onUpdateScroll(scrollNotification.metrics);
                      }
                    },
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                          Profile_above(data: snapshot.data,my_acc: widget.my_acc,),
                            Profile_below(data: snapshot.data,my_acc:widget.my_acc ,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  :Center(child: SpinKitCircle(
                color: Colors.green,
                size: 50,
              ));
            }
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
