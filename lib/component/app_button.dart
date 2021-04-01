import 'package:find_jobs/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class _AppButton extends StatelessWidget {
  String title;
  bool isLoading;
  bool isEnable;
  VoidCallback onPressed;

  Color textColor;
  Color backgroundColor;
  Color inactiveColor;
  double height;

  _AppButton(
      {this.title = "",
      this.isLoading = false,
      this.onPressed,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        padding: EdgeInsets.all(0),
        child: Container(
          height: 40,
          child: FlatButton(
            child: _buildBodyWidget(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: isEnable ? onPressed : null,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: isEnable ? backgroundColor : inactiveColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget _buildBodyWidget() {
    if (isLoading) {
      return SpinKitCubeGrid(color: Colors.white);
    } else {
      return Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      );
    }
  }
}
class AppGreenButton extends _AppButton {
  AppGreenButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback onPressed,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    this.isEnable = isEnable;
    //SetupUI
    textColor = Colors.white;
    backgroundColor = AppColor.main;
  }
}
