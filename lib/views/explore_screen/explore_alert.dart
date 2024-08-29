import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/explore_screen/explore_screen.dart';
import 'package:duolingo/views/generative_screen/generative_screen.dart';
import 'package:duolingo/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';

class ExploreAlertScreen extends StatefulWidget {
  
  @override
  _ExploreAlertDialogState createState() => _ExploreAlertDialogState();

}


class _ExploreAlertDialogState extends State<ExploreAlertScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {  

    return AlertDialog(
          title: Text('Your personal tutor', style: TextStyle(color: Colors.blue),),
          // content: Text('Generate tailored tutorials', style: TextStyle(color: Colors.blue),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Find phrases to help you practise',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textController,
                maxLength: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your query here... ',
                  counterText: '', // To remove the default character counter
                ),
              ),
            ],
          ),
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
                      String userInput = _textController.text;
                      logger.info(userInput);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ExploreScreen(userInput),
                        ),
                      );
                    },
                    child: Text('Search', style: TextStyle(color: Colors.green, fontSize: 18),),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16), // Background color of 'No'
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

     
  }

}
