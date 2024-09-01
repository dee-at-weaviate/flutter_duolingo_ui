import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/home_screen/components/explore_app_bar.dart';
import 'package:duolingo/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final String searchInput;
  const ExploreScreen(this.searchInput, {Key? key}) : super(key: key);

  Future<List<dynamic>> _searchQuestions() async {
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
    logger.info('in search quesitons');
    return Scaffold(
      appBar: ExploreAppBar(), // The app bar is rendered immediately
      body: FutureBuilder(
        future: _searchQuestions(), 
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
                // logger.info(questions[index]);
                return newsBox('assets/images/news-1.png',
                  questions[index]['question'],
                  questions[index]['answer'],
                  questions[index]['instruction']?? '');
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
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 17,
            // fontWeight: FontWeight.bold,
            color: Color(0xFF777777),
          ),
        ),
      )
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
        height: 50,
        width: double.infinity,
      ),
    );
  }
}
