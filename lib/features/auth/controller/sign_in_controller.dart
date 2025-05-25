import 'dart:async';

import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/storage/preference_storage.dart';
import 'package:dhan_saarthi/core/utils/logger_util.dart';
import 'package:dhan_saarthi/features/dashboard/dashboard_screen.dart';
import 'package:dhan_saarthi/features/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends GetxController {
  // final phoneTextController = TextEditingController(text: '7062085218');
  final phoneTextController = TextEditingController();
  final otpTextController = TextEditingController();
  final isOTPInvalid = false.obs;
  final otpFocusNode = FocusNode();
  final isPhoneNumberFilled = false.obs;
  final isOTPEntered = false.obs;
  final enableProceedButton = false.obs;
  final isVerificationCodeSent = false.obs;

  // Timer
  final isTimerRunning = false.obs;
  Timer? resendTimer;
  int _resendDurationInSecond = 30;
  final resendDurationText = '30sec'.obs;

  // Start Resend Timer
  Future<void> startResendTimer() async {
    final isSent = await sendOtp(phoneTextController.text);

    if (!isSent) {
      isVerificationCodeSent(false);
      return;
    }
    isTimerRunning.value = true;
    _resendDurationInSecond = 30;
    AppUtils.showSnackBar(
        message: AppString.verificationCodeSentSuccessfully, isSuccess: true);

    resendTimer?.cancel();
    resendTimer = Timer.periodic(1.seconds, (timer) {
      if (_resendDurationInSecond > 0) {
        _resendDurationInSecond--;

        resendDurationText.value = "${_resendDurationInSecond}sec";
      } else {
        isTimerRunning.value = false;
        resendDurationText.value = '30sec';
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();

    isPhoneNumberFilled.listen((isFilled) {
      final enable = !isVerificationCodeSent.value && isFilled;

      if (enable != enableProceedButton.value) {
        enableProceedButton(enable);
      }
    });

    isOTPEntered.listen((isEntered) {
      final enable = isVerificationCodeSent.value && isEntered;

      if (enable != enableProceedButton.value) {
        enableProceedButton(enable);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();

    phoneTextController.dispose();
    otpTextController.dispose();
    otpFocusNode.dispose();
  }

  void onOTPEnter(String value) {
    isOTPInvalid.value = false;
    final isOTPComplete = value.length == 6;
    isOTPEntered(isOTPComplete);
    if (isOTPComplete) {
      otpTextController.text = value;
      AppUtils.closeKeyboard();
      proceedAction();
    }
  }

  // Masked Phone Number
  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 6) return phoneNumber;

    final start = phoneNumber.substring(0, 3);
    final end = phoneNumber.substring(phoneNumber.length - 3);
    final masked = '*' * (phoneNumber.length - 6);
    return '$start$masked$end';
  }

  // Proceed Button Action
  Future<void> proceedAction() async {
    // Sign In
    if (isVerificationCodeSent.value) {
      verifyOtp(phoneTextController.text, otpTextController.text);
    }
    // Send OTP
    else {
      final isValid = isSignInValidated();

      if (isValid) {
        sendOtp(phoneTextController.text).then((isSent) {
          if (isSent) {
            isVerificationCodeSent(true);
            enableProceedButton(false);
          } else {
            isVerificationCodeSent(false);
          }
        });
      }
    }
  }

  // Edit Button
  void editPhoneNumber() {
    isOTPInvalid(false);
    otpTextController.clear();
    isVerificationCodeSent(false);
    resendDurationText.value = '30sec';
    resendTimer?.cancel();
    isTimerRunning(false);
    enableProceedButton(true);
  }

  // Check Sign In Validation
  bool isSignInValidated() {
    if (phoneTextController.text.length != 10) {
      AppUtils.showSnackBar(
        message: AppString.pleaseEnterAValidPhoneNumber,
      );
      return false;
    }

    return true;
  }

  // Navigate To Dashboard Screen
  void navigateToDashboardScreen() => Get.offAll(() => DashboardScreen());

  // Send OTP
  Future<bool> sendOtp(String phoneNumber) async {
    try {
      EasyLoading.show();
      final ok = '+91$phoneNumber';

      logger.t('Phone Number: $ok');

      await Supabase.instance.client.auth.signInWithOtp(
        phone: ok,
      );

      AppUtils.showSnackBar(
          message: "${AppString.otpSentSuccessfully} $phoneNumber",
          isSuccess: true);

      return true;
    } on AuthException catch (e) {
      logger.e(e);
      AppUtils.showSnackBar(message: e.message);
      return false;
    } catch (e) {
      logger.e(e);
      AppUtils.showSnackBar(
          message: AppString.somethingWentWrongWhenSendingOTP);
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    try {
      EasyLoading.show();

      logger.t('Phone Number: $phoneNumber, OTP: $otp');

      final response = await Supabase.instance.client.auth.verifyOTP(
        phone: '+91$phoneNumber',
        token: otp,
        type: OtpType.sms,
      );

      if (response.user != null) {
        await PreferenceStorage.setLoginStatus(true);
        navigateToDashboardScreen();

        AppUtils.showSnackBar(
            message: AppString.signedInSuccessfully, isSuccess: true);
      } else {
        isOTPInvalid(true);
      }
    } catch (e) {
      logger.e(e);
      if (e is AuthException) {
        AppUtils.showSnackBar(message: e.message);
      } else {
        AppUtils.showSnackBar(
            message: AppString.somethingWentWrongWhenVerifyingOTP);
      }
      isOTPInvalid(true);
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Sign Out User
  Future<void> signOutUser() async {
    try {
      EasyLoading.show(status: "Signing out...");
      await Supabase.instance.client.auth.signOut();

      await PreferenceStorage.clearStorage();

      AppUtils.showSnackBar(
          title: AppString.sorryToSeeYouGo,
          message: AppString.signedOutSuccessfully,
          isSuccess: true);

      Get.offAll(OnboardingScreen());
    } catch (e) {
      logger.e("Sign out failed: $e");
      AppUtils.showSnackBar(message: "Something went wrong during sign out!");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
