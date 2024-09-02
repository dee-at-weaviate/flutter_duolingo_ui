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
  final Function(int, bool) onOptionSelected; 

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
  int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    // logger.info('in the quiz list ');
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        instruction(widget.instructionText),
        const Padding(padding: EdgeInsets.only(top: 15)),
        questionRow(widget.question),
        Expanded(
          child : Center(
            child: ListView.builder(
              itemCount: widget.answers.length,
              itemBuilder: (context, index) {
                return listChoice(widget.answers[index], widget.difficulty, index);
              },
            ),
          ),
        ),
        // const Spacer(),
        widget.checkButton,
      ],
    );
  }

  listChoice(String title, int difficulty, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
      padding: const EdgeInsets.all(10),
      // onPress: {},
      decoration: BoxDecoration(
        // padding: const Padding(padding: EdgeInsets.only(bottom: 10),),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2.5,
          color: Colors.green,
        ),
      ),
      child: tile(index, widget.answers[index], difficulty),
    );  
  }

  tile(index, text, int difficulty) {
    return RadioListTile<int>(
      title: Text(text, 
            style: TextStyle(
                    fontSize: 17, 
                    color: selectedAnswer == index ? Colors.green : Colors.black, )),
      value: index,
      groupValue: selectedAnswer,
      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), 
      selectedTileColor: Colors.green,
      onChanged: (value) {
        setState(() {
          selectedAnswer = value;
          bool isCorrect = index == widget.correctAnswer;
          widget.onOptionSelected(difficulty, isCorrect);
          
          // _showSnackBar(isCorrect);
        });
      },
    );
  }  

  questionRow(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        children: [
          // speakButton(),
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
