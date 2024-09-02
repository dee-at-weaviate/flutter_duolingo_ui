import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/home_screen/components/generative_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:duolingo/util/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class GenerativeScreen extends StatelessWidget {
  final String? category;
  final String? query;

  const GenerativeScreen(this.category, this.query, {Key? key}) : super(key: key);

  Future<List<dynamic>> _generateQuestions(userID) async {
    // logger.info('in generate quesitons');
    final Map<String, dynamic> data = {
        'user_id': userID,
        'category' : category,
        'query' : query
      };
    String url = 'questions/create';  
    
    // String url = userID==null?'questions/create/$category':'questions/create/$category&$userID';
    try {
      // final response = await API.get(url);
      final response = await API.post(url, json.encode(data));
      // logger.info(response);
      return response['questions'];
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return [];
    }
  }

  Widget build(BuildContext context) {
    // logger.info('in build of generative screen quesitons');
    String? userID;
    final userProvider = Provider.of<UserProvider>(context);
    try {
      final user = userProvider.user;   
      // logger.info('in app bar');
      // logger.info(user);   
      if(user != null) {
        userID = user.userID;
      } 
    } catch (e) {
      logger.finer(e);
    }
    return Scaffold(
      appBar: GenerativeAppBar(), // The app bar is rendered immediately
      body: FutureBuilder(
        future: _generateQuestions(userID), 
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
                logger.info(questions[index]);
                return newsBox('assets/images/news-1.png',
                  questions[index]['question'],
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

  newsBox(String image, String question, String answer, String instruction) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.all(10),
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
          // imageBox(image),
          newsTitle(question),
          newsDescription(answer),
          newsDate(instruction),
        ],
      ),
    );
  }

  newsDate(String instruction) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          instruction,
          style: const TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Color(0xFFAFAFAF),
          ),
        ),
      ),
    );
  }

  newsDescription(String answer) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 10),
      child: Text(
        answer,
        style: const TextStyle(
          fontSize: 17,
          // fontWeight: FontWeight.bold,
          color: Color(0xFF777777),
        ),
      ),
    );
  }

  newsTitle(String question) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 10),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          question,
          style: const TextStyle(
            fontSize: 18,
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
        height: 100,
        width: double.infinity,
      ),
    );
  }
}
