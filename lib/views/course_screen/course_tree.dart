import 'package:flutter/material.dart';

import 'components/course_node.dart';
import 'components/double_course_node.dart';
import 'components/triple_course_node.dart';
import 'package:logging/logging.dart';

final Logger logger = Logger('CourseTree');


class CourseTree extends StatelessWidget {
  const CourseTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // logger.info('in build of course tree');
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(15)),
          CourseNode(
            'Basics',
            crown: 1,
          ),
          const Padding(padding: EdgeInsets.all(10)),
          DoubleCourseNode(
            CourseNode(
              'Introduce Yourself',
              image: 'assets/images/hand.png',
              color: Colors.yellow,
              percent: 1,
              crown: 1,
            ),
            CourseNode(
              'Navigate a City',
              image: 'assets/images/pen.png',
              color: const Color(0xFFCE82FF),
              crown: 2,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          DoubleCourseNode(
            CourseNode(
              'Talk about family and friends',
              image: 'assets/images/fish.png',
              color: Colors.green,
              // percent: 0.2,
              crown: 3,
            ),
            CourseNode(
              'Order in a restaurant',
              image: 'assets/images/bucket.png',
              color: Colors.blue,
              percent: 1,
              crown: 1,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          CourseNode(
            'Buy things in a store',
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
