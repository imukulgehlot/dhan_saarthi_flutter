import 'package:flutter/material.dart';

import '../basic_features.dart';

class LoginTitle extends StatelessWidget {
  final String titleText;

  const LoginTitle(this.titleText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: fontStyleBold22,
      textAlign: TextAlign.center,
    );
  }
}

class LoginSubTitle extends StatelessWidget {
  final String titleText;

  const LoginSubTitle(this.titleText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: fontStyleMedium15,
      textAlign: TextAlign.center,
    );
  }
}

class TextFormTitle extends StatelessWidget {
  final String titleText;

  const TextFormTitle(this.titleText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: fontStyleMedium15.copyWith(color: AppColors.textTitleColor),
      textAlign: TextAlign.start,
    );
  }
}
