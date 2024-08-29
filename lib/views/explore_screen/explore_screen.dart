import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final String searchInput;
  const ExploreScreen(this.searchInput, {Key? key}) : super(key: key);

  Future<List<dynamic>> _generateQuestions() async {
    logger.info('in generate quesitons');
    String url = "questions/search/$searchInput";
    try {
      final response = await API.get(url);
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  Widget build(BuildContext context) {
    logger.info('in build of generative screen quesitons');
    return Scaffold(
      appBar: GenerativeAppBar(), // The app bar is rendered immediately
      body: FutureBuilder(
        future: _generateQuestions(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final questions = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return newsBox('assets/images/news-1.png',
                  questions[index]['text'],
                  questions[index]['answer'],
                  questions[index]['instruction']);
              }
            );
          } else {
            // Show a message if there's no data
            return Center(child: Text('No lessons available'));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 5)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LessonScreen(courseId: "cc0cfc6b-180a-4f21-a2f4-077391710866",),
              ),
            );
          },
          child: newsBox(
              'assets/images/news-1.png',
              'Stop! Grammar time!',
              'We have a few tricks up our sleeves for practicing grammar rules and patterns.',
              'May 19'),
        ),
        newsBox(
            'assets/images/news-2.png',
            'Duolingo ABC is now available!',
            'Learn more about the app that helps your child learn-and love!-to read.',
            'May 17'),
        newsBox(
            'assets/images/news-3.png',
            'What\'s it like to work at Duolingo?',
            'We asked one of our engineers to share a little bit about her experience. Check it out!',
            'May 12'),
        newsBox(
            'assets/images/news-4.png',
            'Repeat after me',
            'Or at least try these pronunciation tips for learning the sounds of your new language.',
            'May 11'),
        newsBox(
            'assets/images/news-5.png',
            'What\'s the most popular language among Gen Z',
            'We looked at the data to see what languages different generations tend to study, and we noticed a few cool trends.',
            'May 2'),
        const Padding(padding: EdgeInsets.only(top: 15))
      ],
    );
  }

  newsBox(String image, String title, String description, String date) {
    return Container(
      // height: 100,
      margin: const EdgeInsets.only(bottom: 5, top: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2.5,
          color: const Color(0xFFE5E5E5),
        ),
      ),
      child: Column(
        children: [
          imageBox(image),
          newsTitle(title),
          newsDescription(description),
          newsDate(date),
        ],
      ),
    );
  }

  newsDate(String date) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          date,
          style: const TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Color(0xFFAFAFAF),
          ),
        ),
      ),
    );
  }

  newsDescription(String description) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 10),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 17,
          // fontWeight: FontWeight.bold,
          color: Color(0xFF777777),
        ),
      ),
    );
  }

  newsTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }

  imageBox(String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 15, right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2.5,
          color: const Color(0xFFE5E5E5),
        ),
      ),
      child: Image.asset(
        image,
        height: 150,
        width: double.infinity,
      ),
    );
  }
}
