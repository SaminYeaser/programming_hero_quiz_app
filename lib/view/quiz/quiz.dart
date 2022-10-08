import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:programming_hero_quiz_app/controller/quix_controller.dart';
import 'package:programming_hero_quiz_app/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../score_dashboard/score_dashboard.dart';
class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizController _quizController = Get.find();



  // final CountdownController _controller = CountdownController(autoStart: false);
  final pages = 1.obs;
  void nextScreen(){
    _quizController.controller.nextPage(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn
    );

  }
  @override
  void initState() {
    _quizController.animationPrime = Tween<double>(begin: 0 ,end: 1).animate(_quizController.animationController!)..addListener(() {
      _quizController.update();
    });
    _quizController.animationController!.forward();

    // _quizController.animationController!.addStatusListener((status) {
    //   _quizController.animationController!.reset();
    //   nextScreen();
    // });
    super.initState();
  }

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
                    child: Obx(()=>Text('Score: ${_quizController.totalScore}',style: TextStyle(
                        color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold
                    ),)),
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
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _quizController.controller,
                  itemCount: _quizController.quizList.value.value!.questions!.length,
                  onPageChanged: (value){
                    pages.value = value + 1;
                    _quizController.animationPrime = Tween<double>(begin: 0,end: 1).animate(_quizController.animationController!)..addListener(() {
                      _quizController.update();
                    });
                    _quizController.animationController!.forward();
                  },
                  itemBuilder: (context, index){
                    // pages.value = index + 1;
                    return
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: double.infinity,
                              height: 30,
                              child: GetBuilder<QuizController>(
                                  init: QuizController(),
                                  builder: (stackController) {
                                    // print(controller.animation!.value);
                                    return Stack(
                                      children: [
                                        LayoutBuilder(
                                          builder: (context, constraints) => Center(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width:  constraints.maxWidth * stackController.animation!.value,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(10)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // WebsafeSvg.asset("assets/icons/clock.svg"),
                                        Positioned.fill(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                            child: Text(
                                              '${(stackController.animation!.value * 10).round()} Sec',),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(height: 10,),
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
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer,
                                questionNumber: 'A',
                                score: _quizController.quizList.value.value!.questions![index].score,
                                pageController: _quizController.controller,
                              pageNumber: pages.value
                            ),
                            questionAnswer(
                                text:_quizController.quizList.value.value!.questions![index].answers!.b,
                                context: context,
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer,
                                questionNumber: 'B',
                                score: _quizController.quizList.value.value!.questions![index].score,
                                pageController: _quizController.controller,
                                pageNumber: pages.value
                            ),
                            _quizController.quizList.value.value!.questions![index].answers!.c == null ?
                            Container():
                            questionAnswer(
                                text:_quizController.quizList.value.value!.questions![index].answers!.c,
                                context: context,
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer,
                                questionNumber: 'C',
                                score: _quizController.quizList.value.value!.questions![index].score,
                                pageController: _quizController.controller,
                                pageNumber: pages.value
                            ),
                            _quizController.quizList.value.value!.questions![index].answers!.d == null ?
                            Container():
                            questionAnswer(
                                text:_quizController.quizList.value.value!.questions![index].answers!.d,
                                context: context,
                                correctAnswer: _quizController.quizList.value.value!.questions![index].correctAnswer,
                                questionNumber: 'D',
                                score: _quizController.quizList.value.value!.questions![index].score,
                                pageController: _quizController.controller,
                                pageNumber: pages.value
                            ),
                            SizedBox(height: 10,),
                            Obx(()=>Visibility(
                              visible: _quizController.quizList.value.value!.questions!.length == pages.value ?
                              true : false,
                              child: InkWell(
                                onTap: (){
                                  Get.to(ScoreDashboard());
                                  _quizController.controller.dispose();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8),
                                    child: Text('Go to Scoreboard',
                                      style: TextStyle(
                                        color: primaryColor, fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),textAlign: TextAlign.center,),
                                  ),
                                ),
                              ),
                            ))
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
Widget questionAnswer({
  text, context, correctAnswer, questionNumber,int? score,pageController,
  pageNumber
}){
  final isClicked = false.obs;
  QuizController _quizController = Get.find();
  return   InkWell(
    onTap: (){
      if(correctAnswer == questionNumber){

          isClicked.value = true;
          _quizController.totalScore.value += score!;
          if(_quizController.quizList.value.value!.questions!.length != pageNumber){
            Future.delayed(const Duration(seconds: 2), () {
              pageController.nextPage(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeIn
              );
              _quizController.animationController!.reset();
            });
          }

          if( _quizController.box.read('score') == null){
            _quizController.box.write('score', _quizController.totalScore.value);
            print('written');
          }else if(_quizController.box.read('score') < _quizController.totalScore.value){
            _quizController.box.write('score', _quizController.totalScore.value);
            print('written');
          }

      }else{
        isClicked.value = true;
        if(_quizController.quizList.value.value!.questions!.length != pageNumber){
          Future.delayed(const Duration(seconds: 2), () {
            pageController.nextPage(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn
            );
            _quizController.animationController!.reset();
          });
        }
        if( _quizController.box.read('score') == null){
          _quizController.box.write('score', _quizController.totalScore.value);
          print('written');
        }else if(_quizController.box.read('score') < _quizController.totalScore.value){
          _quizController.box.write('score', _quizController.totalScore.value);
          print('written');
        }
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Obx(()=>Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: correctAnswer == questionNumber ?
            Border.all(color: Colors.green,width: 3,
                style: isClicked.value ? BorderStyle.solid : BorderStyle.none) :
            Border.all(color: Colors.red,width: 3,
                style: isClicked.value ? BorderStyle.solid : BorderStyle.none)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(text,textAlign: TextAlign.center,),
        ),
      )),
    ),
  );
}