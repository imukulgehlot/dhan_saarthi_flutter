import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../basic_features.dart';
import '../custom_image.dart';
import '../custom_rich_text_widget.dart';

class AppLogoWithTitle extends StatelessWidget {
  final bool showTagline;
  final bool heroEffect;
  final bool showAppLogo;
  final bool haveCommonHorizontalPadding;
  final bool showTitle;
  final FontWeight? titleFontWeight;
  final double? iconSize;
  final double? gapBetweenLogoAndTitle;
  final double? fontSizeTitle;
  final double? fontSizeTagline;

  const AppLogoWithTitle({
    super.key,
    this.showAppLogo = true,
    this.haveCommonHorizontalPadding = false,
    this.showTagline = false,
    this.titleFontWeight,
    this.iconSize,
    this.fontSizeTitle,
    this.fontSizeTagline,
    this.showTitle = true,
    this.heroEffect = false,
    this.gapBetweenLogoAndTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize:
          showTitle || showTagline ? MainAxisSize.max : MainAxisSize.min,
      children: [
        heroEffect
            ? Hero(
                tag: AppString.appName,
                child: _AppLogoWithTitleTile(
                  showTitle: showTitle,
                  titleFontWeight: titleFontWeight,
                  showTagline: showTagline,
                  showAppLogo: showAppLogo,
                  gapBetweenLogoAndTitle: gapBetweenLogoAndTitle,
                  iconSize: iconSize,
                  fontSizeTitle: fontSizeTitle,
                ),
              )
            : _AppLogoWithTitleTile(
                showTitle: showTitle,
                titleFontWeight: titleFontWeight,
                showTagline: showTagline,
                showAppLogo: showAppLogo,
                gapBetweenLogoAndTitle: gapBetweenLogoAndTitle,
                iconSize: iconSize,
                fontSizeTitle: fontSizeTitle,
              ),

        // Tagline
        Offstage(
          offstage: !showTagline,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: haveCommonHorizontalPadding
                  ? Dimensions.w60 - Dimensions.commonPaddingForScreen
                  : Dimensions.w63,
            ).copyWith(top: Dimensions.h3),
            child: Text(
              AppString.appName,
              textAlign: TextAlign.center,
              style: fontStyleLight14.copyWith(
                fontSize: fontSizeTagline ?? Dimensions.sp15,
                color: AppColors.tagLineGreyColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppLogoWithTitleTile extends StatelessWidget {
  const _AppLogoWithTitleTile({
    required this.showTitle,
    required this.showTagline,
    required this.showAppLogo,
    required this.titleFontWeight,
    required this.gapBetweenLogoAndTitle,
    required this.iconSize,
    required this.fontSizeTitle,
  });

  final bool showTitle;
  final bool showTagline;
  final bool showAppLogo;
  final FontWeight? titleFontWeight;
  final double? gapBetweenLogoAndTitle;
  final double? iconSize;
  final double? fontSizeTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          showTitle || showTagline ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App Logo
        Offstage(
          offstage: !showAppLogo,
          child: Padding(
            padding: (showTitle || showTagline)
                ? EdgeInsets.only(
                    bottom: gapBetweenLogoAndTitle ?? Dimensions.h15)
                : EdgeInsets.zero,
            child: CustomSvgAssetImage(
              image: AppImages.icAppLogo,
              width: iconSize ?? Dimensions.w120,
              height: iconSize ?? Dimensions.w120,
            ),
          ),
        ),

        // Title
        Offstage(
          offstage: !showTitle,
          child: CustomRichTextWidget.getDualText(
            firstText: AppString.appName,
            secondText: AppString.appName,
            firstTextStyle: fontStyleSemiBold16.copyWith(
              color: AppColors.appNameBlackColor,
              fontWeight: titleFontWeight,
              fontSize: fontSizeTitle ?? 27.sp,
            ),
            secondTextStyle: fontStyleSemiBold16.copyWith(
              color: AppColors.primaryColor,
              fontWeight: titleFontWeight,
              fontSize: fontSizeTitle ?? 27.sp,
            ),
          ),
        ),
      ],
    );
  }
}
