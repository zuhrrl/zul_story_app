import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zul_story_app/repository/auth_repository.dart';
import 'package:zul_story_app/screen/authentication/login_screen.dart';
import 'package:zul_story_app/screen/authentication/register_screen.dart';
import 'package:zul_story_app/screen/home/home_screen.dart';
import 'package:zul_story_app/screen/stories/detail_story.dart';
import 'package:zul_story_app/screen/stories/upload_story.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  bool isLoggedIn = false;

  List<Page> historyStack = [];
  bool isRegister = false;
  bool isUploadStoryPage = false;
  bool isDetailStory = false;
  bool isUploadSuccess = false;

  String storyId = '';

  List<Page> get _loggedInStack => [
        MaterialPage(
            key: const ValueKey('HomeScreen'),
            child: HomeScreen(
              onErrorAuth: () {
                isLoggedIn = false;
                notifyListeners();
              },
              onLoggedOut: () {
                isLoggedIn = false;
                notifyListeners();
              },
              uploadStoryPage: () {
                isUploadStoryPage = true;
                notifyListeners();
              },
              detailStoryPage: (selectedId) {
                isDetailStory = true;
                storyId = selectedId;
                notifyListeners();
              },
            )),
        if (isUploadStoryPage)
          MaterialPage(
            key: const ValueKey('UploadStory'),
            child: UploadStory(
              onUploadSuccess: () {
                isUploadSuccess = true;
                if (isUploadStoryPage) {
                  isUploadStoryPage = false;
                }
                print('upload success');
                notifyListeners();
              },
            ),
          ),
        if (isDetailStory)
          MaterialPage(
            key: const ValueKey('DetailStory'),
            child: DetailStory(
              storyId: storyId,
            ),
          ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
            key: const ValueKey('LoginPage'),
            child: LoginScreen(
              onLogin: () {
                isLoggedIn = true;
                notifyListeners();
              },
              onRegister: () {
                isRegister = true;
                notifyListeners();
              },
            )),
        if (isRegister)
          MaterialPage(
              key: const ValueKey('RegisterPage'),
              child: RegisterScreen(
                toLoginPage: () {
                  isRegister = false;
                  notifyListeners();
                },
              ))
      ];

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    print('init $isLoggedIn');
    notifyListeners();
  }

  AppRouterDelegate({required this.authRepository})
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }
  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        if (isUploadStoryPage) {
          isUploadStoryPage = false;
        }

        if (isDetailStory) {
          isDetailStory = false;
        }

        if (isRegister) {
          isRegister = false;
        }

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
