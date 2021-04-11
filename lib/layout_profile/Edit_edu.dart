import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Edit_edu extends StatefulWidget {
  Edit_edu({Key key,this.data}) : super(key: key);
  var data;
  @override
  _Edit_edu createState() => _Edit_edu();
}

class _Edit_edu extends State<Edit_edu> {
  TextEditingController to_date = new TextEditingController();
  TextEditingController from_date = new TextEditingController();
  TextEditingController name_school = new TextEditingController();
  TextEditingController Title = new TextEditingController();
  TextEditingController Details = new TextEditingController();
  bool er_name = false;
  bool er_title = false;
  String _current;
  String id_level;
  List education = [
    "Trung học",
    "Trung cấp",
    "Cao đẳng",
    "Đại học",
    "Thạc sĩ",
    "Tiến sĩ",
    "Khác",
  ];
  List<DropdownMenuItem<String>> _pstdropDownMenuItems ;
  List<DropdownMenuItem<String>> getpstDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String de in education) {
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
  String level(String c){
    for(int i =0; i <education.length;i++){
      if (c==education.elementAt(i).toString()){
        int id = i+1;
        return id.toString();
      }
    }
  }
  void changedpstDropDownItem(String selectedCity) {
    setState(() {
      _current = selectedCity;
      id_level = level(selectedCity);
      print(id_level);
    });
  }
  final f = new DateFormat('MM-dd-yyyy');

  call_api(int datein, int dateout )async{
    Api_findjobs a = new Api_findjobs("/api/education/update", {
      'userId':sharedPrefs.user_id.toString(),
      'educationId':  widget.data['educationId'].toString(),
      'schoolName':name_school.text.toString(),
      'major':Title.text.toString(),
      'academicDegreeLevelId':id_level.toString(),
      'startDateInMilliseconds':datein.toString(),
      'endDateInMilliseconds':dateout.toString(),
      'achievements':Details.text.length>0?Details.text.toString():"",
    },);
    var res = await a.postMethod();
    print(res);
    return res;
  }
  validate(){
    DateTime from = from_date.text.length>1?f.parse(from_date.text):null;
    DateTime to = to_date.text.length>1?f.parse(to_date.text):null;
    if(
    name_school.text.length<2||name_school.text.length>50
    ){
      showToast("Tên trường từ 2 đến 50 ký tự", context, Colors.red, Icons.cancel);
      setState(() {
        er_name = true;
        er_title = false;
      });
    }
    else  if(
    Title.text.length<2||name_school.text.length>50
    ){
      showToast("Chuyên ngành từ 2 đến 50 ký tự", context, Colors.red, Icons.cancel);
      setState(() {
        er_name = false;
        er_title = true;
      });
    }
    else if(from_date.text.length<1|| to_date.text.length<1){
      call_api(null, null);
      setState(() {
        er_name = false;
        er_title = false;
      });
      showToast("Vui lòng chọn ngày", context, Colors.red, Icons.cancel);
    }
    else  if(
    from.millisecondsSinceEpoch>=to.millisecondsSinceEpoch
    ){
      showToast("Thời gian không hợp lệ", context, Colors.red, Icons.cancel);
      setState(() {
        er_name = false;
        er_title = false;
      });
    }
    else {
      setState(() {
        er_name = false;
        er_title = false;
      });
      call_api(from.millisecondsSinceEpoch, to.millisecondsSinceEpoch);

      showToast("Đang cập nhật...", context, Colors.green, Icons.check);
      Navigator.pop(context);

    }
  }
  String from_to(String from, String to){
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var dateConvertfrom = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(from) );
    var dateConvertto = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(to) );
    String t = "từ "+formatter.format(dateConvertfrom)+" đến "+formatter.format(dateConvertto);
    return t;
  }
  settext(){
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    var dateConvertfrom = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.data['startDateInMilliseconds'].toString()) );
    var dateConvertto = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.data['endDateInMilliseconds'].toString()) );
    String date_in =formatter.format(dateConvertfrom);
    String date_out = formatter.format(dateConvertto);
    name_school.text = widget.data['schoolName'].toString();
    Title.text = widget.data['major'].toString();
    Details.text = widget.data['achievements'].toString()=="null"?"": widget.data['jobTitle'].toString();
    from_date.text = date_in;
    to_date.text = date_out;
  }

  @override
  void initState() {
    settext();
    _current = education.elementAt(0);
    _pstdropDownMenuItems = getpstDropDownMenuItems();
    id_level = level(_current);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))

        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tên trường:"),
            Container(height: 10,),
            TextField(
              autofocus: false,
              maxLength: 50,
              controller: name_school,
              decoration: InputDecoration(
                errorText: er_name?"Nhập lại tên":null,
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
                hintText: 'Ví dụ : Trường abc',
              ),
            ),
            //========================
            Text("Chyên nghành:"),
            Container(height: 10,),
            TextField(
              autofocus: false,
              maxLength: 50,
              controller: Title,
              decoration: InputDecoration(
                errorText: er_title?"Nhập lại chức vụ":null,
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
                hintText: 'Ví dụ : CNTT',
              ),
            ),
            //================
            Text("Hệ đào tạo:"),
            Container(height: 10,),
            Center(
              child: DropdownButton(
                value: _current,
                items: _pstdropDownMenuItems,
                onChanged: changedpstDropDownItem,
              ),
            ),
            //============
            Center(child: Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,0),
              child: Text("Thời gian:"),
            )),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Từ:"),
                IconButton(
                  iconSize: 20,
                  onPressed: (){
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        initialEntryMode: DatePickerEntryMode.input,
                        helpText: "Chọn ngày",
                        fieldLabelText: "Tháng/ngày/năm",
                        cancelText: 'Hủy',
                        fieldHintText: "Tháng/ngày/năm",
                        errorFormatText: 'Vui lòng chọn đúng Tháng/ngày/năm',
                        errorInvalidText: 'Ngoài phạm vi cho phép',
                        confirmText: 'Đồng ý',
                        firstDate: DateTime(1900),
                        lastDate:DateTime(2100)
                    ).then((date) {
                      setState(() {
                        from_date.text =
                            f.format(date).toString();
                      });
                    });
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Text(from_date.text),


              ],
            ),

            Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Đến"),
                IconButton(
                  iconSize: 20,
                  onPressed: (){
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        initialEntryMode: DatePickerEntryMode.input,
                        helpText: "Chọn ngày",
                        fieldLabelText: "Tháng/ngày/năm",
                        cancelText: 'Hủy',
                        fieldHintText: "Tháng/ngày/năm",
                        errorFormatText: 'Vui lòng chọn đúng Tháng/ngày/năm',
                        errorInvalidText: 'Ngoài phạm vi cho phép',
                        confirmText: 'Đồng ý',
                        firstDate: DateTime(1900),
                        lastDate:DateTime(2100)
                    ).then((date) {
                      setState(() {
                        to_date.text =
                            f.format(date).toString();
                      });
                    });
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Text(to_date.text),
              ],
            ),

            //==============
            Text("Thành tựu:"),
            Container(height: 10,),
            TextField(
              autofocus: false,
              maxLength: 1000,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: Details,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        color: Colors.grey, width: 1.0)),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    validate();
                  },
                  child: Text(
                    "Cập nhật",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
