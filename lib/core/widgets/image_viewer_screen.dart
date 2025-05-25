import 'dart:io';

import 'package:dhan_saarthi/core/theme/color_scheme_extension.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';
import 'custom_image.dart';

class ImageViewScreen extends StatelessWidget {
  final String image;

  const ImageViewScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: Dimensions.w28,
          icon: CustomSvgAssetImage(
              image: AppImages.icBackArrowNav,
              width: Dimensions.w28,
              height: Dimensions.h28,
              color: Theme.of(context).colorScheme.textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SizedBox(
        height: Get.height - (kToolbarHeight + kBottomNavigationBarHeight),
        child: Center(
          child: Hero(
            tag: image,
            child: InteractiveViewer(
                alignment: Alignment.center,
                child: image.isURL
                    ? CustomNetworkImage(
                        image: image,
                        width: double.infinity,
                        fitType: BoxFit.cover,
                      )
                    : Image.file(
                        File(
                          image,
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
          ),
        ),
      ),
    );
  }
}
