import 'package:flutter/material.dart';

import '../basic_features.dart';
import 'custom_image.dart';

class RoundedRectangleButton extends ElevatedButton {
  RoundedRectangleButton.textButton({
    super.key,
    required final String text,
    final TextAlign? textAlign,
    final double? miniWidth,
    final double? height,
    final TextStyle? textStyle,
    final double? elevation,
    final double? cornerRadius,
    final Color? btnBgColor,
    final Color? borderColor,
    final EdgeInsetsGeometry? padding,
    required final VoidCallback onPressed,
  })  : assert(
          text.isNotEmpty,
          "Text must not be null",
        ),
        super(
            child: Text(
              text,
              style: textStyle ?? fontStyleSemiBold18,
              textAlign: textAlign,
            ),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize:
                  Size(miniWidth ?? double.infinity, height ?? Dimensions.h60),
              padding: padding,
              // fixedSize:
              // Size(miniWidth ?? double.infinity, height ?? Dimensions.h40),
              backgroundColor: btnBgColor ?? Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(cornerRadius ?? Dimensions.r10),
                  side: BorderSide(color: borderColor ?? Colors.transparent)),
            ));

  RoundedRectangleButton.iconTextButton({
    super.key,
    final String? text,
    required final Widget icon,
    final double? miniWidth,
    final double? height,
    final TextStyle? textStyle,
    final double? elevation,
    final double? cornerRadius,
    final Color? btnBgColor,
    final Color? borderColor,
    required final VoidCallback onPressed,
  }) : super(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.centerLeft, child: icon),
                if (text != null && text.isNotEmpty)
                  Text(
                    text,
                    style: textStyle ?? fontStyleSemiBold18,
                  ),
              ],
            ),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize:
                  Size(miniWidth ?? double.infinity, height ?? Dimensions.h60),
              // fixedSize:
              // Size(miniWidth ?? double.infinity, height ?? Dimensions.h40),
              backgroundColor: btnBgColor ?? Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(cornerRadius ?? Dimensions.r10),
                  side: BorderSide(color: borderColor ?? Colors.transparent)),
            ));
}

class MyButton extends StatelessWidget {
  final double? miniWidth;
  final double? height;
  final TextStyle? textStyle;
  final double? elevation;
  final String? title;
  final EdgeInsets? padding;
  final bool? loading;
  final double? cornerRadius;
  final Widget? child;
  final Color? btnBgColor;
  final OutlinedBorder? outlinedBorder;
  final Function()? onPressed;

  const MyButton(
      {super.key,
      this.miniWidth,
      this.padding,
      this.height,
      this.child,
      this.outlinedBorder,
      this.elevation,
      this.cornerRadius,
      this.title,
      this.btnBgColor,
      this.textStyle,
      required this.onPressed,
      this.loading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: padding,
        fixedSize: Size(miniWidth ?? double.infinity,
            height ?? Dimensions.commonButtonHeight),
        backgroundColor: btnBgColor ?? AppColors.primaryColor,
        disabledBackgroundColor: AppColors.textFieldColor,
        shape: outlinedBorder ??
            (onPressed != null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        cornerRadius ?? Dimensions.commonRadius),
                  )
                : RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.borderColor,
                      width: Dimensions.commonBorderWidth,
                    ),
                    borderRadius: BorderRadius.circular(
                        cornerRadius ?? Dimensions.commonRadius),
                  )),
      ),
      onPressed: onPressed,
      child: Center(
        child: child ??
            Text(title!,
                textAlign: TextAlign.center,
                style: textStyle ??
                    fontStyleRegular15.copyWith(color: Colors.white)),
      ),
    );
  }
}

class MyOutLineButton extends StatelessWidget {
  final double? miniWidth;
  final double? height;
  final double? borderWidth;
  final TextStyle? textStyle;
  final double? elevation;
  final String? title;
  final bool? loading;
  final double? cornerRadius;
  final Color? btnBgColor;
  final Color? borderColor;
  final Function onPressed;

  const MyOutLineButton(
      {super.key,
      this.miniWidth,
      this.borderWidth,
      this.height,
      this.borderColor,
      this.elevation,
      this.cornerRadius,
      required this.title,
      this.btnBgColor,
      this.textStyle,
      required this.onPressed,
      this.loading});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: btnBgColor ?? AppColors.whiteColor,
        fixedSize: Size(miniWidth ?? double.infinity, height ?? Dimensions.h50),
        side: BorderSide(
          width: borderWidth ?? 1.0,
          color: borderColor ?? AppColors.textFieldBorderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius ?? Dimensions.r10),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Center(
        child: Text(title!, style: textStyle ?? fontStyleSemiBold15),
      ),
    );
  }
}

class SignInModeButton extends StatelessWidget {
  final Function() onPressed;
  final String svgIcon;

  const SignInModeButton(
      {super.key, required this.onPressed, required this.svgIcon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
          onPressed: onPressed,
          child: Center(
            child: CustomSvgAssetImage(
              width: Dimensions.w40,
              height: Dimensions.w40,
              image: svgIcon,
            ),
          )),
    );
  }
}
