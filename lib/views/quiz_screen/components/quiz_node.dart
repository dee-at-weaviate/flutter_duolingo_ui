import 'package:duolingo/views/app.dart';
import 'package:duolingo/views/course_screen/components/course_popup.dart';
import 'package:duolingo/views/lesson_screen/lesson_screen.dart';
import 'package:duolingo/views/quiz_screen/components/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizNode extends StatelessWidget {
  final String name;
  String? image;
  Color? color;
  final int level;
  double? percent;

  QuizNode(this.name,
      {this.image, this.color, required this.level, this.percent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // logger.info('in build of quiz node');
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  QuizScreen(level: level),
              ),
            );
          },
          child: node(),
        ),
        const Padding(padding: EdgeInsets.all(5)),
        courseName(),
      ],
    );
  }

  node() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            progressCircle(),
            CircleAvatar(
              backgroundColor: color ?? const Color(0xFF2B70C9),
              radius: 37,
            ),
            Image.asset(
              image ?? 'assets/images/egg.png',
              width: 42,
            ),
            subCrown(),
          ],
        ),
      ],
    );
  }

  progressCircle() {
    return Transform.rotate(
      angle: 2.7,
      child: CircularPercentIndicator(
        radius: 55.0,
        lineWidth: 10.0,
        percent: percent ?? 0,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: const Color(0xFFFFC800),
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }

  subCrown() {
    return Positioned(
      right: 0,
      bottom: 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/crown.png', width: 40),
          Text(
            '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color(0xFFB66E28),
            ),
          ),
        ],
      ),
    );
  }

  courseName() {
    return Text(name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
  }
}
