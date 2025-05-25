import 'package:dhan_saarthi/core/helpers/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../basic_features.dart';
import '../widgets/custom_media_pick_tile.dart';

class MediaPickHelper {
  // Open Sheet with Options (Camera & Gallery)
  static Future<XFile?> selectImageSourceSheet() async {
    return await AppUtils.openCustomBottomSheet(
      sheetBackgroundColor: AppColors.whiteColor,
      contentWidget: Column(
        children: [
          SizedBox(height: Dimensions.h8),
          // Title
          Text(
            AppString.selectType.tr,
            style: fontStyleMedium20,
          ),

          SizedBox(height: Dimensions.h8),

          // Description
          Text(
            AppString.toUploadEventPhotos.tr,
            style: fontStyleRegular15.apply(color: AppColors.textGreyColor),
          ),

          SizedBox(height: Dimensions.h18),

          // Camera
          CustomMediaPickTile(
            title: AppString.takeAPhoto.tr,
            icon: AppImages.icCamera,
            onTap: () async {
              final chosenMedia = await _handleMediaSelection(
                  PermissionHelper.isCameraPermissionGranted,
                  ImageSource.camera);

              Get.back(result: chosenMedia);
            },
          ),

          SizedBox(height: Dimensions.h16),

          // Gallery
          CustomMediaPickTile(
            title: AppString.chooseFromGallery.tr,
            icon: AppImages.icGallery,
            onTap: () async {
              final chosenMedia = await _handleMediaSelection(
                  PermissionHelper.isMediaPermissionGranted,
                  ImageSource.gallery);

              Get.back(result: chosenMedia);
            },
          ),

          SizedBox(height: Dimensions.h22),
        ],
      ),
    );
  }

  // Internal Method for Image Source Sheet
  static Future<XFile?> selectImageOnly(ImageSource imageSource) async {
    try {
      final chosenMedia = await ImagePicker().pickImage(source: imageSource);
      return chosenMedia;
    } catch (e) {
      debugPrint('Error selecting media: $e');
      return null;
    }
  }

  // Permission and Media Selection Helper
  static Future<XFile?> _handleMediaSelection(
      Future<bool> Function() permissionCheck, ImageSource source) async {
    if (await permissionCheck()) {
      return await selectImageOnly(source);
    }
    return null;
  }
}
