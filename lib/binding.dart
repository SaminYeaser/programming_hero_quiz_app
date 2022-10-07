import 'package:get/get.dart';
import 'package:programming_hero_quiz_app/controller/quix_controller.dart';

class AllBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QuizController());
  }
}