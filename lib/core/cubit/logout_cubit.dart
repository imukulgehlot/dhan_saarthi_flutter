// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../model/request_model/login_request_model.dart';
// import '../network/api_helper.dart';
// import '../network/api_response_handler.dart';
// import '../network/api_result.dart';
// import '../network/network_constant.dart';
//
// // Example of simple API Call
// class LogOutCubit extends Cubit<APIResult<String?>?> {
//   LogOutCubit() : super(null);
//
//   Future<void> callLogOutAPI(LoginRequestModel loginRequestModel) async {
//     emit(APIResult.loading());
//     var baseParameters = loginRequestModel;
//     var networkResult = await APIHelper.instance
//         .callPostApi(NetworkConstant.logOut, baseParameters, true);
//     var apiResultFromNetwork =
//         getAPIResultFromNetwork<String>(networkResult, (e) => e.toString());
//     emit(apiResultFromNetwork);
//   }
// }
