import 'package:dhan_saarthi/core/model/ui_model/mutual_fund_model.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/watchlist/widgets/time_and_percent_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/basic_features.dart';

class MutualFundInfoTile extends StatelessWidget {
  const MutualFundInfoTile({
    super.key,
    required this.fund,
    this.onTap,
    this.onDelete,
  });

  final Function(MutualFundModel? fund)? onTap;
  final Function()? onDelete;
  final MutualFundModel? fund;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(Dimensions.commonRadius);

    final content = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => onTap?.call(fund),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.textFieldColor,
            borderRadius: borderRadius,
            border: Border.all(
              width: Dimensions.commonBorderWidth,
              color: AppColors.borderColor,
            ),
          ),
          padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
          child: Column(
            children: [
              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      fund?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: fontStyleSemiBold14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${AppString.nav} ',
                        style: fontStyleSemiBold12.apply(
                          color: AppColors.greyHighlightColor,
                        ),
                      ),
                      Text(
                        '₹${fund?.nav ?? '0.00'}',
                        style: fontStyleSemiBold12.apply(
                          color: AppColors.whiteHighlightColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h4),

              // Subtitle + 1D
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.othersFundsOfFunds,
                    style: fontStyleRegular12.apply(
                      color: AppColors.greyHighlightColor,
                    ),
                  ),
                  TimeAndPercentText(),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.h10,
                  bottom: Dimensions.h5,
                ),
                child: MyDivider(),
              ),

              // Bottom Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeAndPercentText(
                    time: AppString.oneY,
                    percent: fund?.oneYearPercent ?? '0.00',
                  ),
                  TimeAndPercentText(
                    time: AppString.threeY,
                    percent: fund?.threeYearPercent ?? '0.00',
                  ),
                  TimeAndPercentText(
                    time: AppString.fiveY,
                    percent: fund?.fiveYearPercent ?? '0.00',
                  ),
                  Row(
                    children: [
                      Text(
                        '${AppString.expRatio} ',
                        style: fontStyleSemiBold12.apply(
                          color: AppColors.greyHighlightColor,
                        ),
                      ),
                      Text(
                        '${fund?.expRatio ?? '0.00'}%',
                        style: fontStyleSemiBold12.apply(
                          color: AppColors.whiteHighlightColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final dismissibleTile = onDelete != null
        ? ClipRRect(
            borderRadius: borderRadius,
            child: Dismissible(
              key: ValueKey(fund?.name ?? fund.hashCode),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => onDelete?.call(),
              background: Container(
                color: AppColors.lossRedColor,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: content,
            ),
          )
        : content;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.commonPaddingForScreen,
        vertical: Dimensions.h7,
      ),
      child: dismissibleTile,
    );
  }
}
