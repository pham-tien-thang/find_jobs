import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Add_edu extends StatefulWidget {
  Add_edu({Key key}) : super(key: key);
  @override
  _Add_edu createState() => _Add_edu();
}

class _Add_edu extends State<Add_edu> {
  String from_to(String from, String to){
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    var dateConvertfrom = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(from) );
    var dateConvertto = new DateTime.fromMillisecondsSinceEpoch(
        int.parse("1485882000000") );
    String t = "từ "+formatter.format(dateConvertfrom)+" đến "+formatter.format(dateConvertto);
    return t;
  }
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;

    return Text("data");
  }
}
