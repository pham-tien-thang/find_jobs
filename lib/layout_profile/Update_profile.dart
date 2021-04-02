import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/layout_profile/Profile_below.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class Update_profile extends StatefulWidget {
  Update_profile({Key key, this.avatar,this.data}) : super(key: key);
  String avatar;
  var data;

  @override
  _Update_profile createState() => _Update_profile();
}

class _Update_profile extends State<Update_profile> {
  //================khai bao
   TextEditingController B_date = new TextEditingController();
  // bool kinnghiem = false;
  File _image;
   final f = new DateFormat('MM-dd-yyyy');
  // ScrollController scrollController = new ScrollController();
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // String auth = sharedPrefs.auth;
  // int id = sharedPrefs.user_id;
   TextEditingController name_us = new TextEditingController();
   TextEditingController mail_us = new TextEditingController();
  TextEditingController phone_us = new TextEditingController();
  TextEditingController address_us = new TextEditingController();
  TextEditingController salary_us = new TextEditingController();
  TextEditingController exp_us = new TextEditingController();
  TextEditingController description_us = new TextEditingController();
  TextEditingController work_need_us = new TextEditingController();
   TextEditingController careerObjective =  new TextEditingController();
   List<DropdownMenuItem<String>> _genderdropDownMenuItems ;
   List<DropdownMenuItem<String>> _tinhdropDownMenuItems ;
   List<DropdownMenuItem<String>> _huyendropDownMenuItems ;
   List<DropdownMenuItem<String>> _xadropDownMenuItems ;
   List<DropdownMenuItem<String>> _degreedropDownMenuItems ;
   List<DropdownMenuItem<String>> _typedropDownMenuItems ;
  String current_gender;
   String current_tinh;
   String current_huyen="null";
   String current_xa="null";
   String current_degree;
   String current_typeofwork;
   String id_xa_selec;
   Future f_tinh;
   List tinh = [];
   List huyen = [];
   List xa = [];
   List id_tinh=[];
   List id_huyen=[];
   List id_xa=[];
   bool loading = true;
   bool ready = true;
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
   List gender = [
     "Nam",
     "Nữ",
   ];

   List degree = [
     "Trên đại học",
     "Đại học",
     "Cao đẳng",
     "Khác"
   ];
   List typeofwork = [
     "Full time",
     "Part time",
     "Freelance"
   ];

   List<DropdownMenuItem<String>> getgenderDropDownMenuItems() {
     List<DropdownMenuItem<String>> items = new List();
     for (String de in gender) {
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
   List<DropdownMenuItem<String>> getdegreeDropDownMenuItems() {
     List<DropdownMenuItem<String>> items = new List();
     for (String de in degree) {
       items.add(drop(de));
     }
     return items;
   }
   List<DropdownMenuItem<String>> gettypeDropDownMenuItems() {
     List<DropdownMenuItem<String>> items = new List();
     for (String de in typeofwork) {
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
   String birthday(String fromdata){
    // DateTime now = new DateTime.now();
    // final DateFormat formatter = DateFormat('dd/MM/yyyy');
     var dateConvert = new DateTime.fromMillisecondsSinceEpoch(
         int.parse(fromdata) );
     String t = f.format(dateConvert);
     return t;
   }
   String hinhthuc(String fromdata){
     if(fromdata=="1"){
       return"Full time";
     }
     if(fromdata=="2"){
       return "Part time";
     }
     if(fromdata=="3"){
       return "Free lance";
     }
     else return"Full time";
   }
   String bangcap(String id){
     if(id=="1"){
       return"Trên đại học";
     }
     if(id=="2"){
       return "Trên đại học";
     }
     if(id=="3"){
       return "Đại học";
     }
     if(id=="4"){
       return "Cao đẳng";
     }
     else return"Trên đại học";
   }
   String gioitinh(String g){
     if(g=="1"){
       return "Nam";
     }
     else return "Nữ";
   }
settext(){
     name_us.text = widget.data['data']['user']['fullName'];

     phone_us.text =  widget.data['data']['user']['phone'];

     current_gender = widget.data['data']['user']['genderId'].toString() =="null"?gender[0].toString():gioitinh(widget.data['data']['user']['genderId'].toString());

    mail_us.text =  widget.data['data']['user']['email'];

    B_date.text  = widget.data['data']['user']['birthdayInMilliseconds'].toString()=="null"
        ?"01-1-2000":
    birthday(widget.data['data']['user']['birthdayInMilliseconds'].toString());

    current_degree = widget.data['data']['user']['graduatedEducationId'].toString()=="null"?
     degree[0].toString()
     :bangcap(widget.data['data']['user']['graduatedEducationId'].toString());

     current_typeofwork = widget.data['data']['user']['typeOfWorkId'].toString()=="null"? typeofwork[0].toString()
         :hinhthuc(widget.data['data']['user']['typeOfWorkId'].toString());

     salary_us.text = widget.data['data']['user']['expectedSalaryInVnd'].toString()=="null"
     ?"":widget.data['data']['user']['expectedSalaryInVnd'].toString();

     exp_us.text = widget.data['data']['user']['yearsOfExperiences'].toString()=="null"?"":widget.data['data']['user']['yearsOfExperiences'].toString();
     description_us.text = widget.data['data']['user']['resumeSummary'].toString()=="null"?"":widget.data['data']['user']['resumeSummary'].toString();
     careerObjective.text = widget.data['data']['user']['careerObjective'].toString()=="null"?"":widget.data['data']['user']['careerObjective'].toString();

}

  @override
  void initState() {
     settext();
f_tinh = call_tinh();
_genderdropDownMenuItems = getgenderDropDownMenuItems();
//
// current_tinh = tinh[0].toString();
//
_huyendropDownMenuItems = gethuyenDropDownMenuItems();
//
_xadropDownMenuItems = getxaDropDownMenuItems();
//
    _degreedropDownMenuItems = getdegreeDropDownMenuItems();
    //
  
    _typedropDownMenuItems = gettypeDropDownMenuItems();
    super.initState();
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      current_gender = selectedCity;
    });
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
   void changeddegreeDropDownItem(String selectedCity) {
     setState(() {
       current_degree = selectedCity;
     });
   }
   void changedtypeDropDownItem(String selectedCity) {
     setState(() {
       current_typeofwork = selectedCity;
     });
   }

//edit
   _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9

      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],

      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Chỉnh sửa ảnh',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Chỉnh sửa ảnh',
      ),
    );
    if (croppedImage != null) {

      setState(() {
        _image = croppedImage;
      });
    }
  }
  //_imgFromCamera
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50,maxHeight: 500,maxWidth: 500
    );
    _cropImage(image.path);
    // setState(() {
    //   _image = image;
    // });
  }
//_imgFromGallery
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50,maxHeight: 500,maxWidth: 500
    );
    print("da chon anh tai "+image.path);
    _cropImage(image.path);
   // _cropImage(image.path);
    // setState(() {
    //   _image = image;
    //   print(_image.toString());
    // });
  }
  String genderId(){
    for (int i = 0; i < gender.length; i++) {
      if (gender[i] == current_gender) {
        return "$i";
      }
    }
  }
  String graduate(){
    for (int i = 0; i < degree.length; i++) {
      if (degree[i] == current_degree) {
        int a = i+2;
        return "$a";
      }
    }
  }
  String typeofwork_S(){
    for (int i = 0; i < typeofwork.length; i++) {
      if (typeofwork[i] == current_typeofwork) {
        int a = i+1;
        return "$a";
      }
    }
  }
  validate()async{
    FocusScope.of(_scaffoldKey.currentContext)
        .requestFocus(new FocusNode());
    if (name_us.text.length < 2) {
      showToast("Tên từ 2 - 50 ký tự", context, Colors.red, Icons.clear);
    } else if (phone_us.text == double.nan||phone_us.text.length < 10||phone_us.text.contains("-")||phone_us.text.contains(".")) {
      showToast("Số điện thoại không đúng", context, Colors.red, Icons.clear);
    } else if (mail_us.text.length < 1||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mail_us.text)) {
      showToast("Email không hợp lệ", context, Colors.red, Icons.clear);
    } else if (salary_us.text.length < 1) {
      showToast("Nhập mức lương", context, Colors.red, Icons.clear);
    } else if ( exp_us.text.length < 1) {
      showToast("Nhập số năm kinh nghiệm", context, Colors.red, Icons.clear);
    }
    else if (exp_us.text == double.nan||exp_us.text.contains("-")||exp_us.text.contains(".")) {
      showToast("Số năm kinh nghiệm không đúng", context, Colors.red, Icons.clear);
    }
    else if (int.parse(exp_us.text) >100) {
      showToast("Số năm kinh nghiệm tối đa 100", context, Colors.red, Icons.clear);
    }
    else {
      print("chay vao else");
      setState(() {
        ready = false;
      });
      uploadImage(_image==null?null:_image.path);
  }
   }
  Future<String> uploadImage(filename) async {
    final fomat = new DateFormat('MM-dd-yyyy');
    DateTime birth = fomat.parse(B_date.text);

   // print(from.millisecondsSinceEpoch.toString());
    var request = MultipartRequest('POST', Uri.parse('https://find-job-app.herokuapp.com/api/users/update'));
    _image==null?null:request.files.add(await MultipartFile.fromPath('avatar',filename));
    request.fields['userId'] = sharedPrefs.user_id;
    request.fields['fullName'] = name_us.text;
    request.fields['email'] = mail_us.text;
    request.fields['phone'] = phone_us.text;
    request.fields['genderId'] = genderId();
    request.fields['birthdayInMilliseconds'] = (birth.millisecondsSinceEpoch).toString();
    request.fields['addressSubdistrictId'] =id_xa_selec ;
    request.fields['graduatedEducationId'] = graduate();
    request.fields['typeOfWorkId'] = typeofwork_S();
    request.fields['expectedSalaryInVnd'] = salary_us.text;
    request.fields['yearsOfExperiences'] = exp_us.text;
    request.fields['resumeSummary'] =  description_us.text;
    request.fields['careerObjective'] = careerObjective.text;
    var res = await request.send();
    var rp;
    await res.stream.transform(utf8.decoder).listen((value) {
      print(value);
      setState(() {
        rp = jsonDecode(value);
      });
    });
    if(rp['result']){
      showToast("Vuốt xuống để cập nhật", context, Colors.greenAccent, Icons.arrow_downward);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
       print( res);
    }
    else if (!rp['result']){
      showToast(rp['message'], context, Colors.red, Icons.cancel);
      setState(() {
        ready = true;
      });
    }

    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
     key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),onPressed:() {
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          if(currentFocus.hasFocus){
            currentFocus.unfocus();
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
          }
          else{
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
          }
          print(currentFocus.hasFocus);

        }),
        title: Text('Chỉnh sửa thông tin'),
      ),
      body: WillPopScope(
        onWillPop: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          if(currentFocus.hasFocus){
            currentFocus.unfocus();
          }
          else{
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => profile(my_acc: true,)));
          }
          print(currentFocus.hasFocus);

        },
        child: FutureBuilder(
          future:null ,
          builder: (context, snapshot) {
            //solan==0?FocusScope.of(context).unfocus():null;
            return true
                ? GestureDetector(
              onTap: (){
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                if(currentFocus.hasFocus){
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //avatar&ten
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //avatar
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                _image==null?(
                                    widget.data['data']['user']['avatarUrl'].toString()=="null"
                                        ? CircleAvatar(
                                      radius: mda / 8,
                                      backgroundImage: AssetImage(
                                          'assets/user_null.jpg'),
                                    )
                                        : CircleAvatar(
                                      radius: mda / 6,
                                      backgroundImage:
                                      NetworkImage(widget.data['data']['user']['avatarUrl'].toString()),
                                    ))
                                    :
                                CircleAvatar(
                                  radius: mda / 8,
                                  backgroundImage: FileImage(_image),
                                )
                                ,
                                FlatButton(
                                  child: Text(
                                    'Chọn ảnh',
                                    style: TextStyle(fontSize: mda / 35),
                                  ),
                                  color: Colors.orange,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _showPicker(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          //họ và tên
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FlatButton(
                                  child: Text(
                                    'Lưu',
                                    style: TextStyle(
                                        fontSize: mda / 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: ready?Colors.green:Colors.grey,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    loading? showToast("Đang tải...", context, Colors.grey, Icons.cancel):(ready?validate()
                                        : showToast("Đang tải...", context, Colors.grey, Icons.cancel));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Họ và tên',
                                    style: TextStyle(
                                        fontSize: mda / 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextField(
                                  maxLength: 50,
                                  controller: name_us,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: 'Ví dụ: a',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                     // date & sđt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Ngày sinh
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Giới tính",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DropdownButton(
                                  value: current_gender,
                                  items: _genderdropDownMenuItems,
                                  onChanged: changedDropDownItem,
                                ),
                              ],
                            ),
                          ),
                          //dvd
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          //sdt
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Số điện thoại",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextField(
                                  controller: phone_us,
                                  maxLength: 11,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: '01234567',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    //  tỉnh thành
                      Row(
                        children: [
                          //ngay vao
                          Container(
                            width: mda / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    "Ngày sinh",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextField(
                                  onTap: (){
                                    showDatePicker(
                                      // selectableDayPredicate: ,
                                        context: context,
                                        initialEntryMode: DatePickerEntryMode.input,
                                        helpText: "Chọn ngày",
                                        fieldLabelText: "Tháng/ngày/năm",
                                        cancelText: 'Hủy',
                                        fieldHintText: "Tháng/ngày/năm",
                                        errorFormatText: 'Vui lòng chọn đúng Tháng/ngày/năm',
                                        errorInvalidText: 'Ngoài phạm vi cho phép',
                                        confirmText: 'Đồng ý',
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100))
                                        .then((date) {
                                      setState(() {
                                        B_date.text =
                                            f.format(date).toString();
                                      });
                                    });
                                  },
                                  readOnly: true,
                                  controller: B_date,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: '1/1/2000',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextField(
                                  controller: mail_us,
                                  maxLength: 50,

                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: 'a@abc.com',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                                future: f_tinh,
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
                      //bằng cấp
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Bằng cấp",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DropdownButton(
                                  value: current_degree,
                                  items: _degreedropDownMenuItems,
                                  onChanged: changeddegreeDropDownItem,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Hình thức làm việc",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DropdownButton(
                                  value: current_typeofwork,
                                  items: _typedropDownMenuItems,
                                  onChanged: changedtypeDropDownItem,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Mức lương mong muốn (VNĐ)",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextField(
                                  maxLength: 10,
                                  controller: salary_us,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: 'Ví dụ: 8000000',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Số năm kinh nghiệm",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                               //
                                TextField(
                                  maxLength: 3,
                                  controller: exp_us,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: 'Ví dụ: 10',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Mô tả bản thân",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextField(
                                  maxLength: 1000,
                                  controller: description_us,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: 'Ví dụ: mô tả',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "Mục tiêu nghề nghiệp",
                                    style: TextStyle(
                                        fontSize: mda / 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                //
                                TextField(
                                  maxLength: 1000,
                                  controller: careerObjective,
                                  maxLines: null,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0)),
                                    hintText: 'Ví dụ: nhân viên',
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              child: Text(
                                'Lưu',
                                style: TextStyle(fontSize: mda / 35),
                              ),
                              color: ready?Colors.green:Colors.grey,
                              textColor: Colors.white,
                              onPressed: () {
                                loading? showToast("Đang tải...", context, Colors.grey, Icons.cancel):(ready?validate()
                                    : showToast("Đang tải...", context, Colors.grey, Icons.cancel));
                              },

                            ),
                            VerticalDivider(),
                            FlatButton(
                              child: Text(
                                'Hủy',
                                style: TextStyle(fontSize: mda / 35),
                              ),
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
    ;
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Ảnh của bạn'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
