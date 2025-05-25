import 'package:flutter/material.dart';

import '../basic_features.dart';
import 'custom_image.dart';

class CustomMediaPickTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;

  const CustomMediaPickTile(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});

  get borderRadius => BorderRadius.circular(Dimensions.commonRadius);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.commonPaddingForScreen,
                vertical: Dimensions.w16),
            child: Row(
              children: [
                CustomSvgAssetImage(
                  image: icon,
                  width: Dimensions.w25,
                  height: Dimensions.w25,
                ),
                SizedBox(width: Dimensions.w10),
                Text(title, style: fontStyleRegular16),
                Spacer(),
                CustomSvgAssetImage(
                  image: AppImages.icBackArrow,
                  width: Dimensions.w20,
                  height: Dimensions.w20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
