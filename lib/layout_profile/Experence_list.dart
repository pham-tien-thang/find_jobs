import 'dart:ui';

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
                        onPressed: null),
                    IconButton(icon: Icon(Icons.edit,color: Colors.blue,),
                        onPressed: null)
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
