import 'package:dhan_saarthi/core/model/ui_model/mutual_fund_model.dart';
import 'package:get/get.dart';

import '../chart_details/charts_detail_screen.dart';

class ChartTabController extends GetxController {
  final mutualFunds = <MutualFundModel>[
    MutualFundModel(
        name: 'HDFC Balanced Advantage Fund',
        image: '',
        isSaved: false,
        oneYearPercent: '101.8',
        threeYearPercent: '20.2',
        fiveYearPercent: '25.50',
        nav: '13.57',
        expRatio: '25.50'),
    MutualFundModel(
        name: 'HDFC Mid-Cap Opportunities Fund',
        image: '',
        isSaved: false,
        oneYearPercent: '101.8',
        threeYearPercent: '20.2',
        fiveYearPercent: '25.50',
        nav: '13.57',
        expRatio: '25.50'),
    MutualFundModel(
        name: 'HDFC Liquid Fund',
        image: '',
        isSaved: false,
        oneYearPercent: '101.8',
        threeYearPercent: '20.2',
        fiveYearPercent: '25.50',
        nav: '13.57',
        expRatio: '25.50'),
    MutualFundModel(
        name: 'HDFC Flexi Cap Fund',
        image: '',
        isSaved: false,
        oneYearPercent: '101.8',
        threeYearPercent: '20.2',
        fiveYearPercent: '25.50',
        nav: '13.57',
        expRatio: '25.50'),
  ];

  void navigateToDetails(MutualFundModel? fund) {
    if (fund != null) {
      Get.to(() => ChartsDetailScreen(fundName: fund.name));
    }
  }
}
