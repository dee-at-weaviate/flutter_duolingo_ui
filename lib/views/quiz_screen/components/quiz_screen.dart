import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:duolingo/views/lesson_screen/components/bottom_button.dart';
import 'package:duolingo/views/lesson_screen/components/lesson_app_bar.dart';
import 'package:duolingo/views/quiz_screen/components/list_quiz.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:logging/logging.dart';

class QuizScreen extends StatefulWidget {
  final String level;

  const QuizScreen ({ required this.level});

  @override
  State<StatefulWidget> createState() {
    return QuizScreenState();
  }
}

class QuizScreenState extends State<QuizScreen> {
  double percent = 0.2;
  int index = 0;
  late List questions;
  int totalScore = 0;
  int currentScore = 0;

  void _postScoretoLeaderboard(userID, totalScore) async {
    try {
      String url = "quiz/score";
      final Map<String, dynamic> data = {
        'user_id': userID,
        'totalScore' : totalScore
      };
      final response = await API.post(url, json.encode(data));
      logger.info(response);
      // response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      // return [];
    }
  }

  Future<List<dynamic>> _loadQuestions(courseId) async {
    logger.info('fetching quiz questions');
    String url = "quiz/level/" + widget.level;
    try {
      final response = await API.get(url);
      // logger.info(response['questions']);
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // logger.info('in build of quiz node');
    var newLessons = [];
    // int points = 0;
    return FutureBuilder(
      future: _loadQuestions(widget.level), 
      builder: (context, snapshot) {        
        if(snapshot.hasData) {
          questions = snapshot.data as List<dynamic>;
          logger.info(questions);
          logger.info(questions[0]);
          // var newLessons = [];
          for (int i=0; i< questions.length; i++) {
            newLessons.add(
              ListQuiz('Translate the sentence', questions[i]['text'],
              [questions[i]['image_1'], questions[i]['image_2'], questions[i]['image_3'], questions[i]['image_4']],
              questions[i]['answer'], 5,
              checkButton: bottomButton(context, 'NEXT'),
              onOptionSelected: (points) {                
                currentScore = points;
                logger.info('currentScore: $currentScore');
              }));
          }
          logger.info(newLessons);
          return Scaffold(
            appBar: LessonAppBar(percent: percent),
            body: newLessons[index],
          );
        } else {
          return Text('noooo');
        }      
      }
    );
  } 



  bottomButton(BuildContext context, String title) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              totalScore += currentScore;
              if (percent < 1) {
                percent += 0.4;                
                logger.info('totalScore: $totalScore');
                index++;
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    _postScoretoLeaderboard('4f6d053f-5d19-487f-b9e3-8898dc977230', totalScore);
                    return dialog('Great score $totalScore ');
                  },
                ).then((_) {
                    Navigator.pushNamed(context, '/home');
                });
                
              }
            });
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF58CC02),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  dialog(String title) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFFd7ffb8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dialogTitle(title),
            BottomButton(context, title: 'CONTINUE'),
          ],
        ),
      ),
    );
  }

  dialogTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.only(left: 15),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF43C000),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
