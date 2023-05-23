// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/testing.dart';
// import 'package:mockito/annotations.dart';
// import 'package:http/http.dart' as http;
// import 'package:zul_story_app/data/api/api_service.dart';
// import 'package:zul_story_app/data/model/list_story.dart';

// @GenerateMocks([http.Client])
// void main() {
//   group('story provider test', () {
//     var apiService = ApiService();

//     apiService.client = MockClient((request) async {
//       var fakeResp = {
//         "error": false,
//         "message": "Stories fetched successfully",
//         "listStory": [
//           {
//             "id": "story-FvU4u0Vp2S3PMsFg",
//             "name": "Dimas",
//             "description": "Lorem Ipsum",
//             "photoUrl":
//                 "https://story-api.dicoding.dev/images/stories/photos-1641623658595_dummy-pic.png",
//             "createdAt": "2022-01-08T06:34:18.598Z",
//             "lat": -10.212,
//             "lon": -16.002
//           }
//         ]
//       };
//       return http.Response(json.encode(fakeResp), 200, request: request);
//     });

//     test('fetch story should not error', () async {
//       var response = await apiService.fetchStories();
//       var listStories = ListStories.fromJson(response);
//       expect(listStories.error, false);
//     });

//     test('fetch story should not empty', () async {
//       var response = await apiService.fetchStories();
//       var listStories = ListStories.fromJson(response);
//       expect(listStories.listStory.isNotEmpty, true);
//     });

//     test('story should not have empty response', () async {
//       var response = await apiService.fetchStories();
//       var listStories = ListStories.fromJson(response);
//       var story = listStories.listStory[0];
//       expect(story.name.isNotEmpty, true);
//       expect(story.photoUrl.isNotEmpty, true);
//     });
//   });
// }
