import 'package:dhan_saarthi/features/dashboard/widgets/floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      builder: (controller) => PopScope(
          canPop: false,
          onPopInvokedWithResult: controller.onPopInvokedWithResult,
          child: Scaffold(
            body: controller.screens[controller.selectedIndex],
            bottomNavigationBar: NavBar(
              selectedIndex: controller.selectedIndex,
              onTap: controller.onDestinationSelected,
              items: controller.destinations,
            ),
          )),
    );
  }
}
