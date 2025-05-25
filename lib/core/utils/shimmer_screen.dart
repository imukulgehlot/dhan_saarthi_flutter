import 'package:dhan_saarthi/core/utils/shimmer_effect.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? baseColor;
  final bool showTrailing;
  final Color? highlightColor;

  const ShimmerContainer(
      {super.key,
      required this.width,
      required this.height,
      this.borderRadius,
      this.showTrailing = false,
      this.margin = EdgeInsets.zero,
      this.padding = EdgeInsets.zero,
      this.baseColor,
      this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.shimmerBaseColor,
      highlightColor: highlightColor ?? AppColors.shimmerHighLightColor,
      child: Container(
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius:
                  borderRadius ?? BorderRadius.circular(Dimensions.r8)),
          child: showTrailing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      const SizedBox(),
                      Padding(
                          padding: EdgeInsets.only(right: Dimensions.w25),
                          child: CircleAvatar(
                            radius: Dimensions.r15,
                          ))
                    ])
              : const SizedBox()),
    );
  }
}

class ShimmerSettingsDashboard extends StatelessWidget {
  const ShimmerSettingsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return formUI();
  }

  formUI() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: Dimensions.w15,
          // ),
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighLightColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.w10,
                right: Dimensions.w10,
                top: Dimensions.w8,
                bottom: Dimensions.w8,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: Dimensions.w55,
                              height: Dimensions.h10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(9),
                              )),
                          SizedBox(
                            height: Dimensions.h3,
                          ),
                          Container(
                              width: Dimensions.w20,
                              height: Dimensions.h9,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(9),
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.h50),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: Dimensions.w80,
                                height: Dimensions.h10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(9),
                                )),
                            SizedBox(
                              height: Dimensions.h3,
                            ),
                            Container(
                                width: Dimensions.w35,
                                height: Dimensions.h9,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(9),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.h10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // First Row
                      Container(
                        width: Dimensions.w50,
                        height: Dimensions.w50,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          width: Dimensions.w40,
                          height: Dimensions.w40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.w10,
                      ),

                      // Second Column
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.h50),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: Dimensions.w180,
                                height: Dimensions.h10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(9),
                                )),
                            SizedBox(
                              height: Dimensions.h6,
                            ),
                            Container(
                                width: Dimensions.w130,
                                height: Dimensions.h9,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(9),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.h10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShimmerSettingRatingContainer extends StatelessWidget {
  const ShimmerSettingRatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return formUI();
  }

  formUI() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighLightColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighLightColor,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w20,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimensions.h8,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: Dimensions.h14),
                                width: Dimensions.w275,
                                height: Dimensions.h13,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(3),
                                )),
                            SizedBox(
                              height: Dimensions.h3,
                            ),
                            Container(
                                width: Dimensions.w248,
                                height: Dimensions.h13,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(3),
                                )),
                          ],
                        ),
                      ],
                    ),
                    const Divider()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
