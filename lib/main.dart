import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/app/my_app.dart';
import 'package:weather_app/core/utils/api/api_client.dart';
import 'package:weather_app/core/utils/helpers/app_cache.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/core/utils/helpers/bloc_observer.dart';

import 'service_locator_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await ScreenUtil.ensureScreenSize();
  ServiceLocator.init();
  ApiClient.init();
  AppCache.init();
  AppSecureStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

void setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
}
