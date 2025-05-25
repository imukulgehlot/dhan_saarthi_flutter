import 'dart:convert';

import 'package:dhan_saarthi/core/utils/extension.dart';

import '../environment_setup/environment.dart';
import '../utils/app_utils.dart';
import '../utils/enum.dart';
import 'base_response_model_entity.dart';

class NetworkResult {
  NetworkResultType networkResultType;
  String? result;

  NetworkResult._(this.networkResultType, this.result);

  static NetworkResult noInternet() =>
      NetworkResult._(NetworkResultType.noInternet, null);

  static NetworkResult success(String data) =>
      NetworkResult._(NetworkResultType.success, data);

  static NetworkResult sessionExpired(String data) {
    var baseJson = json.decode(data);
    BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);
    final message = Environment.config.environment == Environment.development
        ? baseResponse.developerMessage
        : baseResponse.userMessage;

    if (message.isNotNullOrEmpty()) {
      // Get.offAll(() => const SignInScreen());
      AppUtils.showSnackBar(message: message!);
    }

    return NetworkResult._(NetworkResultType.error, data);
  }

  static NetworkResult error(String data) {
    var baseJson = json.decode(data);
    BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);
    final message = Environment.config.environment == Environment.development
        ? baseResponse.developerMessage
        : baseResponse.userMessage;

    if (message.isNotNullOrEmpty()) {
      AppUtils.showSnackBar(message: message!);
    }

    return NetworkResult._(NetworkResultType.error, data);
  }

  static NetworkResult cacheError() =>
      NetworkResult._(NetworkResultType.cacheError, null);

  static NetworkResult timeout() =>
      NetworkResult._(NetworkResultType.timeOut, null);

  static NetworkResult unAuthorised([String? data, bool isLogout = true]) {
    if (data.isNotNullOrEmpty()) {
      var baseJson = json.decode(data!);
      BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);
      final message = Environment.config.environment == Environment.development
          ? baseResponse.developerMessage
          : baseResponse.userMessage;
      if (message.isNotNullOrEmpty()) {
        AppUtils.showSnackBar(message: message!);
      }
    }

    if (isLogout) {
      // Todo Place Logout Code Here
      // Get.find<AuthController>().onLogoutSuccess();
    }

    return NetworkResult._(NetworkResultType.unauthorised, null);
  }

  static NetworkResult notFound() =>
      NetworkResult._(NetworkResultType.notFound, null);

  @override
  String toString() =>
      'NetworkResult{networkResultType: $networkResultType, data: $result}';
}
