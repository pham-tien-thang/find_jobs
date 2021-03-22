import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonPair extends StatefulWidget {
  ButtonPair({Key key, this.title, this.s, this.h}) : super(key: key);
  final String title;
  final ScrollController s;
  final bool h;
  @override
  _ButtonPair createState() => _ButtonPair();
}

class _ButtonPair extends State<ButtonPair> {
  bool a = false;
  // Future<void> _makePhoneCall(String contact) async {
  //
  //   String telScheme = 'tel:$contact';
  //
  //   if (await canLaunch(telScheme)) {
  //     await launch(telScheme);
  //   } else {
  //     throw 'Could not launch $telScheme';
  //   }
  //
  // }
  void _selected() {
    widget.s.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    //  widget.s.jumpTo(0.0);
  }

  @override
  Widget build(BuildContext context) {
    //_hide();
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: false,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  // _makePhoneCall('0948323135');
                },
                child: Icon(Icons.call),
                backgroundColor: Colors.red,
              ),
            ),
            Visibility(
              visible: widget.h,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _selected();
                },
                child: Icon(Icons.arrow_upward),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ));
  }
}
