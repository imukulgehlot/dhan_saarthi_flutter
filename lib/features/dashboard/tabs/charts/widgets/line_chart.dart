import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/utils/extension.dart';
import 'package:dhan_saarthi/core/widgets/custom_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/enum.dart';

class _LineChart extends StatelessWidget {
  final TimeSpan timeSpan;

  const _LineChart({required this.timeSpan});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      maxData,
      duration: Duration(milliseconds: 300),
    );
  }

  LineChartData get maxData => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: timeSpan.isOneMonth
            ? 5
            : timeSpan.isThreeMonths
                ? 10
                : timeSpan.isSixMonths
                    ? 15
                    : timeSpan.isOneYear
                        ? 20
                        : timeSpan.isThreeYear
                            ? 25
                            : 30,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppColors.containerGrey,
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        barDataMax1,
        barDataMax2,
      ];

  Widget getBottomTitle(double value, TitleMeta meta) {
    final int val = value.toInt();
    Widget text = const Text('');

    final labels = {
      TimeSpan.max: {
        0: '2022',
        10: '2023',
        20: '2024',
        30: '2025',
      },
      TimeSpan.threeYear: {
        0: '2022',
        13: '2023',
        25: '2024',
      },
      TimeSpan.oneYear: {
        0: 'May',
        5: 'Aug',
        10: 'Nov',
        15: 'Feb',
        20: 'Apr',
      },
      TimeSpan.sixMonths: {
        0: 'Dec',
        5: 'Feb',
        10: 'Apr',
        15: 'May',
      },
      TimeSpan.threeMonths: {
        0: 'Mar',
        5: 'Apr',
        10: 'May',
      },
      TimeSpan.oneMonth: {
        0: '1st',
        1: '7th',
        2: '10th',
        3: '15th',
        4: '22nd',
        5: '30th',
      },
    };

    final map = labels[timeSpan];
    if (map != null && map.containsKey(val)) {
      text = Text(map[val]!, style: fontStyleRegular10);
    }

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: getBottomTitle,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColors.dividerColor, width: 1),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get barDataMax1 => LineChartBarData(
        isCurved: true,
        color: AppColors.primaryColor,
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData:
            BarAreaData(show: true, gradient: AppColors.lineChartGradient),
        spots: data1,
      );

  LineChartBarData get barData3Y1 => LineChartBarData(
        isCurved: true,
        color: AppColors.primaryColor,
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData:
            BarAreaData(show: true, gradient: AppColors.lineChartGradient),
        spots: data1,
      );

  LineChartBarData get barDataMax2 => LineChartBarData(
        isCurved: true,
        color: AppColors.yellowColor,
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData:
            BarAreaData(show: true, gradient: AppColors.lineChartGradient),
        spots: data2,
      );

  LineChartBarData get barData3Y2 => LineChartBarData(
        isCurved: true,
        color: AppColors.yellowColor,
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData:
            BarAreaData(show: true, gradient: AppColors.lineChartGradient),
        spots: data2,
      );

  List<FlSpot> get data1 => const [
        FlSpot(0, 1.9),
        FlSpot(1, 2.5),
        FlSpot(2, 2.2),
        FlSpot(3, 1.7),
        FlSpot(4, 2.9),
        FlSpot(5, 2.4),
        FlSpot(6, 3.1),
        FlSpot(7, 3.5),
        FlSpot(8, 2.7),
        FlSpot(9, 2.3),
        FlSpot(10, 2.8),
        FlSpot(11, 3.2),
        FlSpot(12, 3.7),
        FlSpot(13, 3.0),
        FlSpot(14, 2.6),
        FlSpot(15, 2.1),
        FlSpot(16, 2.9),
        FlSpot(17, 2.5),
        FlSpot(18, 3.3),
        FlSpot(19, 3.9),
        FlSpot(20, 4.6),
        FlSpot(21, 3.6),
        FlSpot(22, 5.4),
        FlSpot(23, 4.0),
        FlSpot(24, 3.8),
        FlSpot(25, 2.2),
        FlSpot(26, 2.5),
        FlSpot(27, 3.9),
        FlSpot(28, 3.1),
        FlSpot(29, 3.6),
        FlSpot(30, 3.8),
      ];

  List<FlSpot> get data2 => const [
        FlSpot(0, 2.1),
        FlSpot(1, 2.3),
        FlSpot(2, 1.8),
        FlSpot(3, 2.5),
        FlSpot(4, 2.0),
        FlSpot(5, 2.7),
        FlSpot(6, 3.0),
        FlSpot(7, 2.2),
        FlSpot(8, 2.6),
        FlSpot(9, 3.3),
        FlSpot(10, 3.0),
        FlSpot(11, 3.7),
        FlSpot(12, 3.4),
        FlSpot(13, 2.0),
        FlSpot(14, 1.8),
        FlSpot(15, 2.4),
        FlSpot(16, 3.0),
        FlSpot(17, 2.8),
        FlSpot(18, 3.2),
        FlSpot(19, 3.8),
        FlSpot(20, 3.5),
        FlSpot(21, 3.1),
        FlSpot(22, 3.7),
        FlSpot(23, 3.0),
        FlSpot(24, 2.9),
        FlSpot(25, 2.4),
        FlSpot(26, 2.6),
        FlSpot(27, 3.0),
        FlSpot(28, 3.3),
        FlSpot(29, 3.3),
        FlSpot(30, 3.3),
      ];
}

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  TimeSpan selectedTimeSpan = TimeSpan.max;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: Dimensions.h5,
                    children: [
                      Row(
                        children: [
                          CustomSvgAssetImage(image: AppImages.icLine),
                          SizedBox(
                            width: Dimensions.w5,
                          ),
                          Text("${AppString.yourInvestments} -19.75%",
                              style: fontStyleRegular10.apply(
                                  color: AppColors.primaryColor)),
                        ],
                      ),
                      Row(
                        children: [
                          CustomSvgAssetImage(
                            image: AppImages.icLine,
                            color: AppColors.yellowColor,
                          ),
                          SizedBox(
                            width: Dimensions.w5,
                          ),
                          Text("${AppString.niftyMidcap50} -12.85%",
                              style: fontStyleRegular10.apply(
                                  color: AppColors.yellowColor)),
                        ],
                      ),
                    ],
                  ),
                  MyOutLineButton(
                    title: AppString.nav.toUpperCase(),
                    btnBgColor: AppColors.backgroundColorDark,
                    borderColor: AppColors.hintColor.withValues(alpha: 0.5),
                    onPressed: AppUtils.featureUnderDevelopment,
                    height: Dimensions.h25,
                    miniWidth: Dimensions.w50,
                    textStyle:
                        fontStyleRegular12.apply(color: AppColors.hintColor),
                    cornerRadius: Dimensions.r5,
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.h40,
              ),
              Expanded(
                child: _LineChart(
                  timeSpan: selectedTimeSpan,
                ),
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              CustomSlidingSegmentedControl<int>(
                height: Dimensions.h25,
                isStretch: true,
                initialValue: 6,
                children: {
                  1: Text('1M', style: fontStyleSemiBold12),
                  2: Text('3M', style: fontStyleSemiBold12),
                  3: Text('6M', style: fontStyleSemiBold12),
                  4: Text('1Y', style: fontStyleSemiBold12),
                  5: Text('3Y', style: fontStyleSemiBold12),
                  6: Text('MAX', style: fontStyleSemiBold12),
                },
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimensions.r6),
                    border:
                        Border.all(color: AppColors.dividerColor, width: 0.5)),
                thumbDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.r6),
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                onValueChanged: (v) {
                  if (v == 1) {
                    selectedTimeSpan = TimeSpan.oneMonth;
                  }
                  if (v == 2) {
                    selectedTimeSpan = TimeSpan.threeMonths;
                  }
                  if (v == 3) {
                    selectedTimeSpan = TimeSpan.sixMonths;
                  }
                  if (v == 4) {
                    selectedTimeSpan = TimeSpan.oneYear;
                  }
                  if (v == 5) {
                    selectedTimeSpan = TimeSpan.threeYear;
                  }
                  if (v == 6) {
                    selectedTimeSpan = TimeSpan.max;
                  }

                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
