class BaseResponseModel {
  BaseResponseModel({
    required this.statusCode,
    required this.success,
    required this.userMessage,
    required this.userMessageCode,
    required this.developerMessage,
    this.data,
  });

  int? statusCode;
  bool? success;
  String? userMessage;
  String? userMessageCode;
  String? developerMessage;
  dynamic data;

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    userMessage = json['userMessage'];
    userMessageCode = json['userMessageCode'];
    developerMessage = json['developerMessage'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['messageCode'] = userMessageCode;
    data['userMessage'] = userMessage;
    data['developerMessage'] = developerMessage;
    data['data'] = this.data;
    return data;
  }
}
