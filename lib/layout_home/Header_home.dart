import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class header extends StatefulWidget {
  @override
  _headerState createState() => _headerState();
}

// ignore: camel_case_types
class _headerState extends State<header> {
  @override
  Widget build(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Image.asset(
          'assets/header1.png',
          width: 100,
          height: 100,
        ),
        Image.asset(
          'assets/header2.png',

          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 100,
            ),
            Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.dehaze,color: Colors.green,),
                  onPressed: () {
                    //chuyenicon();
                    Scaffold.of(context).openDrawer();
                  }),
            ),
          ],
        ),
      ],
    );
  }
}