import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/layout_profile/Profile_below.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
  TextEditingController phone_us = new TextEditingController();
  TextEditingController address_us = new TextEditingController();
  TextEditingController salary_us = new TextEditingController();
  TextEditingController exp_us = new TextEditingController();
  TextEditingController description_us = new TextEditingController();
  TextEditingController work_need_us = new TextEditingController();
  String current_gender;
   String current_tinh;
   String current_huyen;
   String current_xa;
   String current_degree;
   String current_typeofwork;
   List gender = [
     "Nam",
     "Nữ",
   ];
   List tinh = [
     "1",
     "2",
   ];
   List huyen = [
     "1",
     "2",
   ];
   List xa = [
     "1",
     "2",
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
   List<DropdownMenuItem<String>> _genderdropDownMenuItems ;
   List<DropdownMenuItem<String>> _tinhdropDownMenuItems ;
   List<DropdownMenuItem<String>> _huyendropDownMenuItems ;
   List<DropdownMenuItem<String>> _xadropDownMenuItems ;
   List<DropdownMenuItem<String>> _degreedropDownMenuItems ;
   List<DropdownMenuItem<String>> _typedropDownMenuItems ;
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


  @override
  void initState() {
current_gender = gender[0].toString();
_genderdropDownMenuItems = getgenderDropDownMenuItems();
//
current_tinh = tinh[0].toString();
_tinhdropDownMenuItems = gettinhDropDownMenuItems();
//
current_huyen = huyen[0].toString();
_huyendropDownMenuItems = gethuyenDropDownMenuItems();
//
current_xa = xa[0].toString();
_xadropDownMenuItems = getxaDropDownMenuItems();
//
    current_degree = degree[0].toString();
    _degreedropDownMenuItems = getdegreeDropDownMenuItems();
    //
    current_typeofwork = typeofwork[0].toString();
    _typedropDownMenuItems = gettypeDropDownMenuItems();
    super.initState();
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      current_gender = selectedCity;
    });
  }
   void changedtinhDropDownItem(String selectedCity) {
     setState(() {
       current_tinh = selectedCity;
     });
   }
   void changedhuyenDropDownItem(String selectedCity) {
     setState(() {
       current_huyen = selectedCity;
     });
   }
   void changedxaDropDownItem(String selectedCity) {
     setState(() {
       current_xa = selectedCity;
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

  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
     // key: _scaffoldKey,
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
          future: null,
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
                                      NetworkImage(widget.avatar),
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
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    showToast("chưa làm", context, Colors.red, Icons.android);
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
                                  //controller: phone_us,
                                  maxLength: 20,
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
                          Text("ĐỊA CHỈ",
                            style: TextStyle(
                                fontSize: mda / 21,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          ),
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
                                  maxLength: 100,
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
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
showToast("chưa làm", context, Colors.red, Icons.android);
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
