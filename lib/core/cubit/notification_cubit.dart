// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/network/api_helper.dart';
// import '../../../../core/network/api_response_handler.dart';
// import '../../../../core/network/network_constant.dart';
// import '../model/response_model/notification_response_model.dart';
// import '../network/api_result.dart';
//
// // Example of API Call when fetching a list
// class NotificationCubit
//     extends Cubit<APIResult<List<NotificationResponseModel>?>?> {
//   NotificationCubit() : super(null);
//
//   Future<void> callNotificationListAPI({required int page}) async {
//     if (page == 1) {
//       emit(APIResult.loading());
//     }
//     var networkResult = await APIHelper.instance.callPostApi(
//       NetworkConstant.notifications,
//       {"page": page, "per_page": 10},
//       false,
//     );
//
//     var apiResultFromNetwork =
//         getAPIResultFromNetwork<List<NotificationResponseModel>?>(
//             networkResult,
//             (json) => json
//                 .map<NotificationResponseModel>(
//                     (e) => NotificationResponseModel.fromJson(e))
//                 .toList());
//
//     emit(apiResultFromNetwork);
//   }
// }
