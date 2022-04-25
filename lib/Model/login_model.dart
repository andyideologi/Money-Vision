// ignore_for_file: non_constant_identifier_names

class LoginResponseModel {
  final int status;
  final String message;
  final dynamic data;

  LoginResponseModel({required this.status, required this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        status: json['status'] ?? -1,
        message: json['message'] ?? "",
        data: json['data'] ?? "");
  }
}

class LoginRequestModel {
  String mobile;
  String password;

  LoginRequestModel({required this.mobile, required this.password});

  Map<String, String> toJson() {
    Map<String, String> map = {
      'mobile': mobile.trim(),
      'password': password.trim()
    };
    return map;
  }
}
