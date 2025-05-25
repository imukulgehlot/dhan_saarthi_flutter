import 'package:flutter/material.dart';

import '../../../../../core/basic_features.dart';
import '../controllers/watchlist_controller.dart';

class WatchListChips extends StatelessWidget {
  final WatchlistController controller;

  const WatchListChips({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.h8,
        ),
        child: SizedBox(
          height: Dimensions.h28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
            itemCount: controller.watchlistItems.length,
            itemBuilder: (context, index) {
              return Obx(() {
                final isSelected =
                    index == controller.selectedWatchListIndex.value;

                return GestureDetector(
                  onTap: () => controller.selectedWatchListIndex.value = index,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: Dimensions.w1,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.borderColor),
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.backgroundColorDark,
                      borderRadius: BorderRadius.circular(Dimensions.r8),
                    ),
                    child: Center(
                      child: Text(
                        controller.watchlistItems[index].entries.firstOrNull
                                ?.key ??
                            '',
                        style: fontStyleMedium12.copyWith(
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
