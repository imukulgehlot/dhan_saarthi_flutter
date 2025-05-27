import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:dhan_saarthi/core/widgets/text_field/my_text_field.dart';
import 'package:dhan_saarthi/features/auth/controller/sign_in_controller.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../../core/basic_features.dart';

class SignInContent extends StatelessWidget {
  final SignInController controller;

  const SignInContent({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.commonPaddingForScreen),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.h30),
              // Title
              Text(
                AppString.welcomeBackWeMissedYou,
                style: fontStyleSemiBold22.copyWith(
                    height: 1.2, fontSize: Dimensions.sp23),
              ),
              SizedBox(height: Dimensions.h4),
              // Subtitle
              Wrap(
                children: [
                  Text(
                    AppString.gladToHaveYouBack,
                    style: fontStyleMedium14,
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.gradientBeginColor,
                        AppColors.gradientEndColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      AppString.dhanSpaceSaarthi,
                      style: fontStyleMedium13,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.h50,
              ),

              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.3, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: controller.isVerificationCodeSent.value
                    ? Column(
                        key: ValueKey('otpView'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.enterOTP, style: fontStyleMedium14),
                          SizedBox(height: Dimensions.h20),

                          // Pin Field for OTP
                          PinInputTextField(
                            pinLength: 6,
                            focusNode: controller.otpFocusNode,
                            decoration: UnderlineDecoration(
                              textStyle: fontStyleRegular16,
                              colorBuilder: PinListenColorBuilder(
                                controller.isOTPInvalid.value
                                    ? AppColors.redTextColor
                                    : AppColors.primaryColor,
                                AppColors.borderColor,
                              ),
                              lineHeight: Dimensions.h2,
                              gapSpace: Dimensions.w35,
                              lineStrokeCap: StrokeCap.round,
                            ),
                            cursor: Cursor(
                              width: 1.2,
                              height: Dimensions.h15,
                              color: AppColors.primaryColor,
                              radius: Radius.circular(Dimensions.r2),
                              enabled: true,
                            ),
                            controller: controller.otpTextController,
                            autoFocus: true,
                            textInputAction: TextInputAction.go,
                            onChanged: controller.onOTPEnter,
                          ),
                          SizedBox(
                            height: Dimensions.h20,
                          ),

                          // Invalid OTP message
                          if (controller.isOTPInvalid.value)
                            Text(
                              AppString.invalidOTP,
                              style: fontStyleRegular12.apply(
                                color: AppColors.redTextColor,
                              ),
                            ).animate().shake(),
                          SizedBox(height: Dimensions.h8),

                          // Didn't Receive OTP | Resend || Timer | Disabled Resend
                          Text.rich(
                            TextSpan(
                              text: controller.isTimerRunning.value
                                  ? controller.resendDurationText.value
                                  : AppString.didNotReceiveOTP,
                              style: fontStyleRegular12,
                              children: [
                                TextSpan(
                                  text: AppString.resend,
                                  style: fontStyleRegular12.copyWith(
                                    color: controller.isTimerRunning.value
                                        ? AppColors.disabledButtonColor
                                        : AppColors.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = controller.startResendTimer,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.h8),
                          Wrap(
                            children: [
                              Text(
                                '${AppString.otpHasBeenSentOn}${controller.maskPhoneNumber(controller.phoneTextController.text)}',
                                style: fontStyleRegular12.apply(
                                  color: AppColors.greyText,
                                ),
                              ),
                              SizedBox(width: Dimensions.w5),
                              CustomSvgAssetImage(
                                onTap: controller.editPhoneNumber,
                                image: AppImages.icEditPencil,
                                size: Dimensions.h15,
                              )
                            ],
                          ),
                        ],
                      )
                    : MyTextField(
                        key: ValueKey('phoneInput'),
                        // Important for switch animation
                        titleTopPadding: Dimensions.h15,
                        maxLength: 10,
                        title: AppString.enterYourPhoneNumber,
                        textController: controller.phoneTextController,
                        textInputType: TextInputType.phone,
                        onChanged: (value) {
                          final isEmpty = value.isNotEmpty;
                          if (isEmpty != controller.isPhoneNumberFilled.value) {
                            controller.isPhoneNumberFilled.value = isEmpty;
                          }
                        },
                        prefixIcon: Text(
                          '+91',
                          style: fontStyleSemiBold15,
                        ),
                        onFieldSubmitted: (_) =>
                            controller.isPhoneNumberFilled.value
                                ? controller.proceedAction
                                : null,
                        hintText: AppString.demoMobileNumber,
                      ),
              ),

              // Proceed Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w40)
                    .copyWith(top: Dimensions.h40),
                child: Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => MyButton(
                      onPressed: controller.enableProceedButton.value
                          ? controller.proceedAction
                          : null,
                      title: AppString.proceed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
