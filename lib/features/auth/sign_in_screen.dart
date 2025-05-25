import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/widgets/common/background_art.dart';
import 'package:dhan_saarthi/features/auth/controller/sign_in_controller.dart';
import 'package:dhan_saarthi/features/auth/widgets/sign_in_content.dart';
import 'package:dhan_saarthi/features/auth/widgets/t_and_c_and_privacy_policy_tile.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SignInController(),
      builder: (controller) => Scaffold(
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              // Background Image
              BackgroundArt(),

              // Sign In Screen Content
              SignInContent(
                controller: controller,
              ),

              // TC & PP
              TAndCAndPrivacyPolicyTile(),
            ],
          ),
        ),
      ),
    );
  }
}
