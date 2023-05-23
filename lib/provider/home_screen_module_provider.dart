import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zul_story_app/constant/result_state.dart';
import 'package:zul_story_app/data/api/api_service.dart';
import 'package:zul_story_app/data/model/list_story.dart';
import 'package:zul_story_app/data/preference/preference_helper.dart';

class HomeScreenModuleProvider extends ChangeNotifier {
  final ApiService apiService;
  final PreferenceHelper preferenceHelper;
  late ResultState _state;
  String _message = '';
  String _userName = '';

  late ListStories _listStories;

  late Completer<bool> _completer;

  ResultState get state => _state;

  List<Story> get getListStory => _listStories.listStory;

  String get message => _message;

  get getErrorMessage => _message;

  String get userName => _userName;

  HomeScreenModuleProvider(
      {required this.apiService, required this.preferenceHelper}) {
    fetchStories();
  }

  Future<bool> waitForResult() async {
    _completer = Completer<bool>();
    return _completer.future;
  }

  fetchStories() async {
    try {
      _state = ResultState.loading;
      _userName = await preferenceHelper.getString('USERNAME') ?? '';

      notifyListeners();
      var response = await apiService.fetchStories();

      var listStories = ListStories.fromJson(response);
      if (listStories.error) {
        if (listStories.message == 'Missing authentication') {
          _state = ResultState.errorAuth;
          notifyListeners();
          _message = 'Error: ${listStories.message}';
          return;
        }
      }

      if (listStories.listStory.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'No data';
        return;
      }

      _state = ResultState.hasData;
      notifyListeners();
      _listStories = listStories;
      return;
    } catch (err, stack) {
      print(stack);
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error: $err';
      return;
    }
  }

  logOutScreen() async {}
}
