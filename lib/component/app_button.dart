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
  double width;
  double borderRadius;
  double textSize;

  _AppButton(
      {this.title = "",
      this.isLoading = false,
      this.onPressed,
      this.height = 40,
      this.width = double.infinity,
      this.borderRadius = 12,
      this.textSize = 12,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        padding: EdgeInsets.all(0),
        child: Container(
          height: height,
          width: width,
          child: FlatButton(
            child: _buildBodyWidget(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            onPressed: isEnable ? onPressed : null,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: isEnable ? backgroundColor : inactiveColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }

  Widget _buildBodyWidget() {
    if (isLoading) {
      return SpinKitCubeGrid(color: Colors.white,size: 30,);
    } else {
      return Text(
        title,
        style: TextStyle(
          fontSize: textSize,
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
    double height,
    double width,
    double borderRadius,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    this.isEnable = isEnable;
    this.height = height;
    this.width = width;
    this.borderRadius = borderRadius;
    //SetupUI
    textColor = Colors.white;
    textSize = 16;
    backgroundColor = AppColor.main;
  }
}

class AppSmallBlueButton extends _AppButton {
  AppSmallBlueButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback onPressed,
    double height,
    double width,
    double borderRadius,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    this.isEnable = isEnable;
    this.height = height;
    this.width = width;
    this.borderRadius = borderRadius;
    //SetupUI
    textColor = Colors.white;
    textSize = 12;
    backgroundColor = AppColor.main;
  }
}

class AppSmallRedButton extends _AppButton {
  AppSmallRedButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback onPressed,
    double height,
    double width,
    double borderRadius,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    this.isEnable = isEnable;
    this.height = height;
    this.width = width;
    this.borderRadius = borderRadius;
    //SetupUI
    textColor = Colors.white;
    textSize = 12;
    backgroundColor = Colors.redAccent;
  }
}
