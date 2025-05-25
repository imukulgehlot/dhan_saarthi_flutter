import 'package:dhan_saarthi/features/dashboard/tabs/charts/controllers/chart_tab_controller.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/watchlist/widgets/mutual_fund_info_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/basic_features.dart';
import '../../../../core/widgets/custom_image.dart' show CustomSvgAssetImage;

class ChartTab extends StatelessWidget {
  const ChartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChartTabController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Row(
            spacing: Dimensions.w8,
            children: [
              CustomSvgAssetImage(
                image: AppImages.icDhanSaarthi,
                size: Dimensions.w25,
              ),
              const Text(AppString.charts),
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
        body: ListView.builder(
          itemCount: controller.mutualFunds.length,
          itemBuilder: (context, index) {
            final fund = controller.mutualFunds[index];

            return MutualFundInfoTile(
              fund: fund,
              onTap: (fund) => controller.navigateToDetails(
                fund,
              ),
            )
                .animate(delay: (index * 50).ms)
                .fade(duration: 300.ms)
                .slideY(begin: 0.2, duration: 300.ms);
          },
        ),
      ),
    );
  }
}
