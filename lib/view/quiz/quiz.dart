import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programming_hero_quiz_app/controller/quix_controller.dart';
import 'package:programming_hero_quiz_app/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class QuizPage extends GetView {
  QuizPage({Key? key}) : super(key: key);

  final QuizController _quizController = Get.find();
  final PageController controller = PageController(initialPage: 0);
  final pages = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: primaryColor,
      body:
      SafeArea(
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Obx(()=>
                    _quizController.quizList.value.value == null ?
                    Center(child: CircularProgressIndicator(),):
                    Text('${(pages.value)}/${_quizController.quizList.value.value!.questions!.length}',style: TextStyle(
                        color: primaryColor, fontSize: 18, fontWeight: FontWeight.w700
                    ),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Text('Score: ${_quizController.totalScore}',style: TextStyle(
                        color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold
                    ),),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Obx(()=>
              _quizController.quizList.value.value == null ?
              Center(child: CircularProgressIndicator(),):
              PageView.builder(
                  controller: controller,
                  itemCount: _quizController.quizList.value.value!.questions!.length,
                  onPageChanged: (value){
                    pages.value = value + 1;
                  },
                  itemBuilder: (context, index){
                    // pages.value = index + 1;
                    return
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('${_quizController.quizList.value.value!.questions![index].score} Points',
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold
                                      ),),
                                    SizedBox(height: 10,),
                                    _quizController.quizList.value.value!.questions![index].questionImageUrl == null ||
                                        _quizController.quizList.value.value!.questions![index].questionImageUrl == 'null' ?
                                    Container():

                                    Image.network(

                                      '${_quizController.quizList.value.value!.questions![index].questionImageUrl}',
                                      loadingBuilder:(context, child, loadingProgress){
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null ?
                                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(height: 10,),
                                    Text('${_quizController.quizList.value.value!.questions![index].question}',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 18
                                      ),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            questionAnswer(
                              text:_quizController.quizList.value.value!.questions![index].answers!.a,
                              context: context,
                              correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer
                            ),
                            questionAnswer(
                                text:_quizController.quizList.value.value!.questions![index].answers!.b,
                                context: context,
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer
                            ),
                            _quizController.quizList.value.value!.questions![index].answers!.c == null ?
                            Container():
                            questionAnswer(
                                text:_quizController.quizList.value.value!.questions![index].answers!.c,
                                context: context,
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer
                            ),
                            _quizController.quizList.value.value!.questions![index].answers!.d == null ?
                            Container():
                            questionAnswer(
                                text:_quizController.quizList.value.value!.questions![index].answers!.d,
                                context: context,
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer
                            ),
                          ],
                        ),
                      );
                  })),
            ),

          ],
        ),
      ),
    );
  }
}
Widget questionAnswer({text, context, correctAnswer}){
  return InkWell(
    onTap: (){

    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(text,textAlign: TextAlign.center,),
        ),
      ),
    ),
  );
}