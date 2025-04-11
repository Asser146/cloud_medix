class LoginResponse {
  final List<String> data;

  LoginResponse({required this.data});

  factory LoginResponse.fromJson(List<dynamic> json) {
    return LoginResponse(data: List<String>.from(json));
  }

  List<String> toJson() => data;
}
