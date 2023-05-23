// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/testing.dart';
// import 'package:mockito/annotations.dart';
// import 'package:http/http.dart' as http;
// import 'package:zul_story_app/data/api/api_service.dart';
// import 'package:zul_story_app/data/model/list_story.dart';
// import 'package:zul_story_app/data/model/login_response.dart';
// import 'package:zul_story_app/data/model/user_model.dart';

// @GenerateMocks([http.Client])
// void main() {
//   group('auth provider', () {
//     var apiService = ApiService();

//     apiService.client = MockClient((request) async {
//       var fakeResp = {
//         "error": false,
//         "message": "success",
//         "loginResult": {
//           "userId": "user-yj5pc_LARC_AgK61",
//           "name": "Arif Faizin",
//           "token":
//               "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyLXlqNXBjX0xBUkNfQWdLNjEiLCJpYXQiOjE2NDE3OTk5NDl9.flEMaQ7zsdYkxuyGbiXjEDXO8kuDTcI__3UjCwt6R_I"
//         }
//       };
//       return http.Response(json.encode(fakeResp), 200, request: request);
//     });

//     test('login should return success', () async {
//       var user = User(email: 'zul@email.com', password: 'zul@email.com');
//       var response = await apiService.login(user);
//       var login = LoginResponse.fromJson(response);
//       print(login);
//       expect(login.loginResult.token.isNotEmpty, true);
//       // expect(listStories.error, false);
//     });
//   });
// }
