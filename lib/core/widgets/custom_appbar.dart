import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../basic_features.dart';
import 'network_image.dart';
import 'text_field/text_field/my_text_field.dart';

class CustomAppBar extends AppBar {
  CustomAppBar.drawerNotificationAppBar({
    super.key,
    required String title,
    required BuildContext context,
    required VoidCallback actionOnpress,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    double? elevation,
    bool whiteStatusBarText = false,
    bool blackBackground = false,
  }) : super(
            elevation: elevation ?? 1,
            centerTitle: true,
            title: Text(title,
                style: fontStyleSemiBold18.copyWith(
                    color: blackBackground ? AppColors.whiteColor : null)),
            backgroundColor:
                blackBackground ? AppColors.blackColor : AppColors.appbarColor,
            systemOverlayStyle: systemUiOverlayStyle ??
                ((whiteStatusBarText || blackBackground)
                    ? SystemUiOverlayStyle.light
                        .copyWith(statusBarColor: Colors.transparent)
                    : SystemUiOverlayStyle.dark
                        .copyWith(statusBarColor: Colors.transparent)),
            leading: Builder(builder: (BuildContext context) {
              return InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w3, top: 19, bottom: 19),
                    child: Image.asset(
                      AppImages.icDrawerIcon,
                    ),
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  });
            }),
            actions: [
              InkWell(
                onTap: actionOnpress,
                child: Image.asset(
                  AppImages.icReadedNotification,
                  width: Dimensions.w19,
                  height: Dimensions.w19,
                ),
              ),
              SizedBox(width: Dimensions.w20)
            ]);

  CustomAppBar.backActionAppBar(
      {super.key,
      required String title,
      TextStyle? textStyle,
      double super.elevation = 0,
      bool showLeading = true,
      Function? backPress,
      bool super.centerTitle = true,
      Widget? leadingWidget,
      SystemUiOverlayStyle? systemUiOverlayStyle,
      bool whiteStatusBarText = false,
      super.bottom,
      bool useBackIcon = false,
      bool blackBackground = false,
      super.actions})
      : super(
            backgroundColor: blackBackground ? AppColors.blackColor : null,
            systemOverlayStyle: systemUiOverlayStyle ??
                ((whiteStatusBarText || blackBackground)
                    ? SystemUiOverlayStyle.light
                        .copyWith(statusBarColor: Colors.transparent)
                    : SystemUiOverlayStyle.dark
                        .copyWith(statusBarColor: Colors.transparent)),
            leading: Visibility(
                visible: showLeading,
                child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: useBackIcon ? Dimensions.w3 : Dimensions.w12,
                      ),
                      child: leadingWidget ??
                          (useBackIcon
                              ? Icon(
                                  Icons.arrow_back_ios,
                                  color: blackBackground
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                )
                              : Image.asset(
                                  AppImages.icBackButton,
                                )),
                    ),
                    onTap: () {
                      if (backPress != null) {
                        backPress();
                        return;
                      }
                      Navigator.pop(Get.context!);
                    })),
            title: Text(title,
                style: textStyle ??
                    fontStyleSemiBold18.copyWith(
                        color: blackBackground ? AppColors.whiteColor : null)));

  CustomAppBar.rowAppBar({
    super.key,
    double elevation = 1,
    required Widget row,
  }) : super(
          elevation: elevation,
          title: row,
        );

  CustomAppBar.backFilterAppBar(
      {super.key,
      required String title,
      required BuildContext context,
      required Function actionOnpress,
      double? elevation,
      bool showAction = true,
      applyFilter = false,
      Widget? filterWidget,
      Function? backPress,
      bool centerTitle = true})
      : super(
          elevation: elevation ?? 1,
          centerTitle: centerTitle,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: AppColors.appbarColor,
          leading: InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: Dimensions.w3),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                ),
              ),
              onTap: () {
                if (backPress != null) {
                  backPress();
                  return;
                }
                Navigator.pop(context);
              }),
          title: Text(title,
              style: fontStyleSemiBold17.apply(
                color: AppColors.whiteColor,
              )),
          actions: [
            Visibility(
              visible: showAction,
              child: InkWell(
                onTap: () {
                  actionOnpress();
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(right: Dimensions.commonPaddingForScreen),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Center(
                        child: Image.asset(
                          AppImages.icFilter,
                          height: Dimensions.w21,
                          width: Dimensions.w21,
                        ),
                      ),
                      filterWidget ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              // child: FilterIcon(isApplyFilter: true),
            )
          ],
        );

  CustomAppBar.chatAppBar({
    super.key,
    required String title,
    des,
    img,
    required Function titleOnPress,
    required BuildContext context,
  }) : super(
          elevation: 1,
          backgroundColor: AppColors.appbarColor,
          leadingWidth: 25,
          leading: InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: Dimensions.w15),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                ),
              ),
              onTap: () => {Navigator.pop(context)}),
          title: InkWell(
            onTap: () {
              titleOnPress();
            },
            child: Row(
              children: [
                MyRoundCornerNetworkImage(
                    height: Dimensions.w35,
                    width: Dimensions.w35,
                    image: img,
                    radius: Dimensions.r3),
                SizedBox(
                  width: Dimensions.w10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: fontStyleMedium16.apply(
                              color: AppColors.whiteColor)),
                      Text(des,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: fontStyleRegular14.apply(
                              color: AppColors.whiteColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

  CustomAppBar.blankAppbar(
      {double? height,
      SystemUiOverlayStyle? systemUiOverlayStyle,
      bool whiteStatusBarText = false,
      super.key})
      : super(
            toolbarHeight: height ?? 0,
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: systemUiOverlayStyle ??
                (whiteStatusBarText
                    ? SystemUiOverlayStyle.light
                        .copyWith(statusBarColor: Colors.transparent)
                    : SystemUiOverlayStyle.dark
                        .copyWith(statusBarColor: Colors.transparent)));

  CustomAppBar.locationSearchAppBar({
    super.key,
    required String title,
    required BuildContext context,
    double? elevation,
    Function? actionOnpress,
    Function? currentLocationPress,
    bool showAction = false,
    bool leading = false,
    Function? onChangedText,
  }) : super(
          toolbarHeight: Dimensions.w50,
          elevation: elevation ?? 1,
          centerTitle: true,
          backgroundColor: AppColors.blackColor,
          leadingWidth: Dimensions.w35,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.w3),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.blackColor,
              ),
            ),
          ),
          title: Text(title,
              style: fontStyleSemiBold17.apply(
                color: AppColors.whiteColor,
              )),
          bottom: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.blackColor,
            title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.r5),
              ),
              width: double.infinity,
              height: Dimensions.w40,
              child: Center(
                child: TextField(
                  style: fontStyleMedium14,
                  onChanged: (vals) {
                    onChangedText!(vals);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    prefixIconConstraints: BoxConstraints(
                        minHeight: Dimensions.w24, minWidth: Dimensions.w24),
                    suffixIconConstraints: BoxConstraints(
                        minHeight: Dimensions.w24, minWidth: Dimensions.w24),
                    // hintText: AppString.login,
                    hintStyle:
                        fontStyleSemiBold14_.apply(color: AppColors.hintColor),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.w10, right: Dimensions.w10),
                      child: Icon(
                        Icons.search,
                        size: Dimensions.w18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

  CustomAppBar.searchAppbar({
    super.key,
    Function? backPress,
    Function? onSearch,
    double? elevation,
    String? hintText,
    // required TextEditingController textEditingController,
    bool centerTitle = true,
  }) : super(
          elevation: elevation ?? 1,
          centerTitle: centerTitle,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensions.w3),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () {
                    if (backPress != null) {
                      backPress();
                      return;
                    }
                  }),
              Expanded(
                child: SizedBox(
                    height: Dimensions.h40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                      child: MyTextField(
                        autoFocus: true,
                        hintText: hintText,
                        textStyle: fontStyleSemiBold14_,
                        hintTextStyle: fontStyleMedium13.copyWith(
                            color: AppColors.hintColor),
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Dimensions.h6),
                          child: Image.asset(AppImages.icTextfieldSearchIcon),
                        ),
                      ),
                    )),
                // child: TextField(
                //   // controller: textEditingController,
                //   textInputAction: TextInputAction.search,
                //   autofocus: true,
                //   onChanged: (value) {
                //     if (onSearch != null) {
                //       onSearch();
                //     }
                //   },
                //   style: CustomTextStyle.instance.semiBold15
                //       .copyWith(color: ColorConst.whiteColor),
                //   textAlignVertical: TextAlignVertical.center,
                //   keyboardType: TextInputType.number,
                //   // ignore: prefer_const_constructors
                //   decoration: InputDecoration(
                //     isDense: true,
                //     // hintText: AppString.enterFormId,
                //     hintStyle: CustomTextStyle.instance.regular12
                //         .copyWith(color: ColorConst.whiteColor),
                //     border: InputBorder.none,
                //   ),
                // ),
              ),
            ],
          ),
        );

  CustomAppBar.appIconSearchbar({
    super.key,
    Function? onSearchTap,
    Function? onNotificationTap,
    Function? onSearchBackPress,
    String? hintText,
    double elevation = 1,
    required ValueNotifier<bool> showSearchBar,
  }) : super(
          elevation: elevation,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: ValueListenableBuilder<bool>(
              valueListenable: showSearchBar,
              builder: (context, showSearch, _) {
                return showSearch
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.w3),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              onTap: () {
                                showSearchBar.value = false;
                                if (onSearchBackPress != null) {
                                  onSearchBackPress();
                                }
                                return;
                              }),
                          Expanded(
                            child: SizedBox(
                                height: Dimensions.h40,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.h5),
                                  child: MyTextField(
                                    autoFocus: true,
                                    hintText: hintText,
                                    textStyle: fontStyleSemiBold14_,
                                    hintTextStyle: fontStyleMedium13.copyWith(
                                        color: AppColors.hintColor),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.h6),
                                      child: Image.asset(
                                          AppImages.icTextfieldSearchIcon),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.w5),
                            child: Image.asset(
                              AppImages.icAppName,
                              height: Dimensions.h27,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                if (onNotificationTap != null) {
                                  onNotificationTap();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: Dimensions.w15),
                                child: Center(
                                    child: Image.asset(
                                  AppImages.icNotification,
                                  height: Dimensions.h20,
                                  width: Dimensions.w20,
                                )),
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: Dimensions.w15),
                            child: GestureDetector(
                              onTap: () {
                                if (onSearchTap != null) {
                                  onSearchTap();
                                }
                              },
                              child: Image.asset(
                                AppImages.icSearch,
                                height: Dimensions.h20,
                                width: Dimensions.w20,
                              ),
                            ),
                          ),
                        ],
                      );
              }),
        );

  CustomAppBar.titleSearchAppBar(
      {super.key,
      required String title,
      String? hintText,
      double elevation = 1,
      required ValueNotifier<bool> showSearchBar,
      Function? backPress,
      Function? onSearchBackPress,
      Function? onActionTap})
      : super(
          elevation: elevation,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          automaticallyImplyLeading: false,
          title: ValueListenableBuilder<bool>(
              valueListenable: showSearchBar,
              builder: (context, showSearch, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.w3),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.blackColor,
                          ),
                        ),
                        onTap: () {
                          if (showSearchBar.value == false &&
                              backPress != null) {
                            backPress();
                            return;
                          } else if (showSearchBar.value) {
                            showSearchBar.value = false;
                            if (onSearchBackPress != null) {
                              onSearchBackPress();
                            }
                            return;
                          }
                          Navigator.pop(Get.context!);
                        }),
                    Expanded(
                      child: !showSearch
                          ? Center(
                              child: Text(title, style: fontStyleSemiBold18))
                          : SizedBox(
                              height: Dimensions.h40,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.h5),
                                child: MyTextField(
                                  autoFocus: true,
                                  hintText: hintText,
                                  textStyle: fontStyleSemiBold14_,
                                  hintTextStyle: fontStyleMedium13.copyWith(
                                      color: AppColors.hintColor),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.h6),
                                    child: Image.asset(
                                        AppImages.icTextfieldSearchIcon),
                                  ),
                                ),
                              )),
                    ),
                  ],
                );
              }),
          actions: [
            ValueListenableBuilder<bool>(
                valueListenable: showSearchBar,
                builder: (context, showSearch, _) {
                  return showSearch
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(right: Dimensions.w15),
                          child: GestureDetector(
                            onTap: () {
                              showSearchBar.value = true;
                              if (onActionTap != null) {
                                onActionTap();
                              }
                            },
                            child: Image.asset(
                              AppImages.icSearch,
                              height: Dimensions.h20,
                              width: Dimensions.w20,
                            ),
                          ),
                        );
                })
          ],
        );
}
