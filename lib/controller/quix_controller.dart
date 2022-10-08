import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:programming_hero_quiz_app/api_service.dart';
import 'package:programming_hero_quiz_app/models/quiz_model.dart';
import 'package:programming_hero_quiz_app/utils.dart';

class QuizController extends GetxController with GetSingleTickerProviderStateMixin{
  final quizList = Rxn<Questions>().obs;
  final totalScore = 0.obs;
  AnimationController? animationController;
  Animation? animationPrime;
  Animation? get animation => animationPrime;
  // final PageController controller = PageController();
  final ApiService _apiService = ApiService();
  final box = GetStorage();

  @override
  void onInit(){
  animationController = AnimationController(duration: const Duration(seconds: 10),vsync: this);
  // animationPrime = Tween<double>(begin: 0 ,end: 1).animate(animationController!)..addListener(() {
  //   update();
  // });
  // animationController!.forward();

  getAllQuestions().then((value){
      quizList.value.value = questionsFromJson(value);
    });
    super.onInit();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  Future getAllQuestions() async {
    String url = BASE_URL;
    return await _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }
}