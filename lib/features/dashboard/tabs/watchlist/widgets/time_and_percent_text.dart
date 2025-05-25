import 'package:dhan_saarthi/core/constants/app_colors.dart';
import 'package:dhan_saarthi/core/utils/style.dart';
import 'package:flutter/material.dart';

class TimeAndPercentText extends StatelessWidget {
  final String time;
  final String percent;

  const TimeAndPercentText(
      {super.key, this.time = '1D', this.percent = "1.39"});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$time ',
          style: fontStyleRegular12.apply(
            color: AppColors.greyHighlightColor,
          ),
        ),
        Text(
          '$percent%',
          style: fontStyleRegular12.apply(
            color: AppColors.greenHighlightColor,
          ),
        ),
      ],
    );
  }
}
