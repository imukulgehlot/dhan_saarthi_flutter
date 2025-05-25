// import 'dart:convert';
// import 'dart:io';
//
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:http/http.dart' as http;
//
// import '../basic_features.dart';
// import '../environment_setup/environment.dart';
// import '../network/network_constant.dart';
// import '../storage/preference_storage.dart';
// import '../utils/logger_util.dart';
//
// void startTrackingCrashes() {
//   FlutterError.onError = (details) {
//     PostToTeams post = getPostToTeams(logsToTeams: details.toString());
//     FlutterError.presentError(details);
//     if (kReleaseMode) {
//       sendLogsToTeams(post.toJson());
//     }
//   };
//
//   PlatformDispatcher.instance.onError = (error, stack) {
//     PostToTeams post =
//         getPostToTeams(logsToTeams: error.toString() + stack.toString());
//     logger.w("Dispatcher Error: ${post.toJson()}");
//     if (kReleaseMode) {
//       sendLogsToTeams(post.toJson());
//     }
//     return true;
//   };
// }
//
// PostToTeams getPostToTeams({required String logsToTeams, String? subtitle}) {
//   String? type;
//   String? summary;
//   List<Facts>? facts = [];
//   List<Sections>? sections = [];
//   String? activityTitle;
//   String? activitySubtitle = subtitle;
//
//   type = "ErrorMessageCard";
//   // context = "http://schema.org/extensions";
//   // themeColor = "0076D7";
//   summary = "New Crash";
//   activityTitle = AppString.appName;
//   activitySubtitle = activitySubtitle ?? "Crash Type";
//   // activityImage =
//   //     "https://teamsnodesample.azurewebsites.net/static/img/image5.png";
//   String platform = AppUtils.platform;
//   String? deviceManufacturer = AppUtils.androidInfo?.manufacturer;
//   String? androidDeviceName = AppUtils.androidInfo?.model;
//   String? androidVersion = AppUtils.androidInfo?.version.release;
//   String? iOSDeviceName = AppUtils.iosInfo?.utsname.machine;
//   String? iOSVersion = AppUtils.iosInfo?.systemVersion;
//   // String userID = PreferenceStorage.getSignInResponseModel()?.userId ?? '';
//   // String token = StartupService.getToken();
//   facts.add(Facts("User ID",
//       PreferenceStorage.getSignInResponseModel()?.userId ?? "Not Logged In"));
//   facts.add(Facts("Date", DateTime.now().toIso8601String()));
//   facts.add(Facts(
//       "Build Mode",
//       PreferenceStorage.getString(AppString.currentBuildModeKey) ??
//           Environment.development));
//   facts.add(Facts("Platform", platform));
//   if (Platform.isIOS) {
//     facts.add(Facts("Model", iOSDeviceName ?? ""));
//     facts.add(Facts("iOS version", iOSVersion ?? ""));
//   } else {
//     facts.add(Facts("Device manufacturer", deviceManufacturer ?? ""));
//     facts.add(Facts("Model", androidDeviceName ?? ""));
//     facts.add(Facts("Android version", androidVersion));
//   }
//
//   // facts.add(Facts("User email", userID));
//   // facts.add(Facts("Token", token));
//   facts.add(Facts("Logs", logsToTeams));
//
//   sections.add(Sections(activityTitle, activitySubtitle, facts));
//
//   PostToTeams post = PostToTeams(type, summary, sections);
//   return post;
// }
//
// // Sending Crash Logs to Server
// sendLogsToTeams(Map<String, dynamic> logsToTeams) async {
//   String body = json.encode(logsToTeams);
//   if (kReleaseMode) {
//     safePrint("body$body");
//
//     http.Response response = await http.post(
//         Uri.parse(
//             "${Environment.config.apiHost}/${NetworkConstant.crashReport}"),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: body);
//     // FirebaseCrashlytics.instance.log(body);
//     logger.e(response.body.toString());
//   }
// }
//
// class PostToTeams {
//   String? type;
//   String? summary;
//   List<Sections>? sections;
//
//   PostToTeams(this.type, this.summary, this.sections);
//
//   PostToTeams.fromJson(Map<String, dynamic> json) {
//     type = json['@type'];
//     summary = json['summary'];
//     if (json['sections'] != null) {
//       sections = <Sections>[];
//       json['sections'].forEach((v) {
//         sections!.add(Sections.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['@type'] = type;
//     data['summary'] = summary;
//     if (sections != null) {
//       data['sections'] = sections!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Sections {
//   String? activityTitle;
//   String? activitySubtitle;
//   List<Facts>? facts;
//
//   Sections(this.activityTitle, this.activitySubtitle, this.facts);
//
//   Sections.fromJson(Map<String, dynamic> json) {
//     activityTitle = json['activityTitle'];
//     activitySubtitle = json['activitySubtitle'];
//     if (json['facts'] != null) {
//       facts = <Facts>[];
//       json['facts'].forEach((v) {
//         facts!.add(Facts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['activityTitle'] = activityTitle;
//     data['activitySubtitle'] = activitySubtitle;
//     if (facts != null) {
//       data['facts'] = facts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Facts {
//   String? name;
//   String? value;
//
//   Facts(this.name, this.value);
//
//   Facts.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['value'] = value;
//     return data;
//   }
// }
