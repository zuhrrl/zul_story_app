import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:zul_story_app/data/model/user_model.dart';
import 'package:zul_story_app/data/preference/preference_helper.dart';

class ApiService {
  late PreferenceHelper preferenceHelper;
  Client client = Client();
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';

  ApiService() {
    preferenceHelper = PreferenceHelper();
  }

  Future<Map<String, dynamic>> fetchStories() async {
    var token = await preferenceHelper.getAccessToken();
    var url = '$baseUrl/stories';
    var response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> getDetailStory(storyId) async {
    var token = await preferenceHelper.getAccessToken();
    var url = '$baseUrl/stories/$storyId';
    var response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> login(User user) async {
    var url = '$baseUrl/login';

    var body = {'email': user.email, 'password': user.password};
    var response = await client.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body));
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> register(User user) async {
    var url = '$baseUrl/register';

    var body = {
      'name': user.name,
      'email': user.email,
      'password': user.password
    };
    var response = await client.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body));
    return json.decode(response.body);
  }

  uploadStory(bytes, filename, storyDescription, fileLength) async {
    var token = await preferenceHelper.getAccessToken();

    var url = '$baseUrl/stories';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile.fromBytes('photo', bytes, filename: filename),
    );
    request.headers.addAll(headers);
    request.fields.addAll({"description": storyDescription});
    var res = await request.send();
    var responseStream = await http.Response.fromStream(res);
    var response = responseStream.body;
    return json.decode(response);
  }
}
