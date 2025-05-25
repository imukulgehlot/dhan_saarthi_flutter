// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../basic_features.dart';
//
// AuthCredential? phoneAuthCredential;
// FirebaseAuth auth = FirebaseAuth.instance;
//
// Future firebaseSendOtp({
//   required BuildContext context,
//   required String countryCode,
//   required String phoneNo,
//   required Function onOTPSent,
// }) async {
//   EasyLoading.show();
//
//   if (kDebugMode) {
//     print('$countryCode$phoneNo');
//   }
//
//   smsOTPSent(String? verId, _) {
//     EasyLoading.dismiss();
//     if (kDebugMode) {
//       print("verId------login==>$verId");
//       AppUtils.showToast('The verification code has been sent');
//     }
//     onOTPSent(verId);
//   }
//
//   try {
//     await auth.verifyPhoneNumber(
//         phoneNumber: '$countryCode$phoneNo',
//         // PHONE NUMBER TO SEND OTP
//         codeAutoRetrievalTimeout: (String verId) {
//           EasyLoading.dismiss();
//           // verificationId(verId);
//
//           if (kDebugMode) {
//             print("verId====login====>$verId");
//           }
//         },
//         codeSent: smsOTPSent,
//         // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
//         timeout: const Duration(seconds: 59),
//         verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
//           if (kDebugMode) {
//             print("smsCode=====login====*${phoneAuthCredential.smsCode}");
//           }
//         },
//         verificationFailed: (FirebaseAuthException exception) {
//           EasyLoading.dismiss();
//
//           if (kDebugMode) {
//             print("verificationFailed::::");
//             print(exception.message);
//           }
//           if (exception.message!.contains('not authorized')) {
//             AppUtils.showToast('Something Went Wrong');
//           } else if (exception.message!.contains('network')) {
//             AppUtils.showToast('Check Internet Connection');
//           } else {
//             AppUtils.showToast(exception.message.toString().split(".").first);
//             if (kDebugMode) {
//               print(exception.message);
//             }
//           }
//         });
//   } catch (exception) {
//     EasyLoading.dismiss();
//     if (kDebugMode) {
//       print(exception.toString());
//     }
//     AppUtils.showToast(exception.toString());
//   }
// }
//
// Future firebaseOtpVerify({
//   required BuildContext context,
//   required String otp,
//   required String verificationId,
//   required Function onFail,
//   required Function onSuccess,
// }) async {
//   EasyLoading.show();
//
//   // handleError(PlatformException error) {
//   //   switch (error.code) {
//   //     case 'ERROR_INVALID_VERIFICATION_CODE':
//   //       FocusScope.of(context).requestFocus(FocusNode());
//   //       onFail();
//   //       Const.showToast(AppString.invalidOTP);
//   //       break;
//   //     default:
//   //       onFail();
//   //       Const.showToast(AppString.invalidOTP);
//   //       break;
//   //   }
//   // }
//
//   success() async {
//     try {
//       await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential!);
//       if (kDebugMode) {
//         AppUtils.showToast("OTP verify successfully");
//       }
//       EasyLoading.dismiss();
//       onSuccess(true);
//     } catch (e) {
//       onFail();
//       if (kDebugMode) {
//         print('Error ${e.toString()}');
//       }
//       AppUtils.showToast(AppString.invalidOTP);
//       EasyLoading.dismiss();
//     } finally {}
//   }
//
//   try {
//     phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: verificationId, smsCode: otp);
//     success();
//   } catch (e) {
//     onFail();
//     EasyLoading.show();
//
//     // handleError(e);
//     if (kDebugMode) {
//       print('CATCH ERROR $e');
//     }
//   }
// }
