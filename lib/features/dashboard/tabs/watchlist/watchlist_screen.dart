import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/watchlist/widgets/mutual_fund_info_tile.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/watchlist/widgets/watchlist_chips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/basic_features.dart';
import 'controllers/watchlist_controller.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WatchlistController(),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Row(
              spacing: Dimensions.w8,
              children: [
                CustomSvgAssetImage(
                  image: AppImages.icDhanSaarthi,
                  size: Dimensions.w25,
                ),
                const Text(AppString.watchlist),
              ],
            ),
            actions: [
              IconButton(
                onPressed: AppUtils.showSignOutDialogue,
                icon: Icon(
                  CupertinoIcons.power,
                  size: Dimensions.w25,
                ),
              ),
            ],
          ),
          body: Obx(
            () => CustomScrollView(
              slivers: [
                // Watchlist Chips
                WatchListChips(
                  controller: controller,
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.h18,
                  ),
                ),

                // Add Mutual Fund Button
                if (controller
                        .watchlistItems[controller.selectedWatchListIndex.value]
                        .entries
                        .firstOrNull
                        ?.value
                        .isNotEmpty ??
                    false)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.commonPaddingForScreen),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: AppUtils.featureUnderDevelopment,
                            borderRadius:
                                BorderRadius.circular(Dimensions.commonRadius),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.h6,
                                  horizontal: Dimensions.w8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomSvgAssetImage(
                                    image: AppImages.icAdd,
                                    size: Dimensions.w20,
                                  ),
                                  SizedBox(width: Dimensions.w5),
                                  Text(
                                    AppString.add,
                                    style: fontStyleSemiBold14.apply(
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Watchlist Funds
                controller
                        .watchlistItems[controller.selectedWatchListIndex.value]
                        .entries
                        .firstOrNull!
                        .value
                        .isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: controller
                              .watchlistItems[
                                  controller.selectedWatchListIndex.value]
                              .entries
                              .firstOrNull
                              ?.value
                              .length,
                          (context, index) {
                            final fund = controller
                                .watchlistItems[
                                    controller.selectedWatchListIndex.value]
                                .entries
                                .firstOrNull
                                ?.value[index];

                            return MutualFundInfoTile(
                              fund: fund,
                              onDelete: () {},
                            )
                                .animate(delay: (index * 50).ms)
                                .fade(duration: 300.ms)
                                .slideY(begin: 0.2, duration: 300.ms);
                          },
                        ),
                      )
                    : SliverFillRemaining(
                        child: Center(
                          child: Column(
                            spacing: Dimensions.h20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Empty State Icon
                              CustomSvgAssetImage(
                                  image: AppImages.icEmptyWatchlist),

                              // Add Button
                              FractionallySizedBox(
                                widthFactor: 0.5,
                                child: MyButton(
                                  height: Dimensions.h30,
                                  onPressed: null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: Dimensions.w5,
                                    children: [
                                      Text(
                                        AppString.addSymbol,
                                        style: fontStyleMedium12.copyWith(
                                            fontSize: Dimensions.sp20),
                                      ),
                                      Text(
                                        AppString.addMutualFund,
                                        style: fontStyleMedium12,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
          floatingActionButton: MyButton(
            miniWidth: Dimensions.w120,
            cornerRadius: Dimensions.r80,
            onPressed: AppUtils.featureUnderDevelopment,
            child: Row(
              spacing: Dimensions.w5,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSvgAssetImage(
                  image: AppImages.icAdd,
                  size: Dimensions.w12,
                  color: AppColors.whiteColor,
                ),
                Text(
                  AppString.watchlist,
                  style: fontStyleMedium10,
                ),
              ],
            ),
          )),
    );
  }
}
