import 'package:dhan_saarthi/core/network/network_constant.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';

import '../../../core/basic_features.dart';

class TAndCAndPrivacyPolicyTile extends StatelessWidget {
  const TAndCAndPrivacyPolicyTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Dimensions.h18,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Text.rich(
          TextSpan(
            style: fontStyleMedium15.copyWith(
              fontSize: Dimensions.sp9,
              color: AppColors.textGreyColor,
            ),
            children: [
              const TextSpan(text: AppString.bySigningIn),
              TextSpan(
                text: AppString.tAndC,
                style: fontStyleMedium15.copyWith(
                  fontSize: Dimensions.sp9,
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => AppUtils.openLink(
                      link: NetworkConstant.termsAndCondition),
              ),
              const TextSpan(text: " ${AppString.and} "),
              TextSpan(
                text: AppString.privacyPolicy,
                style: fontStyleMedium15.copyWith(
                  fontSize: Dimensions.sp9,
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      AppUtils.openLink(link: NetworkConstant.privacyPolicy),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
