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
  Candicate_screen({Key key,this.list_candicate,this.indexjobs}) : super(key: key,);
  List<Item_candicate> list_candicate;
  int indexjobs;
  @override
  _Candicate_screen createState() => _Candicate_screen();
}

class _Candicate_screen extends State<Candicate_screen> {
List display_candicate ;
  @override
  void initState() {
    display_candicate = widget.list_candicate;
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
        body:ListView.builder(
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

                              print("bạn muốn xóa"+List_jobs.elementAt(widget.indexjobs).company_name+" tại người dùng"+List_jobs.elementAt(widget.indexjobs).candicate.elementAt(index).name);
                            },
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
              );
            }),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
