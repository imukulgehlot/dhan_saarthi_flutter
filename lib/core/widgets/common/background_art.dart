import 'package:dhan_saarthi/core/constants/app_colors.dart';
import 'package:dhan_saarthi/core/constants/app_images.dart';
import 'package:dhan_saarthi/core/widgets/custom_image.dart'
    show CustomAssetImage;
import 'package:flutter/material.dart';

class BackgroundArt extends StatelessWidget {
  const BackgroundArt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 5.5,
      child: FractionalTranslation(
        translation: Offset(-0.0750, -0.10),
        child: CustomAssetImage(
          image: AppImages.imgBackground,
          imageColor: AppColors.backgroundColor.withValues(alpha: 0.008),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
