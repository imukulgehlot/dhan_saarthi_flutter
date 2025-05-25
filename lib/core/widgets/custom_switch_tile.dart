import 'package:dhan_saarthi/core/theme/color_scheme_extension.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final RxBool currentValue;

  const CustomSwitchTile(
      {super.key, required this.title, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => currentValue.value = !currentValue.value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Text(
            title,
            style:
                fontStyleMedium14.apply(color: Get.theme.colorScheme.textColor),
          ),

          // Switch
          SizedBox(
            height: Dimensions.h28,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Obx(
                () => Switch(
                  trackOutlineColor: WidgetStateColor.resolveWith(
                      (states) => Colors.transparent),
                  thumbColor: WidgetStateColor.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? AppColors.primaryColor
                          : AppColors.greyColor),
                  activeTrackColor: AppColors.primaryLightColor,
                  value: currentValue.value,
                  onChanged: (value) {
                    currentValue.value = !currentValue.value;
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
