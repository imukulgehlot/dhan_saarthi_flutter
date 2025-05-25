import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../features/auth/controller/sign_in_controller.dart';
import '../basic_features.dart';
import '../helpers/animation_helper.dart';
import '../storage/preference_storage.dart';
import '../widgets/custom_image.dart';
import 'custom_dialogs.dart';
import 'logger_util.dart';

void orientations() => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

class AppUtils {
  static InputFormatter inputFormatter = InputFormatter();
  static RegExpression regExpression = RegExpression();
  static String packageName = '';
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static double bottomPadding(BuildContext context) =>
      buttonHeight(context) + MediaQuery.of(context).padding.bottom;

  static double buttonHeight(BuildContext context) {
    // print("AppBar().preferredSize.height    ${AppBar().preferredSize.height}");
    return AppBar().preferredSize.height;
  }

  // static AppCheckerResult? appVersion;
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;
  static String? deviceID;
  static bool isAndroid = Platform.isAndroid;
  static bool isIos = Platform.isIOS;

  static String platform = Platform.isAndroid ? "Android" : "iOS";

  static String formatDateTimeToDayMonthYearTime(DateTime dateTime) {
    // Define the desired date and time format

    final DateFormat customFormat = DateFormat('d MMM yyyy, h:mm a');

    // Format the DateTime accordingly
    String formattedDateTime = customFormat.format(dateTime);

    return formattedDateTime;
  }

  static String formatDateTimeToDayMonthYear(DateTime dateTime,
      {String separator = ' '}) {
    // Define the desired date and time format

    final DateFormat customFormat =
        DateFormat('d${separator}MMM${separator}yyyy');

    // Format the DateTime accordingly
    String formattedDateTime = customFormat.format(dateTime);

    return formattedDateTime;
  }

  static Future<void> config() async {
    await _getDeviceId();

    if (Platform.isAndroid) {
      androidInfo = await deviceInfoPlugin.androidInfo;
    } else {
      iosInfo = await deviceInfoPlugin.iosInfo;
    }
  }

  static Future<void> _getDeviceId() async {
    // Todo Add Unique Device ID
    deviceID = 'await MobileDeviceIdentifier().getDeviceId();';

    // Unique ID Visual Example
    // FC2776D6-D508-440E-B5EE-9E0E795AACD8 | iOS
    // 2B:B6:6D:03:D3:19:CA:8C:1E:BE:0E:E5:51:9A:17:39:0A:54:3D:E6:97:F0:68:D0:65:93:5D:5D:90:2D:9F:0D | Android
  }

  static String getDuration(Duration duration) {
    final int hours = duration.inHours.toString().length;
    return duration.inHours > 0
        ? hours == 1
            ? duration.toString().substring(0, 7)
            : duration.toString().substring(0, 8)
        : duration.toString().substring(2, 7);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static Pattern phonePattern = r'(^[0-9 ]*$)';

  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }
    exit(0);
  }

  static showSnackBar(
      {bool isSuccess = false,
      String? title,
      required String message,
      int durationMilliSecond = 4000}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          borderColor: AppColors.primaryColor,
          borderWidth: 2,
          barBlur: 80,
          snackPosition: SnackPosition.TOP,
          maxWidth: Get.width * 0.92,
          borderRadius: Dimensions.r17,
          forwardAnimationCurve: CustomAnimationCurves.snackBarEaseOutBack,
          animationDuration: 800.milliseconds,
          backgroundColor: AppColors.snackBarBackgroundColor,
          duration: Duration(milliseconds: durationMilliSecond),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w8),
          messageText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action Icon, Title, Trailing Icon
              Row(
                children: [
                  // Action Icon
                  // Action Icon
                  CustomSvgAssetImage(
                    image: isSuccess
                        ? AppImages.icCheckCircle
                        : AppImages.icWarningCircle,
                    width: Dimensions.w30,
                    height: Dimensions.w30,
                  ),
                  // Title Text
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.w10),
                    child: Text(
                      title ??
                          (isSuccess
                              ? AppString.snackBarPositiveTitle.tr
                              : AppString.snackBarNegativeTitle.tr),
                      style: fontStyleMedium17.copyWith(
                          color: AppColors.blackColor),
                    ),
                  ),
                  Spacer(),
                ],
              ),

              // Message Text
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w40),
                child: Text(
                  message,
                  style: fontStyleLight15.copyWith(color: AppColors.blackColor),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  static Future<void> validateAuthTokenExpiry() async {
    final authAccessToken = await PreferenceStorage.getAuthAccessToken();

    if (authAccessToken != null && JwtDecoder.isExpired(authAccessToken)) {
      // final signInController = Get.put(SignInController()); // Create instance
      // await signInController.callRefreshToken(); // Call method
      // Get.delete<SignInController>(); // Delete instance after execution
    }
  }

  // Sign Out Dialogue
  static showSignOutDialogue() {
    CustomDialogs.showCustomDialog(
        icon: AppImages.icDialogueQuestion,
        title: AppString.areYouSure,
        contentText: AppString.areYouSureLogout,
        firstButtonFunction: () async {
          // Sign Out
          final signInController = SignInController();
          await signInController.signOutUser();
        },
        firstButtonText: AppString.yesLogout,
        secondButtonText: AppString.cancel);
  }

  static String getEncryptedString({required String stringToEncrypt}) {
    var bytes = utf8.encode(stringToEncrypt);
    var mdEncrypt = md5.convert(bytes).toString();
    var bytes2 = utf8.encode(mdEncrypt);
    var en1 = sha256.convert(bytes2);
    return en1.toString();
  }

  static Color getRandomColor({bool dark = false}) {
    final Random random = Random();
    const int maxColorValue = 255;

    int randomColorComponent() => random.nextInt(maxColorValue);

    int randomRed = randomColorComponent();
    int randomGreen = randomColorComponent();
    int randomBlue = randomColorComponent();

    return dark
        ? Color.fromARGB(255, randomRed, randomGreen, randomBlue)
            .withValues(alpha: 0.35)
        : Color.fromARGB(255, randomRed, randomGreen, randomBlue);
  }

  static String getUniqueName() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  static String getCurrentDateInYMDTHMS() {
    DateTime date = DateTime.now();
    DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ss");
    String formattedDate = format.format(date);
    return formattedDate;
  }

  static String convertDateTimeToMDYHMSA(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('M/d/yyyy h:mm:ss a').format(dateTime);
    return formattedDate;
  }

  static String convertDateTimeToDMY(DateTime date) {
    String formattedDate = DateFormat('M/d/yyyy').format(date);
    return formattedDate;
  }

  static String convertDateTimeToHHmma(DateTime date) {
    String formattedDate = DateFormat('HH:mm a').format(date);
    return formattedDate;
  }

  static String convertDateAndTime(DateTime date) {
    String formattedDate = DateFormat('dd MMM').format(date);

    return formattedDate;
  }

  static String convertDateToFilterReq(DateTime? date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date!);
    return formattedDate;
  }

  static String convertDurationToHHmma(Duration times) {
    /*final time = Duration( minutes: times.inMinutes);
    return "${time.toString().split(":")[0]}:${time.toString().split(":")[1]}";*/
    DateTime ftime = DateFormat("hh:mm").parse(times.toString());
    String ft = DateFormat('hh:mm a').format(ftime);
    return ft;
  }

  static String formatDurationToString(Duration duration) {
    if (duration.inDays > 0) {
      return "${duration.inDays}d.";
    } else if (duration.inHours > 0) {
      return "${duration.inHours}hr.";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes}m.";
    } else {
      return '';
    }
  }

  static bool isSingleEmoji(String text) {
    // Regular expression to match a single emoji
    final regex = RegExp(
      r'^[\u{1F600}-\u{1F64F}' // Emoticons
      r'\u{1F300}-\u{1F5FF}' // Miscellaneous Symbols and Pictographs
      r'\u{1F680}-\u{1F6FF}' // Transport and Map Symbols
      r'\u{1F1E0}-\u{1F1FF}' // Regional Indicator Symbols
      r'\u{2600}-\u{26FF}' // Miscellaneous Symbols
      r'\u{2700}-\u{27BF}' // Dingbats
      r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
      r'\u{1F018}-\u{1F251}' // Others
      r']+$',
      unicode: true,
    );

    // Check if the text contains only one emoji
    return regex.hasMatch(text);
  }

  static Future<void> openLink({required String link}) async {
    final Uri encodedURl = Uri.parse(link);

    try {
      await launchUrl(encodedURl, mode: LaunchMode.inAppWebView);
    } catch (e) {
      logger.e('Error launching URL: $e');
    }
  }

  // static Future<String?> genThumbnailFile(String path) async {
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //     video: path,
  //     timeMs: 100,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.JPEG,
  //   );
  //
  //   logger.f("Generated This Thumb -> $fileName");
  //   return fileName;
  // }

  static bool isVideoFile(String filePath) {
    final supportedVideoExtensions = [
      '.mp4',
      '.webm',
      '.mkv',
      '.avi',
      '.mov',
      '.wmv',
      '.flv',
      '.m4v',
      '.mpg',
      '.mpeg',
      '.3gp',
    ];

    final lowerCaseFilePath = filePath.toLowerCase();
    return supportedVideoExtensions
        .any((ext) => lowerCaseFilePath.endsWith(ext));
  }

  static String extractFilenameFromUrl(String url) {
    if (url.isNotEmpty) {
      // Split the URL by '/' and remove any query parameters
      final parts = url.split('/');
      final filename = parts.last.split('?')[0];
      return filename;
    }
    return url;
  }

  static Future<bool> haveLocationPermission(
      {bool requestPermission = true}) async {
    final status = await Permission.location.status;
    if (requestPermission) {
      if (status.isDenied) {
        final newStatus = await Permission.location.request();
        return newStatus.isGranted || newStatus.isLimited;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
        return false;
      } else {
        return true;
      }
    } else {
      return status.isGranted || status.isLimited;
    }
  }

  static Future<void> getCurrentLocation() async {
    if (await AppUtils.haveLocationPermission()) {
      EasyLoading.show();
      /*final position =*/
      await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          // distanceFilter: 10,
        ),
      );

      // double latitude = position.latitude;
      // double longitude = position.longitude;

      EasyLoading.dismiss();
      // AppUtils.showSnackBar(
      //     message: "Latitude: $latitude, Longitude: $longitude",
      //     isSuccess: true);
    }
  }

  static RegExp amountRegExp = RegExp(r'([.]*0)(?!.*\d)');

  static bool validateEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  static featureUnderDevelopment() =>
      AppUtils.showToast("Feature Under Development!");

  static showToast(val) => Fluttertoast.showToast(
      msg: val,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.blackColor,
      textColor: Colors.white,
      fontSize: 16.0);

  static void goFullScreen() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  static Future<void> exitFullScreen() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ]);

  static Future<void> openUrl({required String url, Uri? uri}) async {
    try {
      bool launched = await launchUrl(uri ?? Uri.parse(url),
          mode: LaunchMode
              .externalNonBrowserApplication); // Launch the app if installed!

      if (!launched) {
        launchUrl(Uri.parse(url)); // Launch web view if app is not installed!
      }
    } catch (e) {
      launchUrl(
        Uri.parse(url),
      ); // Launch web view if app is not installed!
    }
  }

  static Future<dynamic> openCustomBottomSheet({
    required Widget contentWidget,
    Widget? fixedBottomWidget,
    VoidCallback? onSheetClose,
    bool isInnerHorizontalPadding = true,
    bool hideTopHook = false,
    Color? sheetBackgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        barrierColor: barrierColor,
        context: Get.context!,
        backgroundColor: Colors.transparent,
        builder: (context) => SafeArea(
              bottom: false,
              child: Wrap(
                children: [
                  Container(
                    width: Dimensions.screenWidth(),
                    decoration: BoxDecoration(
                      color: sheetBackgroundColor ?? AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.r15),
                          topRight: Radius.circular(Dimensions.r15)),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            if (!hideTopHook)
                              SizedBox(
                                height: Dimensions.h10,
                              ),

                            if (!hideTopHook)
                              Container(
                                width: Dimensions.w42,
                                height: Dimensions.h3,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.r15),
                                  color: AppColors.greyColor,
                                ),
                              ),

                            SizedBox(
                              height: Dimensions.h10,
                            ),

                            // Content Widget
                            Container(
                              constraints:
                                  BoxConstraints(maxHeight: Get.height * 0.82),
                              padding: EdgeInsets.symmetric(
                                horizontal: isInnerHorizontalPadding
                                    ? Dimensions.commonPaddingForScreen
                                    : 0,
                              ).copyWith(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        16.0,
                              ),
                              child:
                                  SingleChildScrollView(child: contentWidget),
                            ),

                            SizedBox(
                              height: Dimensions.h20,
                            ),
                          ],
                        ),
                        if (fixedBottomWidget != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.commonPaddingForScreen)
                                .copyWith(bottom: Dimensions.h10),
                            child: fixedBottomWidget,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            )).then((value) {
      onSheetClose?.call();
      return value;
    });
  }

  static bool showTimer(val) {
    return DateTime.now().compareTo(DateFormat("yyyy-MM-dd").parse(val)) == -1;
  }

  static bool checkCurrentDate(val) {
    return DateTime.now().compareTo(DateFormat("dd/M/yyyy").parse(val)) > 0;
  }

  static Color? colorConvert(String? color) {
    if (color != null) {
      return Color(int.parse(color.replaceAll('#', '0xFF')));
    } else {
      return null;
    }
  }

  static DateTime? backButtonPressedTime;

  // For Pop Scope
  static showExitPopScopePopup() {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) >
            const Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      AppUtils.showToast('Press again to exit');
    } else {
      SystemNavigator.pop();
    }
  }

  static Future<String> getStoragePath() async {
    String? storageFolderPath;
    if (Platform.isAndroid) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final splittedPath = appDirectory.path.split('/');
      splittedPath.removeLast();
      Directory folder = Directory('${splittedPath.join('/')}/files');
      folder.createSync(recursive: true);
      storageFolderPath = folder.path;
    } else {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      storageFolderPath = appDirectory.path;
    }
    return storageFolderPath;
  }

  static Future<String> getTempStoragePath() async {
    String? storageFolderPath;
    if (Platform.isAndroid) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final splittedPath = appDirectory.path.split('/');
      splittedPath.removeLast();
      Directory folder = Directory('${splittedPath.join('/')}/files/temp');
      folder.createSync(recursive: true);
      storageFolderPath = folder.path;
    } else {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      // final splittedPath = appDirectory.path.split('/');
      // splittedPath.removeLast();
      Directory folder = Directory('${appDirectory.path}/temp');
      if (await folder.exists()) {
        return folder.path;
      } else {
        folder.createSync(recursive: true);
        storageFolderPath = folder.path;
      }
    }
    return storageFolderPath;
  }

  static Future<void> deleteTempStoragePath() async {
    if (Platform.isAndroid) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final splittedPath = appDirectory.path.split('/');
      splittedPath.removeLast();
      Directory folder = Directory('${splittedPath.join('/')}/files/temp');
      if (await folder.exists()) {
        folder.deleteSync(recursive: true);
      }
    } else {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      Directory folder = Directory('${appDirectory.path}/temp');
      if (await folder.exists()) {
        folder.deleteSync(recursive: true);
      }
    }
  }

  // Get 2 initials
  static String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
      : '';
}

class InputFormatter {
  FilteringTextInputFormatter get number =>
      FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));
}

class RegExpression {
  RegExp phonePattern = RegExp(r'(^[0-9 ]*$)');
}

class FontAsset {
  static const String gilroy = "Gilroy";

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class MyDivider extends StatelessWidget {
  final double height;
  final Color? color;

  const MyDivider({super.key, this.height = 0, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: height, color: color ?? AppColors.disabledButtonColor);
  }
}

class Debounce {
  final int milliseconds;
  Timer? _timer;

  Debounce({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}
