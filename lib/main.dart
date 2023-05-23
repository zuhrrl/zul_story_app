import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zul_story_app/data/api/api_service.dart';
import 'package:zul_story_app/data/preference/preference_helper.dart';
import 'package:zul_story_app/provider/auth_provider.dart';
import 'package:zul_story_app/provider/home_screen_module_provider.dart';
import 'package:zul_story_app/provider/upload_story_screen_module_provider.dart';
import 'package:zul_story_app/repository/auth_repository.dart';
import 'package:zul_story_app/routes/app_router_delegate.dart';
import 'package:zul_story_app/routes/page_manager.dart';

var preferenceHelper = PreferenceHelper();
var apiService = ApiService();
var authRepository = AuthRepository(apiService: apiService);
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => AuthProvider(
              apiService: apiService,
              authRepository: authRepository,
              preferenceHelper: preferenceHelper)),
      ChangeNotifierProvider(
        create: (context) => HomeScreenModuleProvider(
            apiService: apiService, preferenceHelper: preferenceHelper),
      ),
      ChangeNotifierProvider(
        create: (context) => UploadStoryScreenModuleProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouterDelegate appRouterDelegate;

  @override
  void initState() {
    super.initState();
    appRouterDelegate = AppRouterDelegate(authRepository: authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageManager(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Router(
            routerDelegate: appRouterDelegate,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )),
    );
  }
}
