import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/model_thang/Approved_model.dart';
import 'package:find_jobs/model_thang/Unapproved_model.dart';
import 'package:find_jobs/screen/job_detail/job_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Not_approved extends StatefulWidget {
  Not_approved({Key key, }) : super(key: key);
  @override
  _Not_approved createState() => _Not_approved();
}

class _Not_approved extends State<Not_approved> {
  Future F_unApproved;
  call_xoa(int id_job,int i)async{
    Api_findjobs api_xoa = new Api_findjobs("/api/job-news/remove", {
      "jobNewsId":"$id_job"
    });
    var res = await api_xoa.postMethod();
    if(res['result']){
      setState(() {
        showToast("Đã xóa", context, Colors.green, Icons.check);
        model.removeAt(i);
      });
    }
    else{
      showToast("Tin này không còn tồn tại", context, Colors.green, Icons.check);
      model.removeAt(i);
    }
  }
  show_dialog(int id_job,int i){
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
                      child: Text("Xóa tin này?",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            call_xoa( id_job, i);
                            Navigator.of(context).pop();
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
  List<Unapproved_model> model = [];
  Call_Approved()async{
    model.clear();
    Api_findjobs _api_approved = new Api_findjobs("/api/job-news/get-unapproved-job-news-of-an-owner", {
      'ownerId': sharedPrefs.user_id.toString(),
    },);
    var res  = await _api_approved.postMethod();
    print(res);
    if(res['unapprovedJobNewsOfThisOwnerArr'].length>0){
    //  print("co chay if");
      model.clear();
      for(int i = 0;i<res['unapprovedJobNewsOfThisOwnerArr'].length;i++){
         Unapproved_model a = new Unapproved_model(res['unapprovedJobNewsOfThisOwnerArr'][i]['companyName'],
          res['unapprovedJobNewsOfThisOwnerArr'][i]['jobShortDescription'],res['unapprovedJobNewsOfThisOwnerArr'][i]['jobNewsId']);
         model.add(a);
       // print("co chay for"+"$i"+a.toString());
      }
    }
//print("co return");
    return res;
  }
  Widget list_not_null(var data,double mda_h,double mda_w){
    print(model.length);
    return ListView.builder(
        controller: new ScrollController(),
        //  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemCount: model.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tên công ty: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                        Container(
                          width: mda_w/1.75,
                          child: Text(model.elementAt(index).company_name.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 14
                            ),),
                        ),
                      ],
                    ),
                  ),
                  //-----------------
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lĩnh vực: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                        Container(
                          width:mda_w/1.75,
                          child: Text(model.elementAt(index).title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 14
                            ),),
                        ),
                      ],
                    ),
                  ),
                  //---------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text("Chưa được duyệt"),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 14,
                              ),
                              Text(
                                'Xóa ',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            show_dialog(model.elementAt(index).id, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
  Widget list_approved(int length_of_approved,double mda_h,var data,double mda_w){
    if(length_of_approved<1){
      return Center(
        child: Container(
            height: mda_h/1.5,
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Không có tin chờ phê duyệt",style:
                    TextStyle(fontSize: 16),),
                    Text("Đăng tin mới",style:
                    TextStyle(fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    )
                    ),
                  ],
                )
            )),
      );
    }
    else return list_not_null(data,mda_h,mda_w);
  }
  @override
  void initState() {
    // TODO: implement initState
    F_unApproved = Call_Approved();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double mda_h = MediaQuery.of(context).size.height;
    double mda = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: FutureBuilder(
          future: F_unApproved,
          builder: (context,snapshot){
            return snapshot.hasData?Column(
              children: [
                list_approved(snapshot.data['unapprovedJobNewsOfThisOwnerArr'].length,mda_h,snapshot.data,mda),
              ],
            ):Center(child: Padding(
              padding: const EdgeInsets.fromLTRB(0,200,0,0),
              child: SpinKitCircle(
                color: Colors.green,
                size: 50,
              ),
            ),);
          },
        )
    );;
  }

}
