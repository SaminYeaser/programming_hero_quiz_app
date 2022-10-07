import 'dart:convert';

import 'package:get/get.dart';
import 'package:programming_hero_quiz_app/api_service.dart';
import 'package:programming_hero_quiz_app/models/quiz_model.dart';
import 'package:programming_hero_quiz_app/utils.dart';

class QuizController extends GetxController{
  final quizList = Rxn<Questions>().obs;
  final totalScore = 0.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() async{

    await getAllQuestions().then((value){
      quizList.value.value = questionsFromJson(value);
    });
    super.onInit();
  }

  Future getAllQuestions() async {
    String url = BASE_URL;
    return await _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }
}