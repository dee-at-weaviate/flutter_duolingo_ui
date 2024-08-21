import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/lesson_screen/components/bottom_button.dart';
import 'package:duolingo/views/lesson_screen/components/stage_changed.dart';
import 'package:flutter/material.dart';

class ListQuiz extends StatelessWidget {
  Widget checkButton;
  String instructionText;
  String question;
  List<String> answers;
  int correctAnswer;
  int difficulty;
  // final ValueNotifier<Color> colorNotifier;
  final Function(int) onOptionSelected; 


  ListQuiz(
    this.instructionText, this.question, 
    this.answers, this.correctAnswer,
    this.difficulty,
    {required this.checkButton,
    // required this.colorNotifier, 
    required this.onOptionSelected, 
    Key? key}
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('in the quiz list ');
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        instruction(instructionText),
        const Padding(padding: EdgeInsets.only(top: 15)),
        questionRow(question),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                listChoice(context, answers[0], difficulty, ValueNotifier<Color>(Colors.white)),
                const Padding(padding: EdgeInsets.only(bottom: 15),),
                listChoice(context, answers[1], difficulty, ValueNotifier<Color>(Colors.white)),
                const Padding(padding: EdgeInsets.only(bottom: 15),),
                listChoice(context, answers[2], 3, ValueNotifier<Color>(Colors.white)),
                const Padding(padding: EdgeInsets.only(bottom: 15),),
                listChoice(context, answers[3], 4, ValueNotifier<Color>(Colors.white)),
              ],
            ),
          ),
        ),
        const Spacer(),
        checkButton,
      ],
    );
  }

  listChoice(BuildContext context, String title, int difficulty, ValueNotifier<Color> colorNotifier) {
    return GestureDetector(
      onTap: () {
        logger.info('tapped');
        if (colorNotifier.value == Colors.white) {
          colorNotifier.value = Colors.greenAccent;
        } else {
          colorNotifier.value = Colors.white;
        }
        // colorNotifier.value = Colors.greenAccent;
        onOptionSelected(difficulty);
      },
      child: ValueListenableBuilder<Color>(
        valueListenable: colorNotifier, 
        builder: (context, color, child) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(15),
            // onPress: {},
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2.5,
                color: const Color(0xFFE5E5E5),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 17),
            ),
          );
      })      
    );   
  }

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        children: [
          speakButton(),
          const Padding(padding: EdgeInsets.only(right: 15)),
          Text(
            question,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B4B4B)),
          )
        ],
      ),
    );
  }

  speakButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF1CB0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.volume_up,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  instruction(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }
}
