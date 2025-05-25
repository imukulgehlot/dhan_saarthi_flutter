import 'package:dhan_saarthi/core/basic_features.dart';
import 'package:dhan_saarthi/core/model/ui_model/mutual_fund_model.dart';

class WatchlistController extends GetxController {
  final watchlistItems = <Map<String, List<MutualFundModel>>>[
    {
      "Watchlist 1": <MutualFundModel>[
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
      ]
    },
    {"Watchlist 2": <MutualFundModel>[]},
    {"Watchlist 3": <MutualFundModel>[]},
  ].obs;

  final selectedWatchListIndex = 0.obs;
}
