import 'package:zul_story_app/data/api/api_service.dart';
import 'package:zul_story_app/data/model/list_story.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  isLoggedIn() async {
    try {
      var response = await apiService.fetchStories();
      print(response);

      var listStories = ListStories.fromJson(response);
      if (listStories.error) {
        if (listStories.message == 'Missing authentication') {
          return false;
        }

        if (listStories.message == 'Bad HTTP authentication header format') {
          return false;
        } else {
          return false;
        }
      }

      return true;
    } catch (err) {
      print(err);

      return false;
    }
  }
}
