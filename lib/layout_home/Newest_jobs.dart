import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:find_jobs/screen/job_detail/job_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class Newest_jobs extends StatefulWidget {
  @override
  _Newest_jobs createState() => _Newest_jobs();
}

// ignore: camel_case_types
class _Newest_jobs extends State<Newest_jobs> {
  ScrollController scrollController = new ScrollController();
  Future _F_jobs;
  call_api_newJob()async{
    Api_findjobs api_jobs = new Api_findjobs("/api/job-news/approved-job-news",  {
      '': "",
      '': "",
    });
    var res = await api_jobs.getMethod();
    print(res);
    return res;
  }
  bool canCall;

  String saraly(String luong){
String a = luong.substring(0,luong.length-6);
    return a + " triệu VNĐ";
  }
  @override
  void initState() {
    canCall = true;
_F_jobs = call_api_newJob();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        //   child: TitleDivider(title: 'Ứng viên mới nhất'),
        // ),
        FutureBuilder(
            future:
            _F_jobs,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['jobNewsArr'].length<10?snapshot.data['jobNewsArr'].length:10,
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return FlatButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>JobDetailPage(id: int.parse(snapshot.data['jobNewsArr'][index]['jobNewsId'].toString()))));

                        },
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
                                                  snapshot.data['jobNewsArr'][index]['companyName'],
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
                                                      Text("CÔNG VIỆC: "+snapshot.data['jobNewsArr'][index]['jobShortDescription']),
                                                      Text("MỨC LƯƠNG: "+saraly(snapshot.data['jobNewsArr'][index]['salaryInVnd'].toString()))
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
              canCall = true;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Center(
                        child: SpinKitCircle(
                          color: Colors.green,
                          size: 50,
                        )
                      ),
                    height: 200,
                  ),
                ],
              );
            }),
      ],
    );
  }
}
