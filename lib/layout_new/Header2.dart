
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';


class Header2 extends StatefulWidget {
  Header2({Key key, this.img}) : super(key: key);
  final String img;

  @override
  _Header2 createState() => _Header2();
}

class _Header2 extends State<Header2> {

  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return  Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: mda,
          child: Image.asset(
            widget.img,
            fit: BoxFit.fitHeight,
            alignment: Alignment.topLeft,
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            color: Colors.grey.withOpacity(0.55),
            width: mda-1,
            height: mda,
            child: Center(
              child: Text(
                "TIN TỨC",
                style: TextStyle(
                    fontSize: mda / 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

}