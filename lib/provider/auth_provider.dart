import 'package:flutter/foundation.dart';
import 'package:zul_story_app/data/api/api_service.dart';
import 'package:zul_story_app/data/model/login_response.dart';
import 'package:zul_story_app/data/model/register_response.dart';
import 'package:zul_story_app/data/model/user_model.dart';
import 'package:zul_story_app/data/preference/preference_helper.dart';
import 'package:zul_story_app/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;
  final PreferenceHelper preferenceHelper;

  AuthProvider(
      {required this.apiService,
      required this.authRepository,
      required this.preferenceHelper});

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

  login(User user, onLoginFailed, onLoginSuccess) async {
    isLoadingLogin = true;
    notifyListeners();

    var response = await apiService.login(user);
    print(response);

    var loginResponse = LoginResponse.fromJson(response);
    if (loginResponse.error) {
      isLoadingLogin = false;
      notifyListeners();
      return onLoginFailed(loginResponse.message);
    }

    preferenceHelper.saveAccessToken(loginResponse.loginResult.token);
    preferenceHelper.saveString('USERNAME', loginResponse.loginResult.name);

    onLoginSuccess(loginResponse);
    isLoadingLogin = false;
    notifyListeners();
  }

  register(User user, onRegisterFailed, onRegisterSuccess) async {
    isLoadingRegister = true;
    notifyListeners();

    var response = await apiService.register(user);
    print(response);

    var registerResponse = RegisterResponse.fromJson(response);
    if (registerResponse.error) {
      isLoadingRegister = false;
      notifyListeners();
      return onRegisterFailed(registerResponse.message);
    }

    onRegisterSuccess(registerResponse);
    isLoadingRegister = false;
    notifyListeners();
  }
}
