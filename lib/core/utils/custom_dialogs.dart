import 'package:dhan_saarthi/core/theme/color_scheme_extension.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';
import '../helpers/animation_helper.dart';

class CustomDialogs {
  static void showCustomDialog({
    final String? title,
    final String? contentText,
    final bool barrierDismiss = true,
    final bool mergeDefaultWithContent = false,
    final String? firstButtonText,
    final Widget? myWidget,
    final String? icon,
    final ValueNotifier<double>? height,
    final Function? onDialogCloseFunction,
    final VoidCallback? firstButtonFunction,
    final VoidCallback? secondButtonFunction,
    final String? secondButtonText,
  }) {
    Duration animationDuration = Duration(milliseconds: 500);

    showGeneralDialog(
      context: Get.context!,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      barrierDismissible: barrierDismiss,
      barrierLabel: "Meow",
      transitionDuration: animationDuration,
      transitionBuilder: (_, animation, __, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: CustomAnimationCurves.dialogEaseOutBack,
            reverseCurve: Curves.linear,
          ),
        ),
        child: child,
      ),
      pageBuilder: (context, _, __) {
        animationDuration = Duration(milliseconds: 100);

        return Center(
          child: ValueListenableBuilder(
            valueListenable: height ?? ValueNotifier(0.0),
            builder: (context, value, child) => height == null
                ?
                // Dynamic Height
                Container(
                    width: Get.width * 0.82,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.r15),
                      color: Get.theme.colorScheme.dialogColor,
                    ),
                    padding: EdgeInsets.all(Dimensions.commonPaddingForScreen)
                        .copyWith(top: Dimensions.h30, bottom: Dimensions.h20),
                    child: _DialogBaseContent(
                      title: title,
                      contentText: contentText,
                      barrierDismiss: barrierDismiss,
                      mergeDefaultWithContent: mergeDefaultWithContent,
                      firstButtonText: firstButtonText,
                      myWidget: myWidget,
                      icon: icon,
                      onDialogCloseFunction: onDialogCloseFunction,
                      firstButtonFunction: firstButtonFunction,
                      secondButtonFunction: secondButtonFunction,
                      secondButtonText: secondButtonText,
                    ),
                  )
                :
                // Multi Height with Animation
                AnimatedContainer(
                    height: value,
                    duration: 200.milliseconds,
                    width: Get.width * 0.82,
                    constraints: BoxConstraints(
                      maxHeight: value,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.commonRadius),
                      color: Get.theme.colorScheme.dialogColor,
                    ),
                    padding: EdgeInsets.all(Dimensions.commonPaddingForScreen)
                        .copyWith(top: Dimensions.h30, bottom: Dimensions.h20),
                    child: _DialogBaseContent(
                      title: title,
                      contentText: contentText,
                      barrierDismiss: barrierDismiss,
                      mergeDefaultWithContent: mergeDefaultWithContent,
                      firstButtonText: firstButtonText,
                      myWidget: myWidget,
                      icon: icon,
                      onDialogCloseFunction: onDialogCloseFunction,
                      firstButtonFunction: firstButtonFunction,
                      secondButtonFunction: secondButtonFunction,
                      secondButtonText: secondButtonText,
                    ),
                  ),
          ),
        );
      },
    ).then((_) => onDialogCloseFunction?.call());
  }
}

class _DialogBaseContent extends StatelessWidget {
  final String? title;
  final String? contentText;
  final bool barrierDismiss;
  final bool mergeDefaultWithContent;
  final String? firstButtonText;
  final Widget? myWidget;
  final String? icon;
  final Function? onDialogCloseFunction;
  final VoidCallback? firstButtonFunction;
  final VoidCallback? secondButtonFunction;
  final String? secondButtonText;

  const _DialogBaseContent({
    required this.title,
    required this.contentText,
    this.barrierDismiss = true,
    this.mergeDefaultWithContent = false,
    required this.firstButtonText,
    required this.myWidget,
    required this.icon,
    required this.onDialogCloseFunction,
    required this.firstButtonFunction,
    required this.secondButtonFunction,
    required this.secondButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
            // padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
            padding: EdgeInsets.zero,
            child: myWidget != null && !mergeDefaultWithContent
                ? myWidget
                : Column(
                    children: [
                      // Title Text
                      if (title != null)
                        Text(
                          title!,
                          style: fontStyleBold18.copyWith(
                              color: Get.theme.colorScheme.textColor),
                        ),

                      // Content Text
                      if (contentText != null) ...[
                        SizedBox(
                          height: Dimensions.h2,
                        ),
                        Text(
                          contentText!,
                          textAlign: TextAlign.center,
                          style: fontStyleMedium12.copyWith(
                              color: Get.theme.colorScheme.textColor),
                        )
                      ],

                      if (myWidget != null) myWidget!,

                      // First Button
                      if (firstButtonText != null)
                        Padding(
                          padding: EdgeInsets.only(top: Dimensions.h10),
                          child: MyButton(
                              onPressed: () {
                                Get.back();
                                firstButtonFunction?.call();
                              },
                              cornerRadius: Dimensions.r10,
                              height: Dimensions.h32,
                              textStyle: fontStyleSemiBold14.copyWith(
                                  color: Colors.white,
                                  fontSize: Dimensions.sp13),
                              title: firstButtonText),
                        ),

                      // Second Button
                      if (secondButtonText != null)
                        TextButton(
                            onPressed: () {
                              secondButtonFunction?.call();
                            },
                            child: Text(
                              secondButtonText!,
                              style: fontStyleSemiBold14.copyWith(
                                  color: Colors.redAccent,
                                  fontSize: Dimensions.sp13),
                            )),
                    ],
                  )),
      ],
    );
  }
}
