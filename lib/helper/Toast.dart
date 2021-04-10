import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast2(BuildContext context, String a) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(a),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

void showToast(String text, BuildContext context, Color c, IconData i) {
  Widget toast = Container(

    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: c,
    ),
    child: Container(
      // width: MediaQuery.of(context).size.width/1.85,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(i),
          SizedBox(
            width: 10.0,
          ),
          SizedBox(
            child: Text(text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );

  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
