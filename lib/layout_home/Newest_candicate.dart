import 'package:find_jobs/helper/Api_findjobs.dart';
import 'package:find_jobs/screen/Detail_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class Newest_Candicate extends StatefulWidget {
  @override
  _Newest_CandicateState createState() => _Newest_CandicateState();
}

// ignore: camel_case_types
class _Newest_CandicateState extends State<Newest_Candicate> {
  ScrollController scrollController = new ScrollController();
  // ignore: non_constant_identifier_names
call_api_newCandicate()async{
  Api_findjobs api_candicate = new Api_findjobs("/api/users",  {
    '': "",
    '': "",
  });
  var res = await api_candicate.getMethod();
  print(res);
  return res;
  }
  bool canCall;

String tuoi(int milis){
  DateTime now = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy');
  var dateConvert = new DateTime.fromMillisecondsSinceEpoch(
      milis );
  String t = formatter.format(dateConvert);
  return t;
}
  @override
  void initState() {
    canCall = true;

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
            call_api_newCandicate(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['users'].length<=10?snapshot.data['users'].length:10,
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return FlatButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context)=>profile(my_acc: false,id: snapshot.data['users'][index]['id'].toString())));
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
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 5,
                                                height: MediaQuery.of(context).size.width / 7,
                                                child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage: snapshot.data['users'][index]['avatarUrl'].toString()=="null"
                                                        ? AssetImage(
                                                        'assets/user_null.jpg')
                                                        : NetworkImage(
                                                        snapshot.data['users'][index]['avatarUrl'].toString()
                                                    ),
                                                    backgroundColor: Colors.transparent),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: FlatButton(
                                                  onPressed: () {

                                                  },
                                                  child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: Text(
                                                        'Xem hồ sơ',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                                30,
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.blue),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10, top: 5),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data['users'][index]['fullName'],
                                                  style: TextStyle(
                                                      fontSize:
                                                      MediaQuery.of(context).size.width / 24,
                                                      color: Colors.blue),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(snapshot.data['users'][index]['gender'].toString()=="null"
                                                          ?"Chưa rõ giới tính"
                                                          :"Giới tính: "+snapshot.data['users'][index]['gender'].toString()),
                                                      Text(snapshot.data['users'][index]['birthdayInMilliseconds'].toString()=="null"
                                                          ?"Chưa rõ tuổi"
                                                          :"Năm sinh: "+tuoi(snapshot.data['users'][index]['birthdayInMilliseconds']))
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
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.green,
              ));
            }),
      ],
    );
  }
}
