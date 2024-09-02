import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/lesson_screen/components/bottom_button.dart';
import 'package:duolingo/views/lesson_screen/components/grid_lesson.dart';
import 'package:duolingo/views/lesson_screen/components/lesson_app_bar.dart';
import 'package:duolingo/views/lesson_screen/components/list_lesson.dart';
import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:logging/logging.dart';

// final Logger logger = Logger('LessonScreen');

class LessonScreen extends StatefulWidget {
  final String category;

  // const LessonScreen({Key? key}) : super(key: key);
  const LessonScreen ({ required this.category});

  @override
  State<StatefulWidget> createState() {
    return LessonScreenState();
  }
}

class LessonScreenState extends State<LessonScreen> {
  double percent = 0.2;
  int index = 0;
  late Future<List<dynamic>> questions;

  @override
  void initState() {
    super.initState();
    logger.info('in init load quesitons');
    questions = _loadQuestions(widget.category);
  }

  Future<List<dynamic>> _loadQuestions(category) async {
    // logger.info('in load quesitons');
    String url = "questions/all/$category";
    try {
      final response = await API.get(url);
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // logger.info('in build of lesson node');
    // var newLessons = [];
    return FutureBuilder(
      future: questions, 
      builder: (context, snapshot) {        
        if(snapshot.hasData) {
          List questions = snapshot.data as List<dynamic>;
          // logger.info(questions);
          var newLessons = [];
          for (int i=0; i< questions.length; i++) {
            String options = questions[i]['options'];
            String answer = questions[i]['answer'];
            List<String> optionsList = options.split("; ");
            optionsList.add(answer);
            optionsList.shuffle(Random());
            int chosen = optionsList.indexOf(answer);
            newLessons.add(
              ListLesson('Translate the sentence', questions[i]['question'],
              optionsList, chosen, questions[i]['instruction'],
              checkButton: bottomButton(context, 'NEXT')));
          }
          logger.info(newLessons);
          // newLessons.add(GridLesson(checkButton: bottomButton(context, 'Done')));

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
              if (index < 3) {
                // percent += 0.4;
                index++;
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialog('Great job');
                  },
                );
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
