import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleDividerSmall extends StatefulWidget {
  TitleDividerSmall({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TitleDividerSmall createState() => _TitleDividerSmall();
}

class _TitleDividerSmall extends State<TitleDividerSmall> {
  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              Text(widget.title.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: mda / 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        //divider
        Stack(
          alignment: Alignment(-1, 0),
          children: [
            Divider(
              color: Colors.grey,
            ),
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.width / 100,
              width: MediaQuery.of(context).size.width / 4.5,
            ),
          ],
        ),
      ],
    );
  }
}
