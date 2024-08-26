import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/lesson_screen/components/bottom_button.dart';
import 'package:duolingo/views/lesson_screen/components/stage_changed.dart';
import 'package:flutter/material.dart';

class ListQuiz extends StatefulWidget {
  final Widget checkButton;
  final String instructionText;
  final String question;
  final List<String> answers;
  final int correctAnswer;
  final int difficulty;
  final Function(int) onOptionSelected; 

  @override
  State<StatefulWidget> createState() {
    return _ListQuizState();
  }

  ListQuiz(
    this.instructionText, this.question, 
    this.answers, this.correctAnswer,
    this.difficulty,
    {required this.checkButton,
    required this.onOptionSelected, 
    Key? key}
    ) : super(key: key);

}

class _ListQuizState extends State<ListQuiz> {  
  int? _selectedIndex;

  void resetSelection() {
    setState(() {
      _selectedIndex = null; // Reset the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.info('in the quiz list ');
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        instruction(widget.instructionText),
        const Padding(padding: EdgeInsets.only(top: 15)),
        questionRow(widget.question),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                listChoice(context, widget.answers[0], widget.difficulty, 0),
                const Padding(padding: EdgeInsets.only(bottom: 15),),
                listChoice(context, widget.answers[1], widget.difficulty, 1),
                const Padding(padding: EdgeInsets.only(bottom: 15),),
                listChoice(context, widget.answers[2], 3, 2),
                const Padding(padding: EdgeInsets.only(bottom: 15),),
                listChoice(context, widget.answers[3], 4, 3),
              ],
            ),
          ),
        ),
        const Spacer(),
        widget.checkButton,
      ],
    );
  }

  listChoice(BuildContext context, String title, int difficulty, int index) {
    return GestureDetector(
      onTap: () {
        logger.info('tapped');
        setState(() {
          _selectedIndex = (_selectedIndex == index) ? null : index;
        });
        widget.onOptionSelected(difficulty);
      },
      child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(15),
            // onPress: {},
            decoration: BoxDecoration(
              color: _selectedIndex == index ? Colors.greenAccent : Colors.white,
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
          )
            
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
