import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/charts/widgets/line_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../core/basic_features.dart';
import '../widgets/bar_chart.dart';
import 'controllers/chart_detail_controller.dart';

class ChartsDetailScreen extends StatelessWidget {
  final String fundName;

  const ChartsDetailScreen({super.key, required this.fundName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChartDetailController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: Get.back,
              icon: CustomSvgAssetImage(
                image: AppImages.icBackArrow,
                size: Dimensions.w20,
              )),
          actions: [
            IconButton(
                onPressed: () => controller.toggleBookmark(),
                icon: Obx(
                  () => CustomSvgAssetImage(
                    image: controller.icBookmarked.value
                        ? AppImages.icBookmarked
                        : AppImages.icBookmark,
                    size: Dimensions.w30,
                  ),
                )),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                child: Text(
                  fundName,
                  style: fontStyleBold20,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              Row(
                spacing: Dimensions.w5,
                children: [
                  Row(
                    children: [
                      Text(
                        "${AppString.nav} ",
                        style: fontStyleRegular13.apply(
                            color: AppColors.hintColor),
                      ),
                      Text(
                        "₹ 104.2",
                        style: fontStyleRegular14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.h20,
                    child: VerticalDivider(
                      color: AppColors.dividerColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "1D ",
                        style: fontStyleRegular13.apply(
                            color: AppColors.hintColor),
                      ),
                      Text(
                        "₹ -4.7",
                        style: fontStyleRegular14,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      CustomSvgAssetImage(
                        image: AppImages.icDownArrow,
                        size: Dimensions.w15,
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      Text(
                        "-3.7",
                        style: fontStyleRegular14.apply(
                            color: AppColors.lossRedColor),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.h20,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.h10, horizontal: Dimensions.w5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.dividerColor.withValues(alpha: 0.5),
                        width: 0.8),
                    borderRadius: BorderRadius.circular(Dimensions.r5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppString.invested,
                          style: fontStyleRegular12.apply(
                              color: AppColors.hintColor),
                        ),
                        Text(
                          "₹ 1.5k",
                          style: fontStyleSemiBold13,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.h25,
                      child: VerticalDivider(
                        color: AppColors.dividerColor,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          AppString.currentValue,
                          style: fontStyleRegular12.apply(
                              color: AppColors.hintColor),
                        ),
                        Text(
                          "₹ 1.28k",
                          style: fontStyleSemiBold13,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.h25,
                      child: VerticalDivider(
                        color: AppColors.dividerColor,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          AppString.totalGain,
                          style: fontStyleRegular12.apply(
                              color: AppColors.hintColor),
                        ),
                        Row(
                          children: [
                            Text(
                              "₹-220.16k",
                              style: fontStyleSemiBold13,
                            ),
                            SizedBox(
                              width: Dimensions.w5,
                            ),
                            CustomSvgAssetImage(
                              image: AppImages.icDownArrow,
                              size: Dimensions.w15,
                            ),
                            SizedBox(
                              width: Dimensions.w5,
                            ),
                            Text(
                              "-3.7",
                              style: fontStyleSemiBold13.apply(
                                  color: AppColors.lossRedColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h20,
              ),
              Chart(),
              SizedBox(
                height: Dimensions.h20,
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.all(Dimensions.w15),
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    border:
                        Border.all(color: AppColors.dividerColor, width: 0.5),
                    borderRadius: BorderRadius.circular(Dimensions.r8)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppString.ifYouInvested,
                              style: fontStyleSemiBold12,
                            ),
                            SizedBox(
                              width: Dimensions.w10,
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: AppUtils.featureUnderDevelopment,
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => Text(
                                          "₹ ${controller.sliderValue.value.toStringAsFixed(0)}L",
                                          style: fontStyleBold13,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.w5,
                                      ),
                                      CustomSvgAssetImage(
                                        image: AppImages.icPencil,
                                        size: Dimensions.w14,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Dimensions.w30,
                                  height: Dimensions.h1,
                                  color: AppColors.dividerColor,
                                )
                              ],
                            )
                          ],
                        ),
                        CustomSlidingSegmentedControl<int>(
                          height: Dimensions.h23,
                          // isStretch: true,
                          initialValue: 1,
                          children: {
                            1: Text(AppString.oneTime,
                                style: fontStyleSemiBold10),
                            2: Text(AppString.monthlySIP,
                                style: fontStyleSemiBold10),
                          },
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r6),
                              border: Border.all(
                                  color: AppColors.dividerColor, width: 0.5)),
                          thumbDecoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(Dimensions.r6),
                          ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInToLinear,
                          onValueChanged: (v) {},
                        ),
                      ],
                    ),
                    Obx(
                      () => Slider(
                        value: controller.sliderValue.value,
                        onChanged: (value) =>
                            controller.sliderValue.value = value,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label:
                            '${controller.sliderValue.value.toStringAsFixed(1)}L',
                        activeColor: AppColors.primaryColor,
                        thumbColor: AppColors.primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹ 1L",
                          style: fontStyleBold12,
                        ),
                        Text(
                          "₹ 10L",
                          style: fontStyleBold12,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.h10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.thisFundsPastReturns,
                          style: fontStyleBold13,
                        ),
                        Text(
                          "₹ 3.5L",
                          style: fontStyleBold13.apply(
                              color: AppColors.greenHighlightColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.h5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.profileAbsoluteReturn,
                          style:
                              fontStyleBold10.apply(color: AppColors.hintColor),
                        ),
                        Text(
                          "355.3 %",
                          style: fontStyleBold10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.h20,
                    ),
                    Bars()
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              Row(
                children: [
                  Flexible(
                    child: MyButton(
                      height: Dimensions.h35,
                      onPressed: AppUtils.featureUnderDevelopment,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sell',
                            style: fontStyleBold16,
                          ),
                          SizedBox(
                            width: Dimensions.w5,
                          ),
                          CustomSvgAssetImage(
                            image: AppImages.icSellArrow,
                            size: Dimensions.w15,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.w10,
                  ),
                  Flexible(
                    child: MyButton(
                      height: Dimensions.h35,
                      onPressed: AppUtils.featureUnderDevelopment,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Invest More',
                            style: fontStyleBold16,
                          ),
                          SizedBox(
                            width: Dimensions.w5,
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: CustomSvgAssetImage(
                              image: AppImages.icSellArrow,
                              size: Dimensions.w15,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
