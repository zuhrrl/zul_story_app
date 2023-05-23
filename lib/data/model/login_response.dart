class LoginResponse {
  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });
  late final bool error;
  late final String message;
  late final LoginResult loginResult;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    loginResult = json['loginResult'] != null
        ? LoginResult.fromJson(json['loginResult'])
        : LoginResult(name: '', token: '', userId: '');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['message'] = message;
    _data['loginResult'] = loginResult.toJson();
    return _data;
  }
}

class LoginResult {
  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });
  late final String userId;
  late final String name;
  late final String token;

  LoginResult.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['name'] = name;
    _data['token'] = token;
    return _data;
  }
}
