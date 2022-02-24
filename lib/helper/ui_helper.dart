// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';

import '../service/locator.dart';

// Project imports:

final SizeConfig _sizeConfig = locator<SizeConfig>();

class UiHelper {
  //*Preset heights and width for gapings
  final SizedBox extraSmallHeight = SizedBox(
    height: _sizeConfig.blockSizeW,
  );
  final SizedBox smallHeight = SizedBox(
    height: _sizeConfig.blockSizeH * 1.5,
  );
  final SizedBox mediumHeight = SizedBox(
    height: _sizeConfig.blockSizeH * 5,
  );
  final SizedBox smallWidth = SizedBox(
    width: _sizeConfig.blockSizeW * 1.5,
  );
  //*Preset heights and width for gapings

  //*Showing App Toast
  showToast(
      {required String msg, bool length = true, bool gravityBottom = true}) {
    Fluttertoast.showToast(
      toastLength: length
          ? Toast.LENGTH_SHORT
          : Toast.LENGTH_LONG, //true for short || false for long
      msg: msg,
      gravity: gravityBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
      backgroundColor: const Color(0xFFcd2273),
    );
  }
  //*Showing App Toast


  Widget loaderWidget = Center(
    child: SizedBox(
      height: _sizeConfig.blockSizeW * 10,
      width: _sizeConfig.blockSizeW * 10,
      child: const CircularProgressIndicator(),
    ),
  );



  showLoader(context) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child:  CircularProgressIndicator(),
        );
      },
    );
  }

  Widget fullLoader = Stack(
    children: [
      Opacity(
        opacity: 0.6,
        child: Container(
          color: Colors.black,
          height: _sizeConfig.screenH,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: _sizeConfig.blockSizeW * 10,
          width: _sizeConfig.blockSizeW * 10,
          child: const CircularProgressIndicator(),
        ),
      ),
    ],
  );

  //*Hiding keyboard
  hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
