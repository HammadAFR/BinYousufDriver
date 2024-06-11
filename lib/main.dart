import 'package:bin_yousuf_driver/core/constants/multi_providers_list.dart';
import 'package:bin_yousuf_driver/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  static const double _designWidth = 375;
  static const double _designHeight = 812;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(_designWidth, _designHeight),
      builder: (context, widget) {
        return MultiProvider(
          providers: providers,
          child: GetMaterialApp(
              title: 'Bin Yousaf',
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fadeIn,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFF8C21F),
                ),
                useMaterial3: true,
              ),
              home: const SplashScreen()),
        );
      },
    );
  }
}
