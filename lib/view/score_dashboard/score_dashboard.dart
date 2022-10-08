import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:programming_hero_quiz_app/controller/quix_controller.dart';
import 'package:programming_hero_quiz_app/utils.dart';
import 'package:programming_hero_quiz_app/view/home/home.dart';

class ScoreDashboard extends StatelessWidget {
  ScoreDashboard({Key? key}) : super(key: key);

  QuizController _quizController = Get.find();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            _quizController.totalScore.value = 0;
            box.write('prev_score', box.read('score'));
            Get.to(HomePage());
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8),
              child: Text('Play Again',textAlign: TextAlign.center, style: TextStyle(
                  color: primaryColor, fontWeight: FontWeight.bold,
                  fontSize: 18
              ),),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            box.read('prev_score') == null||
            box.read('prev_score') < box.read('score') ?
                Text('It\'s a HighScore!!!',style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w700,color: Colors.white
                ),) :
            Container(),
            SizedBox(height: 10,),
            Text('Your Score', style: TextStyle(
              fontSize: 30, color: Colors.white
            ),),
            SizedBox(height: 10,),
            Text('${_quizController.totalScore.value}',style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
