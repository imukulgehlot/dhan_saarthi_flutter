// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import '../basic_features.dart';

class BottomNavButton extends StatelessWidget {
  final String text;
  final Color? bgColor, textColor;
  final double? height;
  final String? icon;
  final Color? buttonTextColor;
  final double? elevation;
  final Widget? widget;
  final Function onPressed;

  const BottomNavButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.height,
    this.bgColor,
    this.icon,
    this.buttonTextColor,
    this.elevation,
    this.widget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onPressed();
      },
      child: Container(
          padding: EdgeInsets.only(
              bottom: Dimensions.getSafeAreaBottomHeight() == 0
                  ? 0
                  : Platform.isAndroid
                      ? Dimensions.getSafeAreaBottomHeight()
                      : 12),
          color: bgColor ?? AppColors.primaryColor,
          height: AppUtils.bottomPadding(context),
          width: double.infinity,
          child: widget ??
              Center(
                  child: Text(text,
                      textAlign: TextAlign.center,
                      style: fontStyleSemiBold17.apply(
                          color: textColor ?? AppColors.whiteColor)))),
    );
  }
}

class BottomNavImageButton extends StatelessWidget {
  final String text, image;
  final Color? bgColor, textColor;
  final double? height;
  final String? icon;
  final Color? buttonTextColor;
  final double? elevation;
  final Function onPressed;

  const BottomNavImageButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.height,
    this.bgColor,
    this.icon,
    this.buttonTextColor,
    this.elevation,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.only(
            bottom: Dimensions.getSafeAreaBottomHeight() == 0
                ? 0
                : Platform.isAndroid
                    ? Dimensions.getSafeAreaBottomHeight()
                    : 12),
        color: bgColor ?? AppColors.primaryColor,
        height: AppUtils.bottomPadding(context),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: text,
                          style: fontStyleSemiBold17.apply(
                              color: AppColors.whiteColor)),
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            image,
                            height: Dimensions.h28,
                            width: Dimensions.h28,
                          ))
                    ],
                  )),
            )
            // Text(text,
            //     textAlign: TextAlign.center,
            //     maxLines: 2,
            //     style:
            //         fontStyleSemiBold17.apply(color: ColorConst.whiteColor)),
            // Image.asset(
            //   image,
            //   height: Dimensions.h28,
            //   width: Dimensions.h28,
            // )
          ],
        ),
      ),
    );
  }
}

class LoginBottomNavButton extends StatelessWidget {
  final String text, suBText;
  final Function onPressed;

  const LoginBottomNavButton(this.text, this.suBText,
      {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onPressed();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: Dimensions.getSafeAreaBottomHeight() == 0
                    ? 0
                    : Platform.isAndroid
                        ? Dimensions.getSafeAreaBottomHeight()
                        : 12),
            // color: ColorConst.primaryColor,R
            height: AppUtils.bottomPadding(context),
            width: double.infinity,
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: text, style: fontStyleSemiBold15),
                    const TextSpan(text: " "),
                    TextSpan(
                        text: suBText,
                        style: fontStyleSemiBold15.apply(
                            color: AppColors.primaryColor)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
