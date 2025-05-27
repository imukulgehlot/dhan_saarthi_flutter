import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';




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
