import 'package:flutter/material.dart';
import 'package:programming_hero_quiz_app/utils.dart';
import 'package:get/get.dart';

import '../quiz/quiz.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image.asset('assets/Logo.png'),
              SizedBox(height: 15,),
              Text('Quiz',style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 40,),
              Text('Highscore',style: TextStyle(
                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 5,),
              Text('500 Points',style: TextStyle(
                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 40,),

              InkWell(
                onTap: (){
                  Get.to(QuizPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 8),
                    child: Text('Start', style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
