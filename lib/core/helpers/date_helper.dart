import 'package:date_field/date_field.dart';
import 'package:get/get.dart';

class DateHelper {
  static Future<DateTime?> showAdaptiveDatePicker(
      {DateTimeFieldPickerMode? pickerMode}) async {
    final DateTime? result = await showAdaptiveDateTimePicker(
      context: Get.context!,
      cupertinoDatePickerOptions: CupertinoDatePickerOptions(
          modalTitleText:
              pickerMode == null || pickerMode == DateTimeFieldPickerMode.date
                  ? 'Select Date'
                  : 'Select Time'),
      mode: pickerMode ?? DateTimeFieldPickerMode.date,
    );

    return result;
  }
}
