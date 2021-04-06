import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/item_app/Regulations.dart';
import 'package:find_jobs/model_thang/Approved_model.dart';
import 'package:find_jobs/model_thang/Jobsnew_candicate.dart';
import 'package:find_jobs/model_thang/Unapproved_model.dart';
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

import 'List_jobs_candicate.dart';

class Candicate_tab extends StatefulWidget {
  Candicate_tab({Key key, }) : super(key: key);
  @override
  _Candicate_tab createState() => _Candicate_tab();
}

class _Candicate_tab extends State<Candicate_tab> {
  Future F_candicate;
  // List<Jobnew_candicate> List_jobs = [];

  Call_candicate()async{
    List_jobs.clear();
    Api_findjobs _api_candicate = new Api_findjobs("/api/job-news/get-list-job-news-and-job-applications-of-an-owner", {
      'jobNewsOwnerUserId': sharedPrefs.user_id.toString(),
    },);
    var res  = await _api_candicate.postMethod();
    print(res);
    if(res['jobNewsArr'].length>0){
      print("chay if 1");
      //List_candicate.clear();
      List_jobs.clear();
      for(int i = 0;i<res['jobNewsArr'].length;i++){
        print('chay for 1'+i.toString());
        List<Item_candicate> List_candicate = [];
       if(res['jobNewsArr'][i]['candidateArr'].length>0){
         print("chay if 2");
         List_candicate.clear();
      if(res['jobNewsArr'][i]['candidateArr'].length>0){
        print("chay if 3"+i.toString());
        for(int c = 0;c<res['jobNewsArr'][i]['candidateArr'].length;c++){
          print('chay for 2');
          Item_candicate candicate = new Item_candicate(res['jobNewsArr'][i]['candidateArr'][c]['candidateUserId'],
              res['jobNewsArr'][i]['candidateArr'][c]['avatarUrl'],
              res['jobNewsArr'][i]['candidateArr'][c]['fullName'],
              res['jobNewsArr'][i]['candidateArr'][c]['gender']);
          List_candicate.add(candicate);
        }
      }
       }
       else{
         print("null");
       }
        Jobnew_candicate a = new Jobnew_candicate(res['jobNewsArr'][i]['companyName'],
            res['jobNewsArr'][i]['jobShortDescription'],res['jobNewsArr'][i]['jobNewsId'],List_candicate);
        List_jobs.add(a);
        print("co chay for"+"$i"+a.toString());
      }
    }
//print("co return");
    return res;
  }
  Widget list_not_null(var data,double mda_h,double mda_w){

    return ListView.builder(
        controller: new ScrollController(),
        //  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemCount: List_jobs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context)=>JobDetailPage(id:List_jobs.elementAt(index).jobNewsId )));
            },
            child: Card(
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
                            child: Text(List_jobs.elementAt(index).company_name.toUpperCase(),
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
                          Text("Mô tả: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            ),
                          ),
                          Container(
                            width:mda_w/1.75,
                            child: Text(List_jobs.elementAt(index).jobShortDescription,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.perm_contact_cal,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                Text(
                                  'Xem ứng viên ',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            color: Colors.green,
                            textColor: Colors.white,
                            onPressed: () {
if(List_jobs.elementAt(index).candicate.length<1){
  showToast("Chưa có ai ứng tuyển", context, Colors.orangeAccent, Icons.check);
}
else{
  Navigator.push(context, new MaterialPageRoute(builder: (context)=>Candicate_screen(list_candicate:List_jobs.elementAt(index).candicate,indexjobs: index,)));
}
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  Widget list_job(int length_of_approved,double mda_h,var data,double mda_w){
    if(length_of_approved<1){
      return Center(
        child: Container(
            height: mda_h/1.5,
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Không có ứng viên",style:
                    TextStyle(fontSize: 16),),
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
    F_candicate = Call_candicate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double mda_h = MediaQuery.of(context).size.height;
    double mda = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: FutureBuilder(
          future: F_candicate,
          builder: (context,snapshot){
            return snapshot.hasData?Column(
              children: [
                list_job(snapshot.data['jobNewsArr'].length,mda_h,snapshot.data,mda),
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
