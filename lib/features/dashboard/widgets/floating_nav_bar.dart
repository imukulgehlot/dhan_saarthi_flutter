import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/basic_features.dart';

class NavBar extends StatelessWidget {
  final List<NavItem> items;
  final int selectedIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
      margin: EdgeInsets.only(bottom: Dimensions.h5),
      decoration: BoxDecoration(
        color: AppColors.backgroundColorDark,
        border: Border(
            bottom: BorderSide(color: AppColors.borderColor, width: 0.3),
            top: BorderSide(color: AppColors.borderColor, width: 0.3)),
      ),

      // Bottom Nav
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Dimensions.w50,
        children: List.generate(items.length, (index) {
          final isSelected = selectedIndex == index;
          final item = items[index];

          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(Dimensions.r100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 340),
              padding: EdgeInsets.all(Dimensions.w6),
              child:
                  // Actual icon and label
                  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: CustomSvgAssetImage(
                      key: ValueKey(isSelected),
                      image: item.icon,
                      width: Dimensions.w20,
                      height: Dimensions.w20,
                      color: isSelected ? AppColors.primaryColor : null,
                    ),
                  ),
                  SizedBox(height: Dimensions.h6),
                  Text(
                    item.label,
                    style: fontStyleMedium10.copyWith(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.textGreyColor,
                      fontWeight:
                          isSelected ? FontAsset.bold : FontAsset.regular,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    )
            .animate()
            .slideY(
              begin: 0.3, // subtle entrance from below
              end: 0.0,
              curve: Curves.easeOutBack,
              duration: const Duration(milliseconds: 900),
            )
            .fadeIn(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            )
            .scaleXY(
              begin: 0.85,
              end: 1.0,
              curve: Curves.easeOutExpo,
              duration: const Duration(milliseconds: 1100),
            ));
  }
}

class NavItem {
  final String icon;
  final String label;

  NavItem({
    required this.icon,
    required this.label,
  });
}
