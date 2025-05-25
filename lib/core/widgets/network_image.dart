import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';
import '../utils/shimmer_effect.dart';

class MyNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;
  final String image;
  final BoxFit? fitType;

  const MyNetworkImage(
      {super.key,
      this.borderRadius = 0,
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
          borderRadius: BorderRadius.circular(borderRadius),
          child: CachedNetworkImage(
              fit: fitType ?? BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.shimmerHighLightColor,
                    child: Container(
                      height: height,
                      color: AppColors.primaryColor,
                    ),
                  ),
              errorWidget: (context, url, error) => Image.asset(
                    AppImages.icAppLogo,
                    fit: BoxFit.fill,
                  )),
        ));
  }
}

class MyCircleNetworkImage extends StatelessWidget {
  final double? radius;
  final String image;

  const MyCircleNetworkImage({
    super.key,
    this.radius,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
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
          placeholder: (context, url) => Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighLightColor,
              child: CircleAvatar(
                radius: radius,
              )),
          errorWidget: (context, url, error) => CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage(AppImages.icAppLogo))),
    );
  }
}

class MyRoundCornerNetworkImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final int cacheWidth;
  final String image;

  const MyRoundCornerNetworkImage({
    super.key,
    required this.height,
    this.cacheWidth = 200,
    required this.width,
    this.radius = 8,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          memCacheWidth: cacheWidth,
          height: height,
          width: width,
          filterQuality: FilterQuality.none,
          imageUrl: image,
          placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighLightColor,
                child: Container(
                  height: 280,
                  color: AppColors.primaryColor,
                ),
              ),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(AppImages.icAppLogo))),
    );
  }
}

class MyRoundCornerFileImage extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  final String image;

  const MyRoundCornerFileImage({
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
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor, width: 0.5),
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                  image: FileImage(File(image)),
                  fit: BoxFit.cover,
                ))));
  }
}
