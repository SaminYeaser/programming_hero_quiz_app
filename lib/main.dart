import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:programming_hero_quiz_app/controller/quix_controller.dart';
import 'package:programming_hero_quiz_app/utils.dart';
import 'package:programming_hero_quiz_app/view/home/home.dart';

import 'binding.dart';

void main()async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllBinding(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Programming Hero Quiz Application',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Signika'
      ),
      home: AnimatedSplashScreen(
        backgroundColor: primaryColor,
        duration: 3000,
        splashIconSize: 500,
        splash: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/Logo.png'),
        ),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.slideTransition,
        // pageTransitionType: PageTransitionType.rightToLeft,
      ),
    );
  }
}
