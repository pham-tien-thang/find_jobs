import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/layout_profile/Edit_exp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Experence_list extends StatefulWidget {
  Experence_list({Key key,this.count,this.data,this.my_acc}) : super(key: key);
final int count;
final data;
final my_acc;
  @override
  _Experence_list createState() => _Experence_list();
}

class _Experence_list extends State<Experence_list> {
  show_dialog_edit(var data){
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
                            child: Text("SỬA CÔNG TY",
                              style:TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Edit_exp(data: data,)
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
  call_api(int id)async{
    Api_findjobs a = new Api_findjobs("/api/experiences/remove", {
      'experienceId':id.toString(),
    },);
    var res = await a.postMethod();
    print(id.toString());
    return res;
  }
  show_dialog(int id){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(20.0),

            ), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("XÓA CÔNG TY NÀY ?",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            call_api(id);
                            showToast("Đang xóa...", context, Colors.grey, Icons.check);
                          },
                          child: Text(
                            "Đồng ý",
                            style: TextStyle(color: Colors.white),
                          ),
                          color:Colors.green,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Hủy",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  String from_to(String from, String to){
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    var dateConvertfrom = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(from) );
    var dateConvertto = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(to) );
    String t = "từ "+formatter.format(dateConvertfrom)+" đến "+formatter.format(dateConvertto);
    return t;
  }
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    print( "so lengh la"+ widget.count.toString());
    return 
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        controller: new ScrollController(),
        itemCount: widget.count,
        itemBuilder: (context, index) {
          return Container(
            width: mda,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tên công ty :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(widget.data['data']['experiences'][index]['companyName'].toUpperCase(),
                        style: TextStyle(fontSize: mda/24),
                        maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Thời gian     :",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Flexible(child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(widget.data['data']['experiences'][index]['dateInMilliseconds'].toString()=="null"||
                          widget.data['data']['experiences'][index]['dateOutMilliseconds'].toString()=="null"?
                          "không rõ"
                          :
                        from_to(widget.data['data']['experiences'][index]['dateInMilliseconds'].toString(),
                          widget.data['data']['experiences'][index]['dateOutMilliseconds'].toString()
                      ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                    )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chức vụ       :",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(widget.data['data']['experiences'][index]['jobTitle'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                        )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mô tả           :",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(widget.data['data']['experiences'][index]['jobDetails'].toString()=="null"?"không rõ":widget.data['data']['experiences'][index]['jobDetails'].toString(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,),
                        )),
                  ],
                ),
                widget.my_acc?Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(icon: Icon(Icons.delete_forever,color: Colors.redAccent,),
                        onPressed: (){
                      show_dialog(widget.data['data']['experiences'][index]['id']);
                        }),
                    IconButton(icon: Icon(Icons.edit,color: Colors.blue,),
                        onPressed: (){
                        show_dialog_edit(widget.data['data']['experiences'][index]);

                        })
                  ],
                ):Container(),
                Divider(color: Colors.grey,),
              ],
            ),
          );
        },
      ),
    );
  }
}
