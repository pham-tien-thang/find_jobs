import 'dart:io';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/main.dart';
import 'package:find_jobs/model_thang/Jobsnew_candicate.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'List_jobs_candicate.dart';




class Candicate_screen extends StatefulWidget {
  Candicate_screen({Key key,this.indexjobs,this.id_jobs}) : super(key: key,);
  //List<Item_candicate> list_candicate;
  int indexjobs;
  String id_jobs;
  @override
  _Candicate_screen createState() => _Candicate_screen();
}

class _Candicate_screen extends State<Candicate_screen> {
List display_candicate ;
bool ready = true;
call_xoa(String idjob,String idcandicate,int index)async{
  setState(() {
    ready = false;
  });
  print(ready.toString());
  Api_findjobs api_delete_candicate = new Api_findjobs("/api/job-applications/delete-candidate-from-job-news", {
    "jobNewsOwnerUserId":sharedPrefs.user_id,
    "jobNewsId":idjob,
    "candidateUserId":idcandicate
  });
  var res = await api_delete_candicate.postMethod();
  print(res);
  if(res['result']){
    showToast("Xóa thành công", context, Colors.red, Icons.clear);
    print(List_jobs.elementAt(widget.indexjobs).candicate.elementAt(index).name);
 setState(() {
   List_jobs.elementAt(widget.indexjobs).candicate.removeAt(index);
   setState(() {
     ready = true;
   });
 });
    Navigator.of(context).pop();
  }
  else{
    showToast("Xóa thất bại", context, Colors.red, Icons.clear);
    setState(() {
      ready = true;
    });
    Navigator.of(context).pop();
  }
  return res;
}
show_dialog_xoa(String idjob,String idcandicate,int index){
  bool readydl = ready;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context,setState){
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
                      child: Text("Xóa ứng viên này ?",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              readydl = ready;
                              print(readydl.toString());
                            });
                            ready?call_xoa(idjob,idcandicate,index):showToast("Đang xóa", context, Colors.yellow, Icons.cancel);
                            setState(() {
                              readydl = ready;
                              print(readydl.toString());
                            });
                          },
                          child: Text(
                            readydl?"Đồng ý":"Đang xóa",
                            style: TextStyle(color: Colors.white),
                          ),
                          color:readydl?Colors.deepOrange:Colors.grey,
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
      });
}
  @override
  void initState() {
    display_candicate = List_jobs.elementAt(widget.indexjobs).candicate;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double mda = MediaQuery.of(context).size.width;
    return MaterialApp(
      title:"Ứng viên" ,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Ứng viên"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },

        ),),
        body:display_candicate.length>0?ListView.builder(
            controller: new ScrollController(),
            //  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount: display_candicate.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>profile(my_acc: false,id: display_candicate.elementAt(index).id.toString(),)));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(backgroundImage: display_candicate.elementAt(index).avatar.toString()=="null"
                              ?AssetImage("assets/user_null.jpg"):
                              NetworkImage(display_candicate.elementAt(index).avatar.toString())
                            ,),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(display_candicate.elementAt(index).name.toUpperCase()+"",
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),
                                Row(
                                  children: [
                                    Text(display_candicate.elementAt(index).gender.toString()=="null"?
                                        "Giới tính: không rõ":"Giới tính: "+display_candicate.elementAt(index).gender,
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              'Xóa',
                              style: TextStyle(fontSize: 12),
                            ),
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            onPressed: () {
                              show_dialog_xoa(widget.id_jobs.toString(),display_candicate.elementAt(index).id.toString(),index);
                            },
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              );
            }):Container(),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
