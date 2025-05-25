import 'package:get/get.dart';

class ChartDetailController extends GetxController {
  final icBookmarked = false.obs;

  void toggleBookmark() => icBookmarked.value = !icBookmarked.value;

  final sliderValue = RxDouble(1.0);
}
