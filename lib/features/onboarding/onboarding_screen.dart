import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/widgets/common/background_art.dart';
import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:dhan_saarthi/features/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void navigateToSignInScreen() => Get.off(() => SignInScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          BackgroundArt(),

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Dimensions.h24,
              children: [
                CustomSvgAssetImage(
                  image: AppImages.icDhanSaarthi,
                  size: Dimensions.w130,
                ),
                Text(
                  AppString.welcomeToDhanSaarthi,
                  style: fontStyleSemiBold21,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 1200.ms, curve: Curves.easeInOut),
              ],
            ),
          ),

          // Proceed Button
          Positioned(
            bottom: Dimensions.h18,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // One Step Closer Text
                    Text(
                      AppString.oneStepCloserToInvesting,
                      style: fontStyleRegular12.apply(
                        color: AppColors.greyText,
                      ),
                      maxLines: 2,
                    ).animate().fadeIn(
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                        delay: 500.ms),

                    // Button to proceed
                    MyButton(
                      height: Dimensions.w45,
                      miniWidth: Dimensions.w45,
                      outlinedBorder: CircleBorder(),
                      onPressed: navigateToSignInScreen,
                      child: CustomSvgAssetImage(
                        image: AppImages.icForwardArrow,
                        width: Dimensions.w45,
                        height: Dimensions.w45,
                      ),
                    )
                        .animate()
                        .scale(
                            curve: Curves.ease, delay: 800.ms, duration: 500.ms)
                        .rotate(
                            curve: Curves.ease,
                            delay: 800.ms,
                            duration: 700.ms),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
