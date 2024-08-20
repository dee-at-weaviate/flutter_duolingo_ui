import 'package:duolingo/views/quiz_screen/components/quiz_node.dart';
import 'package:flutter/material.dart';

import '../course_screen/components/course_node.dart';
// import 'package:logging/logging.dart';

// final Logger logger = Logger('CourseTree');


class QuizScreenLevels extends StatelessWidget {
  const QuizScreenLevels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // logger.info('in build of course tree');
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(15)),
          QuizNode(
            'Basic',
            crown: 1,
          ),
          const Padding(padding: EdgeInsets.all(10)),
          QuizNode(
            'Intermediate',
            crown: 1,
          ),
          const Padding(padding: EdgeInsets.all(10)),
          QuizNode(
            'Expert',
            image: 'assets/images/bandages.png',
            color: Colors.redAccent,
            crown: 4,
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}
