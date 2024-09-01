import 'package:duolingo/util/user_provider.dart';
import 'package:duolingo/views/app.dart';
import 'package:duolingo/views/quiz_screen/components/quiz_node.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../course_screen/components/course_node.dart';

class QuizScreenLevels extends StatelessWidget {
  const QuizScreenLevels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    String? username;
    try {
      final user = Provider.of<UserProvider>(context).user;   
      logger.info(user);
      if(user != null && user.username != 'Guest') {
        username = user.username;
      } else {
        logger.info('show alert');
        return AlertDialog(
          // title: Text('Hey there!', style: TextStyle(color: Colors.blue),),
          title: Text('You need to sign in to play the Quiz', style: TextStyle(color: Colors.blue),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.blue, width: 2), // Blue border
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Yes', style: TextStyle(color: Colors.green, fontSize: 18),),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16), // Background color of 'No'
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.red, fontSize: 18), // Red text color and increased font size
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Background color of 'No'
                      padding: EdgeInsets.symmetric(vertical: 16), // Increased padding to make button larger
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } catch (e) {
      logger.finer(e);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(15)),
          QuizNode(
            'Basic',
            level: 2,
          ),
          const Padding(padding: EdgeInsets.all(10)),
          QuizNode(
            'Intermediate',
            level: 4,
          ),
          const Padding(padding: EdgeInsets.all(10)),
          QuizNode(
            'Expert',
            image: 'assets/images/bandages.png',
            color: Colors.redAccent,
            level: 5,
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}
