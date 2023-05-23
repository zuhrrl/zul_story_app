class AddStory {
  AddStory({
    required this.error,
    required this.message,
  });
  late final bool error;
  late final String message;

  AddStory.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
