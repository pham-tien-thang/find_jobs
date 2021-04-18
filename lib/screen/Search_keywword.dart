import 'dart:ui';

import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/item_app/BottomNavigation.dart';
import 'package:find_jobs/item_app/Buttton_pair.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_new/Header2.dart';
import 'package:find_jobs/model_thang/Skill_jobs.dart';
import 'package:find_jobs/model_thang/User_fillter.dart';
import 'package:find_jobs/model_thang/job_new_model.dart';
import 'package:find_jobs/screen/job_detail/job_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Detail_user.dart';
import 'HomeScreen.dart';


class Search_keywword extends StatefulWidget {
  Search_keywword({Key key, this.data})
      : super(key: key);
  var data;

  @override
  _Search_keywword createState() => _Search_keywword();
}

class _Search_keywword  extends State<Search_keywword> with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Tìm việc làm'),
    new Tab(text: 'Tìm ứng viên'),
  ];
  ontapbottom(int index) {
    setState(() {
      if (index == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
      }
      if (index == 2) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => profile(
                  my_acc: true,
                )));
      }
      if (index == 1) {
        // Navigator.push(
        //     context, new MaterialPageRoute(builder: (context) => Search_keywword()));
      }
    });
  }
List<Job_mew_model> list_all = [];
  List<Job_mew_model> list_search=[];
  TabController _tabController;
  bool search = false;
  TextEditingController ctrl_search = new TextEditingController();

  Future _all;
  String _saraly(String l){
    if(l.length>6){
      String a = l.substring(0,l.length-6);
      return a + " triệu VNĐ";
    }
    else {
      return l;
    }
  }
  call_search(){
    setState(() {
      search = true;
      list_search.clear();
    });
    for(int i = 0 ; i< list_all.length;i++){
    //  print( list_all.elementAt(i).company_name.contains("Công"));
      if(
      list_all.elementAt(i).address.toLowerCase().contains(ctrl_search.text.toLowerCase())
          ||list_all.elementAt(i).position.toLowerCase().contains(ctrl_search.text.toLowerCase())
      ||list_all.elementAt(i).time.toLowerCase().contains(ctrl_search.text.toLowerCase())
      ||list_all.elementAt(i).saraly.toLowerCase().toString().contains(ctrl_search.text.toLowerCase())
          ||list_all.elementAt(i).company_name.toLowerCase().contains(ctrl_search.text.toLowerCase())
          ||list_all.elementAt(i).title.toLowerCase().contains(ctrl_search.text.toLowerCase())

      ){
        list_search.add(list_all[i]);
      }
      else{

      }
    }
    print("có"+list_search.length.toString()+"kết quả");
  }
  call_all()async{
    Api_findjobs getall = new Api_findjobs("/api/job-news/approved-job-news", {
      "":""
    });
    var res_all = await getall.getMethod();
    if(res_all['result']){
      print("co");

      if(res_all['jobNewsArr'].length>0){
        //add model
        print("chạy addmodel");

        list_all.clear();
        for( int i = 0 ;i<res_all['jobNewsArr'].length;i++){
          List <Skill_jobs> list_skill=[];
//check skill
          if(res_all['jobNewsArr'][i]['requiredSkills'].length>0){
            list_skill.clear();
            //add_skill
            for(int c = 0 ;c<res_all['jobNewsArr'][i]['requiredSkills'].length;c++){

              if(true){
                Skill_jobs s = new Skill_jobs(name: res_all['jobNewsArr'][i]['requiredSkills'][c]['skillName']);
                list_skill.add(s);
                print(list_skill.length.toString()+"length skill");
              }

            }
            print("co skill");
          }
          else{
            print("null skill");
          }

          if(list_skill.length>0){

            Job_mew_model j = new Job_mew_model(res_all['jobNewsArr'][i]['companyName'],
              res_all['jobNewsArr'][i]['jobShortDescription'],
              res_all['jobNewsArr'][i]['jobNewsId'] as int,
              res_all['jobNewsArr'][i]['stateProvinceName'],
              res_all['jobNewsArr'][i]['jobTitleName'],
              res_all['jobNewsArr'][i]['salaryInVnd'].toString(),
              res_all['jobNewsArr'][i]['districtName'].toString(),
              res_all['jobNewsArr'][i]['typeOfWorkName'],
              res_all['jobNewsArr'][i]['requiredTechnologyText'].toString(),
              list_skill,
            );
            list_all.add(j);

          }
          else {
          }
        }
        print(res_all);
        return res_all;
      }

      return 1;
    }
    else{
      return 1;
    }
  }
  @override
  void initState() {
    ctrl_search.addListener((){
      print("value: ${ctrl_search.text}");
      setState(() {

      });
    });
    super.initState();
    _all = call_all();
    _tabController = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {

    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double mda = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child:
        Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Builder(
                  builder: (context) => IconButton(icon: Icon(Icons.dehaze), onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }),
                ),

                Center(
                  child: Stack(
                    alignment: Alignment(1, 0),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),

                        width:MediaQuery.of(context).size.width-100,
                        child: TextField(
                          onChanged: (s){
                            call_search();
                            print(s);
                          },
                          controller: ctrl_search,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                            hintText: 'Từ khóa...',
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.search), onPressed: (){
                       list_all.length>0?call_search():null;
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationcustom(selectedIndex:1,tap: ontapbottom,),
      drawer: Drawer_findjobs(),
      body: FutureBuilder(
        future:  _all,
       builder:  (context ,snapshot){
          return snapshot.hasData? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();

                }
                print('tap');
              },
              child: _listjobs(),
            ),
          ):Center(child: Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,0),
            child: SpinKitCircle(
              color: Colors.green,
              size: 50,
            ),
          ),);
       },
      ),
    );
    ;
  }
  Widget _listjobs( ){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: search?list_search.length:list_all.length,
        scrollDirection: Axis.vertical,
        controller: new ScrollController(),
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (currentFocus.hasPrimaryFocus||currentFocus.hasFocus) {
                currentFocus.unfocus();
                print(currentFocus.hasPrimaryFocus);

              }

           Navigator.push(context, new MaterialPageRoute(builder: (context)=>JobDetailPage(id: search?list_search.elementAt(index).id:list_all.elementAt(index).id)));}

            ,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 4.5,
                              child: Container(
                                  height: MediaQuery.of(context).size.width / 5,
                                  width:MediaQuery.of(context).size.width / 5 ,
                                  child: Image.asset("assets/jobs_item.png")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      search?list_search.elementAt(index).company_name.toUpperCase():list_all.elementAt(index).company_name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width / 20,
                                          color: Colors.blue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(search?"CÔNG VIỆC: "+list_search.elementAt(index).title:"CÔNG VIỆC: "+list_all.elementAt(index).title),
                                          Text(search?"MỨC LƯƠNG: "+_saraly(list_search.elementAt(index).saraly).toString():"MỨC LƯƠNG: "+_saraly(list_all.elementAt(index).saraly).toString())
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );;
        },
      ),
    );
  }
}
