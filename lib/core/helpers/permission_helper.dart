import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../utils/app_utils.dart';

class PermissionHelper {
  // Media Permission
  static Future<bool> isMediaPermissionGranted() async {
    final permission =
        Platform.isAndroid && AppUtils.androidInfo!.version.sdkInt <= 32
            ? Permission.storage
            : Permission.photos;

    final status = await permission.status;

    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  // External Storage Permission
  static Future<bool> isExternalStoragePermissionGranted() async {
    var permission = AppUtils.androidInfo!.version.sdkInt <= 32
        ? Permission.storage
        : Permission.manageExternalStorage;

    final status = await permission.status;
    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  // Camera Permission
  static Future<bool> isCameraPermissionGranted() async {
    const permission = Permission.camera;

    final status = await permission.status;

    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }
}
