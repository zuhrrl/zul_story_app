class RegisterResponse {
  RegisterResponse({
    required this.error,
    required this.message,
  });
  late final bool error;
  late final String message;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['message'] = message;
    return _data;
  }
}
