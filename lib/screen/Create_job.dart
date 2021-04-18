import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/item_app/Regulations.dart';
import 'package:find_jobs/model/Option.dart';
import 'package:find_jobs/model_thang/Approved_model.dart';
import 'package:find_jobs/model_thang/Jobsnew_candicate.dart';
import 'package:find_jobs/model_thang/Unapproved_model.dart';
import 'package:find_jobs/model_thang/arr_dropbutton.dart';
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

class Create_job extends StatefulWidget {
  Create_job({Key key, }) : super(key: key);
  @override
  _Create_job createState() => _Create_job();
}

class _Create_job extends State<Create_job> {
  Timer _timer;
  Future _address ;
  String current_tinh="null";
  String current_position = "null";
  String current_huyen="null";
  String current_xa="null";
  String current_typeofwork = "null";
  bool check_mob =false;
  bool check_game =false;
  bool check_web =false;
  bool loading = false;
  String id_xa_selec;
  String language = "Không yêu cầu";
  List<DropdownMenuItem<String>> _positiondropDownMenuItems ;
  List<DropdownMenuItem<String>> _typedropDownMenuItems ;
  List<DropdownMenuItem<String>> _tinhdropDownMenuItems ;
  List<DropdownMenuItem<String>> _huyendropDownMenuItems ;
  List<DropdownMenuItem<String>> _xadropDownMenuItems ;
  TextEditingController company_name = new TextEditingController();
  TextEditingController short_des = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  TextEditingController long_des = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController exp_require = new TextEditingController();
  TextEditingController company_size = new TextEditingController();
  TextEditingController company_phone = new TextEditingController();
  TextEditingController company_email =  new TextEditingController();
  TextEditingController company_website =  new TextEditingController();
  bool ready = true;
  List tinh = [];
  List position = [
    "Thực tập",
    "Mới đi làm",
    "Nhân viên",
    "Quản lý"
  ];
  List huyen = [];
  List xa = [];
  List id_tinh=[];
  List id_huyen=[];
  List id_xa=[];
  List typeofwork = [
    "Full time",
    "Part time",
    "Freelance"
  ];
  String type_of_work(){
    for (int i = 0; i < typeofwork.length; i++) {
      if (typeofwork[i] == current_typeofwork) {
        int a = i+1;
        return "$a";
      }
    }
  }
  String possition(){
    for (int i = 0; i < position.length; i++) {
      if (position[i] == current_position) {
        int a = i+1;
        return "$a";
      }
    }
  }
  List<DropdownMenuItem<String>> getpositionDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in position) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> gettypeofworkDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in typeofwork) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> gettinhDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in tinh) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> gethuyenDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in huyen) {
      items.add(drop(de));
    }
    return items;
  }
  List<DropdownMenuItem<String>> getxaDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in xa) {
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
            style: TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
  call_tinh()async{
    setState(() {
      loading = true;
      tinh.clear();
      id_tinh.clear();
      huyen.clear();
      id_huyen.clear();
      xa.clear();
      id_xa.clear();
    });
    Api_findjobs get_api_tinh = new Api_findjobs("/api/states-provinces", {
      "":""
    },);
    var res = await get_api_tinh.getMethod();
    for(int i = 0 ; i<res['stateProvinces'].length;i++){
      tinh.add(res['stateProvinces'][i]['name']);
      id_tinh.add(res['stateProvinces'][i]['stateProvinceId']);
    }
    setState(() {
      current_tinh = tinh[2].toString();
      _tinhdropDownMenuItems = gettinhDropDownMenuItems();
    });
    call_huyen("01");
    //call_huyen('06');
    return res;
  }
  call_huyen(String idtinh)async{
    setState(() {
      loading = true;
      huyen.clear();
      id_huyen.clear();
      xa.clear();
      id_xa.clear();
    });
    Api_findjobs get_api_huyen = new Api_findjobs("/api/districts/get-districts-by-state-province-id", {
      "stateProvinceId":idtinh
    },);
    var res = await get_api_huyen.postMethod();
    print(res);
    for(int i = 0 ; i<res['districts'].length;i++){
      huyen.add(res['districts'][i]['name']);
      id_huyen.add(res['districts'][i]['districtId']);
    }
    setState(() {
      current_huyen = huyen[0].toString();
      _huyendropDownMenuItems = gethuyenDropDownMenuItems();
      for(int i = 0; i<id_huyen.length;i++){
        if(huyen[i].toString()==current_huyen){
          String id = id_huyen[i];
          call_xa(id);
        }
      };
    });
    // call_xa("7");
    //18
    //7
    return res;
  }
  call_xa(String idxa)async{
    setState(() {
      loading = true;
      xa.clear();
      id_xa.clear();
    });
    Api_findjobs get_api_xa = new Api_findjobs("/api/subdistricts/get-subdistricts-by-district-id", {
      "districtId":idxa
    },);
    var res = await get_api_xa.postMethod();
    print(res);
    for(int i = 0 ; i<res['subdistricts'].length;i++){
      xa.add(res['subdistricts'][i]['name']);
      id_xa.add(res['subdistricts'][i]['subdistrictId']);
    }
    setState(() {
      current_xa = xa[0].toString();
      _xadropDownMenuItems = getxaDropDownMenuItems();
      id_xa_selec = id_xa[0].toString();
      res!=null?loading = false:loading = true;
    });
    //  call_huyen(63);
    //18
    //7
    return res;
  }
  void changedtinhDropDownItem(String selectedCity) {
    loading?null:setState(() {
      current_tinh = selectedCity;
      for(int i = 0; i<id_tinh.length;i++){
        if(tinh[i].toString()==current_tinh){
          String id = id_tinh[i].toString();
          print(id);
          call_huyen(id);
          break;
        }
      };

    });
  }
  void changedhuyenDropDownItem(String selectedCity) {
    loading?print("chon huyen true"):
    setState(() {
      current_huyen = selectedCity;
      for(int i = 0; i<id_huyen.length;i++){
        if(huyen[i].toString()==current_huyen){
          String id = id_huyen[i].toString();
          print(id);
          call_xa(id);
          break;
        }
      };
    }
    );
  }
  void changedxaDropDownItem(String selectedCity) {
    loading?null:setState(() {
      current_xa = selectedCity;
      for(int i = 0; i<id_xa.length;i++){
        if(xa[i].toString()==current_xa){
          String id = id_xa[i].toString();
          id_xa_selec = id;
          print(id);
          break;
        }
      };

    });
  }

  void changedtypeDropDownItem(String selectedCity) {
setState(() {
  current_typeofwork = selectedCity;
});
  }
  void changedpositionDropDownItem(String selectedCity) {
    setState(() {
      current_position = selectedCity;
    });
  }

  show_noiquy(double w, double h){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Regulations(w,h,context);
        });
  }
var checklist=[];
  show_language(){
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context,setState){
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(10),
              ), //this right here
              child: Container(
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
                child:Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:   Container(
                    decoration:  BoxDecoration(
                       // borderRadius: BorderRadius.all(Radius.circular(22.5)),
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white30,
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                controller: new ScrollController(),
                                itemCount: ngonngu2.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                      title: Text(ngonngu2[index]),
                                      value: checklist[index],
                                      onChanged: (vl){
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        setState(() {
                                    if(index==0||index==ngonngu2.length-1){
                                     if(checklist[index]){
                                       checklist[index] = !checklist[index];
                                     }
                                     else{
                                       checklist[index] = !checklist[index];
                                       for(int c = 0; c<ngonngu2.length;c++){
                                         if(c!=index){
                                           checklist[c] = false;
                                         }
                                       }
                                     }
                                    }
                                    else{
                                      if(checklist[0]||checklist[ngonngu2.length-1])
                                        {
                                          checklist[index] = !checklist[index];
                                          checklist[0] = false;
                                          checklist[ngonngu2.length-1] = false;
                                        }
                                      else{
                                        checklist[index] = !checklist[index];
                                      }
                                    }
                                        });

                                      });
                                },
                              ),
                              RaisedButton(
                          color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    String a = "";
                                    language = "";
                              for(int i =0; i < ngonngu2.length;i++){
                                if(checklist[i]){
                                  a += ngonngu2[i]+", ";
                                  language = a.substring(0,a.length-2);
                                }
                              }
                                 print (language);
                                  });
                                  Navigator.pop(context, true);
                                },
                                child: Container(

                                  child: Text(
                                    "Đồng ý",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              ),
            );
          });
        }).then((val){
     setState(() {

     });
    });
  }
 validate(){
    if(company_name.text.length<3||company_name.text.length>100){
      showToast("Tên công ty từ 3-100 ký tự", context, Colors.red, Icons.cancel);
    }
    else if(short_des.text.length<10||short_des.text.length>100){
      showToast("Tên công việc từ 10-100 ký tự", context, Colors.red, Icons.cancel);
    }
    else if(salary.text.length<1){
      showToast("Nhập mức lương", context, Colors.red, Icons.cancel);
    }
    else if(salary.text == double.nan||salary.text.length < 7||salary.text.contains("-")||salary.text.contains(".")){
      showToast("Mức lương tối thiểu 1 triệu vnđ", context, Colors.red, Icons.cancel);
    }
    else if(int.parse(salary.text)>1000000000){
      showToast("Mức lương tối đa 1 tỉ VNĐ", context, Colors.red, Icons.cancel);
    }
else if(long_des.text.length<10||long_des.text.length>1000){
      showToast("Mô tả từ 10-1000 ký tự", context, Colors.red, Icons.cancel);
    }
else if(address.text.length<10||address.text.length>250){
      showToast("Địa chỉ từ 10-250 ký tự", context, Colors.red, Icons.cancel);
    }
else if(exp_require.text.length<1){
      showToast("Nhập số năm kinh nghiệm", context, Colors.red, Icons.cancel);
    }
else if(int.parse(exp_require.text)>100){
      showToast("Kinh nghiệm tối đa 100 năm", context, Colors.red, Icons.cancel);
    }
else if(exp_require.text.contains("-")||exp_require.text.contains(".")){
      showToast("Kinh nghiệm Không hợp lệ", context, Colors.red, Icons.cancel);
    }
else if(check_mob==false&&check_web==false&& check_game == false){
      showToast("Chọn ít nhất 1 lĩnh vực", context, Colors.red, Icons.cancel);
    }
else if(company_size.text.length<1){
      showToast("Nhập quy mô công ty", context, Colors.red, Icons.cancel);
    }
else if(company_size.text == double.nan||company_size.text.contains("-")||company_size.text.contains(".")){
      showToast("Quy mô công ty không hợp lệ", context, Colors.red, Icons.cancel);
    }
else if(company_phone.text.length<10){
      showToast("Số điện thoại ít nhất 10 ký tự", context, Colors.red, Icons.cancel);
    }
    else if(company_phone.text == double.nan||company_phone.text.contains("-")||company_phone.text.contains(".")){
      showToast("Số điện thoại không hợp lệ", context, Colors.red, Icons.cancel);
    }
    else if(company_email.text.length<1){
      showToast("Nhập địa chỉ Email", context, Colors.red, Icons.cancel);
    }
    else if(company_email.text.length < 1||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(company_email.text)){
      showToast("Email không hợp lệ", context, Colors.red, Icons.cancel);
    }
    else if(company_website.text.length<1){
      showToast("Nhập website", context, Colors.red, Icons.cancel);
    }
    else if(!RegExp(r"(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?").hasMatch(company_website.text)){
      showToast("Website Không hợp lệ", context, Colors.red, Icons.cancel);
    }
    else {
      call_create();
    }

 }
 call_create() async {
    setState(() {
      ready = false;
    });
    Api_findjobs api_create = new Api_findjobs("/api/job-news/create", {
      "userId":sharedPrefs.user_id,
      "companyName":company_name.text,
      "jobShortDescription":short_des.text,
      "salaryInVnd":salary.text.toString(),
      "jobDescription":long_des.text,
      "addressSubdistrictId":id_xa_selec,
      "typeOfWorkId":type_of_work(),
      "requiredNumberYearsOfExperiences":exp_require.text.toString(),
      "detailAddress":address.text,
      "jobTitleId":possition(),
      "companySizeByNumberEmployees":company_size.text.toString(),
      "companyWebsite":company_website.text,
      "companyEmail":company_email.text,
      "companyPhoneNumber":company_phone.text,
      "requiredTechnologyText":language
    });

    var res_create = await api_create.postMethod();
    if(!res_create['result']){
      setState(() {
        ready = true;
      });
      showToast("Chỉ được đăng tối đa 5 tin", context, Colors.yellow.shade700, Icons.warning);
    }
    else if(res_create['result']){
call_edit(res_create['jobNewsId'].toString());
      showToast("Chờ phê duyệt", context, Colors.green, Icons.check);
    }

 }
  call_edit(String id_jobs) async {
    setState(() {
      ready = false;
    });
    String url2 = "https://find-job-app.herokuapp.com/api/job-news-required-skills/set-job-news-required-job-skills";
    String skill1=check_mob?'1,':"";
    String skill2=check_game?'2,':"";
    String skill3=check_web?'3,':"";
    String arrskill= skill1+skill2+skill3;
    String sub = arrskill.substring(0,arrskill.length>1?arrskill.length-1:0);
    String json ='{"jobNewsId":"$id_jobs","jobSkillIdArr":['+sub+']}';
    Map pr = {"requestDataJsonString":"$json"};
    Response response = await post(url2, body: pr);
    print(jsonDecode(response.body));
    Navigator.of(context).pop();
    setState(() {
      ready= true;
    });
  }
  @override
  void initState() {
    for(int i = 0;i < ngonngu.length;i++){
      checklist.add(false);
    }
    company_website.text = "https://www.";
    _address = call_tinh();
    current_position = position[0];
    current_typeofwork = typeofwork[0];
    _positiondropDownMenuItems = getpositionDropDownMenuItems();
    _typedropDownMenuItems = gettypeofworkDropDownMenuItems();
    _timer = new Timer(const Duration(milliseconds: 1500), () {
      show_noiquy(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double mda_h = MediaQuery.of(context).size.height;
    double mda = MediaQuery.of(context).size.width;
   // show_noiquy(mda, mda_h);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.new_releases_rounded,size: 30,color: Colors.yellow,),
            onPressed: () {
             show_noiquy(mda, mda_h);
            },
          )
        ],
        backgroundColor: Colors.green,
        title: Text("Đăng tin tuyển dụng"),
      ),
      body:  SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                      //==============ten cong ty
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tên công ty",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: company_name,
                        maxLength: 100,
                        decoration: InputDecoration(
                            fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ :Find jobs',
                        ),
                      ),
                      //========================= ten cong viec
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tên công việc",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: short_des,
                        maxLength: 100,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ : Lập trình android',
                        ),
                      ),
                      //=========vị trí
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Vị trí ứng tuyển",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,10,0),
                        child: DropdownButton(
                          value: current_position,
                          items: _positiondropDownMenuItems,
                          onChanged: changedpositionDropDownItem,
                        ),
                      ),
                      //=======================muc lương
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Mức lương (VNĐ)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: salary,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ : 1000000',
                        ),
                      ),
                      //========================ngôn ngữ
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Ngôn ngữ yêu cầu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: mda/1.75,
                                child: Text(language,style: TextStyle(fontSize: mda/24),
                                overflow:  TextOverflow.ellipsis,
                                )),
                          ),
                          RaisedButton(
                            onPressed: () {
                              ready?show_language():null;
                            },
                            child: Text(
                              "Chọn",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                            color:ready?Colors.orange:Colors.grey,
                          ),
                        ],
                      ),
                      //===========================mo ta
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Mô tả cụ thể công việc",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: long_des,
                        maxLength: 1000,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ : Lập trình, bảo trì hệ thống...',
                        ),
                      ),
                      //=====================địa chỉ
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("ĐỊA CHỈ",
                              style: TextStyle(
                                  fontSize: mda / 21,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Tỉnh/TP :",style:TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Quận/Huyện :",style:TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Xã/Phường :",style:TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                              FutureBuilder(
                                future: _address,
                                builder:  (context,snapshot){
                                  return snapshot.hasData ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      DropdownButton(
                                        value: current_tinh,
                                        items: _tinhdropDownMenuItems,
                                        onChanged: changedtinhDropDownItem,
                                      ),
                                      DropdownButton(
                                        value: current_huyen,
                                        items: _huyendropDownMenuItems,
                                        onChanged: changedhuyenDropDownItem,
                                      ),
                                      DropdownButton(
                                        value: current_xa,
                                        items: _xadropDownMenuItems,
                                        onChanged: changedxaDropDownItem,
                                      ),
                                    ],
                                  ):Center(child: CircularProgressIndicator());
                                },
                              ),

                            ],
                          )
                        ],
                      ),
                      //==============địa chỉ cụ thể
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Địa chỉ cụ thể",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        maxLength: 250,
                        controller: address,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Điền chỉ cụ thể',
                        ),
                      ),
                      //=============thời gian
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Thời gian làm việc",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      DropdownButton(
                        value: current_typeofwork,
                        items: _typedropDownMenuItems,
                        onChanged: changedtypeDropDownItem,
                      ),
                      //================yêu cầu kinh ngiệm
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Yêu cầu kinh nghiệm (năm)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: exp_require,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ : 1 ',
                        ),
                      ),
                      //===================skill
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lĩnh vực",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text("Mobile")
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
                              Text("Web")
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
                              Text("Game")
                            ],
                          ),
                        ],
                      ),
                      //================quy mô
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Quy mô công ty (số lượng nhân viên)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: company_size,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ : 100 ',
                        ),
                      ),
                      //================số điện thoại
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Số điện thoại",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        maxLength: 12,
                        controller: company_phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'Ví dụ : 0123456789 ',
                        ),
                      ),
                      //===========mail
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Địa chỉ Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: company_email,
                        maxLength: 100,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'findjobs@abc.com',
                        ),
                      ),
                      //===========website
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Website",style: TextStyle(fontWeight: FontWeight.bold,fontSize: mda/24),),
                      ),
                      TextField(
                        autofocus: false,
                        controller: company_website,
                        maxLength: 100,
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                          hintText: 'https://www.findjos.com',
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                            ready?validate():null;
                        },
                        child: Container(
                          width: mda/4,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.post_add,color: Colors.white,),
                              ),
                              Text(
                                ready?"Đăng tin ":"Đăng tin ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        color:ready?Colors.green:Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

}
