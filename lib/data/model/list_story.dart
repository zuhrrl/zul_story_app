class ListStories {
  ListStories({
    required this.error,
    required this.message,
    required this.listStory,
  });
  late final bool error;
  late final String message;
  late final List<Story> listStory;

  ListStories.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    listStory = json['listStory'] == null
        ? []
        : List.from(json['listStory']).map((e) => Story.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['message'] = message;
    _data['listStory'] = listStory.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Story {
  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });
  late final String id;
  late final String name;
  late final String description;
  late final String photoUrl;
  late final String createdAt;
  late final double lat;
  late final double lon;

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photoUrl = json['photoUrl'];
    createdAt = json['createdAt'];
    lat = json['lat'] ?? 0;
    lon = json['lon'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['photoUrl'] = photoUrl;
    _data['createdAt'] = createdAt;
    _data['lat'] = lat;
    _data['lon'] = lon;
    return _data;
  }
}
