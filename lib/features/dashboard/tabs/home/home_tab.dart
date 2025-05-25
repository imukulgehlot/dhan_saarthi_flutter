import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: Dimensions.w8,
          children: [
            CustomSvgAssetImage(
              image: AppImages.icDhanSaarthi,
              size: Dimensions.w25,
            ),
            const Text(AppString.home),
          ],
        ),
        actions: [
          IconButton(
            onPressed: AppUtils.showSignOutDialogue,
            icon: Icon(
              CupertinoIcons.power,
              size: Dimensions.w25,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Just Home Tab!',
          style: fontStyleRegular15,
        ),
      ),
    );
  }
}
