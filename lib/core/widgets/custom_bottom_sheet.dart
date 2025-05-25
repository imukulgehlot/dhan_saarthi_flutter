import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';
import 'bottom_nav_button.dart';

class CustomBottomSheet {
  CustomBottomSheet._();

  static final instance = CustomBottomSheet._();

  modalBottomSheet({required Widget child, required BuildContext context}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.r10),
                topRight: Radius.circular(Dimensions.r10))),
        isScrollControlled: true,

        // clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      radius: Dimensions.r22,
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.hintColor,
                        size: 30,
                      ),
                    )),
              ),
              Wrap(
                children: [
                  Container(
                    width: Dimensions.screenWidth(),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.r10),
                            topRight: Radius.circular(Dimensions.r10))),
                    constraints: BoxConstraints(
                        maxHeight: Dimensions.screenHeight() * 0.875),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: Dimensions.h24),
                        Flexible(
                          child: child,
                        ),
                        SizedBox(height: Dimensions.getKeyBoardHeight()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  dashBottomSheet(
      {required Widget child,
      required BuildContext context,
      Function? onComplete}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.r20),
                topRight: Radius.circular(Dimensions.r20))),
        isScrollControlled: true,

        // clipBehavior: Clip.antiAliasWithSaveLayer,

        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                width: Dimensions.screenWidth(),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r20),
                        topRight: Radius.circular(Dimensions.r20))),
                constraints: BoxConstraints(
                    maxHeight: Dimensions.screenHeight() * 0.875),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Dimensions.h12),
                    Center(
                      child: Container(
                        height: Dimensions.h6,
                        width: Dimensions.w42,
                        decoration: BoxDecoration(
                          color: AppColors.textGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(Dimensions.r5),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.h24),
                    Flexible(
                      child: child,
                    ),
                    SizedBox(height: Dimensions.getKeyBoardHeight()),
                  ],
                ),
              ),
            ],
          );
        }).whenComplete(() {
      if (onComplete != null) {
        onComplete();
      }
    });
  }

  cupertinoActionSheet({required List<Widget> actions}) {
    return showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: actions,
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  AppString.cancel,
                  style: fontStyleBold20.copyWith(
                    fontFamily: FontAsset.gilroy,
                    color: AppColors.primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ));
  }

  cupertinoDatePickerBottomSheet(
      {required DateTime initialDate,
      DateTime? minDate,
      DateTime? maxDate,
      required Function onSelect}) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    DateTime selectDate = initialDate;
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.r10),
                topRight: Radius.circular(Dimensions.r10))),
        context: (Get.context!),
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      radius: Dimensions.r22,
                      child: const Icon(
                        Icons.close_rounded,
                        color: AppColors.primaryColor,
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r20),
                        topRight: Radius.circular(Dimensions.r20))),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: Dimensions.h35,
                    // ),
                    // Text(
                    //   "AppString.selectPickupDate",
                    //   // style: fontStyleBold18,
                    // ),
                    Container(
                      padding:
                          EdgeInsets.all(Dimensions.commonPaddingForScreen),
                      height: Dimensions.h216,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (v) {
                          selectDate = v;
                        },
                        minimumDate: minDate,
                        maximumDate: maxDate,
                        initialDateTime: initialDate,
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                    BottomNavButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onSelect(selectDate);
                        },
                        text: AppString.done)
                  ],
                ),
              ),
            ],
          );
        });
  }

  cupertinoTimePickerBottomSheet(
      {required DateTime initialDate,
      DateTime? minDate,
      DateTime? maxDate,
      required Function onSelect}) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Duration selectDate = const Duration();
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.r10),
                topRight: Radius.circular(Dimensions.r10))),
        context: (Get.context!),
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      radius: Dimensions.r22,
                      child: const Icon(
                        Icons.close_rounded,
                        color: AppColors.primaryColor,
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r20),
                        topRight: Radius.circular(Dimensions.r20))),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: Dimensions.h35,
                    // ),
                    // Text(
                    //   "AppString.selectPickupDate",
                    //   // style: fontStyleBold18,
                    // ),
                    Container(
                      padding:
                          EdgeInsets.all(Dimensions.commonPaddingForScreen),
                      height: Dimensions.h216,
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        onTimerDurationChanged: (v) {
                          selectDate = v;
                        },
                        minuteInterval: 1,
                      ),
                    ),
                    BottomNavButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onSelect(selectDate);
                        },
                        text: AppString.done)
                  ],
                ),
              ),
            ],
          );
        });
  }
}
