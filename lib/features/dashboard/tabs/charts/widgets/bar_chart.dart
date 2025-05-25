import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bars extends StatefulWidget {
  const Bars({super.key});

  @override
  State<StatefulWidget> createState() => BarsState();
}

class BarsState extends State<Bars> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: Dimensions.h90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BarChart(
                    mainBarData(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: const Color(0xff3D3D3D),
          width: Dimensions.w50,
          borderRadius: BorderRadius.circular(0),
          borderSide: isTouched
              ? BorderSide(color: AppColors.primaryColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: const Color(0xff358438),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 18, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 9, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTopTitles,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTopTitles(double value, TitleMeta meta) {
    TextStyle style = fontStyleBold10;

    String text = '';

    if (value == 0) {
      text = "₹ 1.19L";
    }
    if (value == 1) {
      text = "₹ 3.5L";
    }
    if (value == 2) {
      text = "₹ 4.43L";
    }
    return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h5),
        child: Text(text, style: style));
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = fontStyleBold10;

    String text = '';

    if (value == 0) {
      text = "Savings A/C";
    }
    if (value == 1) {
      text = "Category Avg.";
    }
    if (value == 2) {
      text = "Direct Plan";
    }
    return Padding(
        padding: EdgeInsets.only(top: Dimensions.h5),
        child: Text(text, style: style));
  }
}
