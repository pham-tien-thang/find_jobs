import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// ignore: camel_case_types
class BottomNavigationcustom extends StatefulWidget {
  BottomNavigationcustom({Key key, this.selectedIndex,this.tap,}) : super(key: key);
  final int selectedIndex;
  final  tap;
  String a;

  @override
  _BottomNavigationcustom createState() => _BottomNavigationcustom();
}

// ignore: camel_case_types
class _BottomNavigationcustom extends State<BottomNavigationcustom> {
  Color setcolor(int selec,int index){
    if(selec==index){
      return Colors.green;
    }
    else  return Colors.black;
  }
  @override
  Widget build(BuildContext context) {
    //sharedPrefs.init();
    double mda = MediaQuery.of(context).size.width;
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlue.shade100.withOpacity(0.5),
      selectedItemColor: Colors.blue,
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: setcolor(widget.selectedIndex, 0)),
            title: Text(
              'Trang chủ',
              style: TextStyle(color: setcolor(widget.selectedIndex, 0), fontSize: 16),
            )),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color:setcolor(widget.selectedIndex, 1)),
          title: Text(
            'Tìm kiếm',
            style: TextStyle(color: setcolor(widget.selectedIndex, 1), fontSize: 16),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box, color: setcolor(widget.selectedIndex, 2))
          ,
          title: Text('Tài khoản',
              style: TextStyle(color: setcolor(widget.selectedIndex, 2), fontSize: 16))
          ,
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.tap,
    );
  }
}
