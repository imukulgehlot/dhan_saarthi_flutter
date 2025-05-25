import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/theme/color_scheme_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final String image;
  final BoxFit? fitType;
  final bool showAppLogoInErrorWidget;
  final bool showBackground;

  const CustomNetworkImage(
      {super.key,
      this.height,
      this.width,
      this.borderRadius,
      required this.image,
      this.fitType,
      this.showBackground = false,
      this.showAppLogoInErrorWidget = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
          fit: fitType ?? BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) => showBackground
              ? Container(
                  decoration: BoxDecoration(
                      color: AppColors.dateContainer.withValues(
                          alpha: Get.theme.brightness == Brightness.light
                              ? 0.05
                              : 0.2)),
                  height: height,
                  width: width ?? double.infinity,
                  child: const Center(
                      child: CupertinoActivityIndicator(
                    radius: 10,
                  )),
                )
              : const Center(
                  child: CupertinoActivityIndicator(
                  radius: 10,
                )),
          errorWidget: (context, url, error) => Container(
                color: AppColors.greyColor,
                child: showAppLogoInErrorWidget
                    ? Padding(
                        padding: EdgeInsets.all(Dimensions.w20),
                        child: Image.asset(
                          AppImages.icAppLogo,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.r35,
                            vertical: Dimensions.r33),
                        child: Image.asset(
                          AppImages.noConnection,
                          fit: BoxFit.fill,
                        ),
                      ),
              )),
    );
  }
}

class MyNetworkImage extends StatelessWidget {
  final double height;
  final double radius;
  final double? width;
  final String image;
  final BoxFit? fitType;

  const MyNetworkImage(
      {super.key,
      this.radius = 0,
      required this.height,
      this.width,
      required this.image,
      this.fitType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedNetworkImage(
              fit: fitType ?? BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(
                    radius: 10,
                  )),
              errorWidget: (context, url, error) => Image.asset(
                    AppImages.icAppLogo,
                    fit: BoxFit.fill,
                  )),
        ));
  }
}

class MyCircleNetworkImage extends StatelessWidget {
  final double? radius;
  final String? name;
  final String image;

  const MyCircleNetworkImage({
    super.key,
    this.radius,
    required this.image,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    if (image.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: radius,
        child: CachedNetworkImage(
            fit: BoxFit.fill,
            filterQuality: FilterQuality.none,
            imageBuilder: (context, provider) {
              return CircleAvatar(
                radius: radius,
                backgroundImage: provider,
              );
            },
            imageUrl: image,
            placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                  radius: 10,
                )),
            errorWidget: (context, url, error) => CircleAvatar(
                  radius: radius,
                  backgroundColor: Get.theme.colorScheme.textFieldColor,
                  foregroundColor: Get.theme.colorScheme.textFieldColor,
                  child: Center(
                    child: Text(
                      AppUtils.getInitials(name ?? ''),
                      style: fontStyleSemiBold14.apply(
                          color: Get.theme.colorScheme.hintTextColor
                              .withValues(alpha: 0.8)),
                    ),
                  ),
                )),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Get.theme.colorScheme.textFieldColor,
        foregroundColor: Get.theme.colorScheme.textFieldColor,
        child: Center(
          child: Text(
            AppUtils.getInitials(name ?? ''),
            style: fontStyleSemiBold14.apply(
                color:
                    Get.theme.colorScheme.hintTextColor.withValues(alpha: 0.8)),
          ),
        ),
      );
    }
  }
}

class MyRoundCornerNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final String image;

  const MyRoundCornerNetworkImage({
    super.key,
    required this.height,
    this.width,
    this.radius = 10,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(radius),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    )));
          },
          /*imageBuilder: (context,provider){
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius), child: Image(images: provider,));
          },*/
          imageUrl: image,
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                radius: 10,
              )),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(AppImages.icAppLogo))),
    );
  }
}

class MyRoundCornerAssetImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final Color? imageColor;
  final String image;

  const MyRoundCornerAssetImage({
    super.key,
    required this.height,
    this.width,
    this.imageColor,
    this.radius = 10,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          height: height,
          width: width,
          color: imageColor,
        ));
  }
}

class CustomSvgAssetImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double? size;
  final bool isSVGString;
  final Function? onTap;
  final String image;
  final Color? color;

  const CustomSvgAssetImage({
    super.key,
    this.height,
    this.width,
    this.size,
    this.onTap,
    this.color,
    required this.image,
    this.isSVGString = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap?.call() : null,
      child: isSVGString
          ? SvgPicture.string(
              image,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
              fit: BoxFit.contain,
              height: height ?? size,
              width: width ?? size,
            )
          : SvgPicture.asset(
              image,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
              fit: BoxFit.contain,
              height: height ?? size,
              width: width ?? size,
            ),
    );
  }
}

class CustomAssetImage extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? imageColor;
  final AlignmentGeometry? alignment;
  final Function? onTap;
  final String image;

  const CustomAssetImage({
    super.key,
    this.height,
    this.alignment,
    this.fit,
    this.width,
    this.imageColor,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Image.asset(
        image,
        fit: fit ?? BoxFit.contain,
        height: height,
        width: width,
        color: imageColor,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }
}

class CustomRoundCornerNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final String image;
  final String? nameForInitials;

  const CustomRoundCornerNetworkImage({
    super.key,
    this.height,
    this.width,
    this.radius = 10,
    this.nameForInitials,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: image.isNotEmpty
          ? CachedNetworkImage(
              fit: BoxFit.cover,
              filterQuality: FilterQuality.none,
              imageBuilder: (context, provider) {
                return Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: ColorConst.greyColor, width: 1),
                        borderRadius: BorderRadius.circular(radius),
                        image: DecorationImage(
                          image: provider,
                          fit: BoxFit.cover,
                        )));
              },
              /*imageBuilder: (context,provider){
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius), child: Image(images: provider,));
          },*/
              imageUrl: image,
              placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                    radius: 10,
                  )),
              errorWidget: (context, url, error) => CircleAvatar(
                    radius: radius,
                    backgroundColor: Get.theme.colorScheme.textFieldColor,
                    foregroundColor: Get.theme.colorScheme.textFieldColor,
                    child: Center(
                      child: Text(
                        AppUtils.getInitials(nameForInitials ?? ''),
                        style: fontStyleSemiBold14.apply(
                            color: Get.theme.colorScheme.hintTextColor
                                .withValues(alpha: 0.8)),
                      ),
                    ),
                  ))
          : CircleAvatar(
              radius: radius,
              backgroundColor: Get.theme.colorScheme.textFieldColor,
              foregroundColor: Get.theme.colorScheme.textFieldColor,
              child: Center(
                child: Text(
                  AppUtils.getInitials(nameForInitials ?? ''),
                  style: fontStyleSemiBold14.apply(
                      color: Get.theme.colorScheme.hintTextColor
                          .withValues(alpha: 0.8)),
                ),
              ),
            ),
    );
  }
}
