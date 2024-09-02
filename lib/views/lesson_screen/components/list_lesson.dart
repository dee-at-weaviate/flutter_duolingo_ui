import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/lesson_screen/components/bottom_button.dart';
import 'package:duolingo/views/lesson_screen/components/stage_changed.dart';
import 'package:flutter/material.dart';

class ListLesson extends StatefulWidget {
  Widget checkButton;
  String questionType;
  String question;
  List<String> answers;
  int correctAnswer;
  String instruction;

  ListLesson(
    this.questionType, this.question, 
    this.answers, this.correctAnswer, this.instruction,
    {required this.checkButton, Key? key}
    ) : super(key: key);

  @override
  _ListLessonWidgetState createState() => _ListLessonWidgetState();
}

class _ListLessonWidgetState extends State<ListLesson> {
  int? selectedAnswer = 1;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        questionType(widget.questionType),
        const Padding(padding: EdgeInsets.only(top: 15)),
        questionRow(widget.question),
        Expanded(
          child : Center(
            child: ListView.builder(
              itemCount: widget.answers.length,
              itemBuilder: (context, index) {
                return listChoice(widget.answers[index], index);
              },
            ),
          ),
        ),
        instruction(widget.instruction),
        widget.checkButton,
      ],
    );
  }

  listChoice(String title, int index) {
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
      child: tile(index, widget.answers[index], widget.correctAnswer),
    );  
  }

  tile(index, text, correctAnswer) {
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
          _showSnackBar(isCorrect);
        });
      },
    );
  }  

  void _showSnackBar(bool isCorrect) {
    final snackBar = SnackBar(
      content: Text(isCorrect ? 'Good job!' : 'Wrong answer'),
      backgroundColor: Colors.indigo,
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating, 
      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).size.height * 0.4), 
      margin: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).size.height * 0.2,),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  instruction(String instruction) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 55),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          instruction,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
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

  questionType(String text) {
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
