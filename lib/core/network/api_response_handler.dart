import 'dart:convert';

import '../basic_features.dart';
import '../environment_setup/environment.dart';
import '../storage/preference_storage.dart';
import '../utils/enum.dart';
import '../utils/extension.dart';
import '../utils/logger_util.dart';
import 'api_result.dart';
import 'api_result_constant.dart';
import 'base_response_model_entity.dart';
import 'network_result.dart';

APIResult<T> getAPIResultFromNetwork<T>({
  required NetworkResult networkResult,
  required T Function(dynamic json) converter,
}) {
  switch (networkResult.networkResultType) {
    // Error
    case NetworkResultType.error:
      var baseJson = json.decode(networkResult.result!);
      BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);

      if (Environment.config.environment == Environment.development) {
        AppUtils.showSnackBar(message: baseResponse.developerMessage.orEmpty());
      } else {
        if (baseResponse.developerMessage.isNotNullOrEmpty()) {
          AppUtils.showSnackBar(message: baseResponse.userMessage!);
        }
      }

      return APIResult.failure(
        baseResponse.userMessage,
      );

    // No Internet
    case NetworkResultType.noInternet:
      // navigateToPageAndRemoveAllPage(const NoInterNetScreen());
      AppUtils.showSnackBar(
          message: "No Active Internet Connection!", isSuccess: false);
      return APIResult.noInternet();

    // Time Out!
    case NetworkResultType.timeOut:
      AppUtils.showSnackBar(message: "Request timeOut");
      logger.w("user timeOut");
      return APIResult.timeOut();

    // Unauthorised
    case NetworkResultType.unauthorised:
      PreferenceStorage.clearStorage();
      return APIResult.sessionExpired();

    case NetworkResultType.notFound:
      PreferenceStorage.clearStorage();
      // navigateToPageAndRemoveAllPage(
      // GlobalVariable.navigatorKey.currentContext!,
      // DEACTIVATE_ROUTE,
      // );
      return APIResult.userUnauthorised();

    // Cache Error
    case NetworkResultType.cacheError:
      return APIResult.failure(AppString.error);

    // Success
    case NetworkResultType.success:
      {
        if (networkResult.result.isNullOrEmpty()) {
          logger.w("user isNullOrEmpty");
          return APIResult.failure("");
        }
        try {
          var baseJson = json.decode(networkResult.result!);
          BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);
          // BaseResponseModel baseResponseEntity = JsonConvert.fromJsonAsT(baseJson);
          if (baseResponse.statusCode == APIResultConstant.error) {
            logger.w("user-- ERROR");
            return APIResult.failure(
              baseResponse.userMessage.orEmpty(),
            );
          } else if (baseResponse.statusCode ==
              APIResultConstant.userUnauthorised) {
            logger.w("user unauthorized");
            // navigateToPageAndRemoveAllPage(GlobalVariable.navigatorKey.currentContext!, LOGIN_ROUTE,);
            return APIResult.userUnauthorised();
          } else if (baseResponse.statusCode ==
              APIResultConstant.sessionExpired) {
            logger.w("user sessionExpired");
            AppUtils.showSnackBar(
                message: baseResponse.userMessage ?? AppString.sessionExpired);
            // Todo Place Sign In Screen
            // Get.offAll(() => const SignInScreen());
            return APIResult.sessionExpired();
          } else if (baseResponse.statusCode == APIResultConstant.userDeleted) {
            logger.w("user USER_DELETED");
            return APIResult.userUnauthorised();
          } else {
            if (kDebugMode) {
              print("API Success: ${baseResponse.userMessage}");
            }
            if (baseResponse.data != null) {
              if (baseResponse.data.runtimeType != String) {
                T? responseModel = converter(baseResponse.data);

                return APIResult.success(
                    baseResponse.userMessage.orEmpty(), responseModel);
              }
              return APIResult.success(
                  baseResponse.userMessage.orEmpty(), baseResponse.data);
            } else {
              return APIResult.success(
                  baseResponse.userMessage.orEmpty(), null);
            }
          }
        } catch (e, s) {
          logger.w("result failure catch $e StackTrace $s");
          // FirebaseCrashlytics.instance.recordError(e, s);
          return APIResult.failure(AppString.error);
        }
      }
  }
}

APIResult<T> getAPIResultFromNetworkWithoutBase<T>(
  NetworkResult networkResult,
  T Function(dynamic json) converter,
) {
  switch (networkResult.networkResultType) {
    case NetworkResultType.error:
      return APIResult.failure(AppString.error);
    case NetworkResultType.noInternet:
      return APIResult.noInternet();
    case NetworkResultType.unauthorised:
      return APIResult.userUnauthorised();
    case NetworkResultType.notFound:
      return APIResult.userDeleted();
    case NetworkResultType.success:
    default:
      {
        if (networkResult.result.isNullOrEmpty()) {
          return APIResult.failure("");
        }
        try {
          if (networkResult.result != null) {
            var baseJson = json.decode(networkResult.result!);
            T? responseModel = converter(baseJson);
            return APIResult.success(
              "",
              responseModel,
            );
          } else {
            return APIResult.success("", null);
          }
        } catch (e) {
          //FirebaseCrashlytics.instance.recordError(e, s);
          return APIResult.failure(e.toString());
        }
      }
  }
}
