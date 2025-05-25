import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';

class Loader {
  Loader._();

  static final instance = Loader._();

  init() {
    // EasyLoading.init();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..indicatorWidget = const CupertinoActivityIndicator(
        color: AppColors.whiteColor,
        radius: 12,
      )
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primaryColor
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..indicatorSize = 60
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false
      ..textColor = Colors.transparent
      ..boxShadow = <BoxShadow>[]
      ..userInteractions = false;
  }
}
