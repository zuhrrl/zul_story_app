import 'package:flutter/material.dart';
import 'package:zul_story_app/constant/result_state.dart';
import 'package:zul_story_app/data/api/api_service.dart';
import 'package:zul_story_app/data/model/detail_story_response.dart';

class DetailStoryScreenModuleProvider extends ChangeNotifier {
  final ApiService apiService;
  late ResultState _state;

  String storyId;

  Story? story;

  ResultState get state => _state;
  DetailStoryScreenModuleProvider(
      {required this.apiService, required this.storyId}) {
    fetchDetailStory(storyId);
  }

  get getDetailStory => story;

  fetchDetailStory(storyId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      var response = await apiService.getDetailStory(storyId);
      var detail = DetailStoryResponse.fromJson(response);
      print('detail story ${detail.story.name}');

      if (detail.story.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return;
      }

      _state = ResultState.hasData;
      notifyListeners();
      story = detail.story;
      return;
    } catch (err, stack) {
      print(stack);
      _state = ResultState.error;
      notifyListeners();
      return;
    }
  }
}
