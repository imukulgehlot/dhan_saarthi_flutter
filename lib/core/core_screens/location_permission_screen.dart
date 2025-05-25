import 'package:flutter/material.dart';

import '../basic_features.dart';
import '../widgets/custom_image.dart';

class LocationPermissionScreen extends StatelessWidget {
  final bool isLocationMandatory;

  const LocationPermissionScreen({super.key, this.isLocationMandatory = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
        child: Column(
          children: [
            // Location Text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: AppString.locationTitle.tr,
                  children: [
                    TextSpan(
                        text: AppString.locationSubtitle.tr,
                        style: fontStyleBold18.apply(
                            color: AppColors.primaryColor))
                  ],
                  style: fontStyleSemiBold18.apply(
                    color: AppColors.primaryLightColor,
                  )),
            ),

            // Location SVG
            CustomSvgAssetImage(
              image: AppImages.icLocationPermission,
              height: Get.height * 0.50,
              width: Get.width,
            ),

            // Allow Button
            MyOutLineButton(
              title: AppString.allowAccess.tr,
              onPressed: () async => await AppUtils.getCurrentLocation(),
              borderWidth: Dimensions.w2,
              cornerRadius: Dimensions.r10,
              btnBgColor: Colors.transparent,
              height: Dimensions.h35,
              miniWidth: Dimensions.w145,
              borderColor: AppColors.primaryColor,
              textStyle:
                  fontStyleSemiBold13.copyWith(color: AppColors.primaryColor),
            ),
            const Spacer(),

            // Next Button
            Hero(
                tag: "signInToIntro",
                transitionOnUserGestures: true,
                child: MyButton(
                    title: AppString.next.tr,
                    // On Successful Status Update, navigating to Home
                    onPressed: () async {
                      // When Location Ain't Required
                      if (isLocationMandatory == false) {
                      }
                      // When Location is Required and Allowed
                      else if (isLocationMandatory &&
                          await AppUtils.haveLocationPermission(
                              requestPermission: false)) {
                      }
                      // When Location is Required & Not Allowed
                      else {
                        AppUtils.showSnackBar(
                            message: AppString.locationPermissionDesc.tr);
                      }
                    })),
            SizedBox(
              height: Dimensions.h20,
            )
          ],
        ),
      ),
    );
  }
}
