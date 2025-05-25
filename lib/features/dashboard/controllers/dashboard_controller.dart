import 'package:dhan_saarthi/core/constants/app_images.dart';
import 'package:dhan_saarthi/core/constants/app_string.dart';
import 'package:dhan_saarthi/core/utils/app_utils.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/charts/chart_tab_screen.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/home/home_tab.dart';
import 'package:dhan_saarthi/features/dashboard/tabs/watchlist/watchlist_screen.dart';
import 'package:dhan_saarthi/features/dashboard/widgets/floating_nav_bar.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;

  final screens = [
    HomeTab(),
    ChartTab(),
    WatchlistTab(),
  ];

  final destinations = [
    // Home
    NavItem(icon: AppImages.icHome, label: AppString.home),

    // Chart
    NavItem(icon: AppImages.icCharts, label: AppString.charts),

    // Watchlist
    NavItem(icon: AppImages.icWatchlist, label: AppString.watchlist),
  ];

  void onDestinationSelected(int index) {
    selectedIndex = index;
    update();
  }

  void onPopInvokedWithResult(bool didPop, dynamic _) {
    if (!didPop) {
      if (selectedIndex != 0) {
        selectedIndex = 0;
        update();
      } else {
        AppUtils.showExitPopScopePopup();
      }
    }
  }
}
