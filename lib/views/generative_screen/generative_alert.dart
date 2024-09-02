import 'package:duolingo/util/api.dart';
import 'package:duolingo/views/generative_screen/generative_screen.dart';
import 'package:duolingo/views/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';

class GenerativeAlertScreen extends StatefulWidget {
  
  @override
  _GenerativeAlertDialogState createState() => _GenerativeAlertDialogState();

}


class _GenerativeAlertDialogState extends State<GenerativeAlertScreen> {
  String selectedValue = 'Introduce yourself'; 
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
                'Generate personalized lessons',
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
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {                    
                    selectedValue = newValue!;
                  });
                },
                items: <String>['Introduce yourself','Talk about family and friends', 'Order in a restaurant', 'Navigate a city', 'Buy things in a store']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                      logger.info(selectedValue);
                      String userInput = _textController.text;
                      logger.info(userInput);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GenerativeScreen(selectedValue, userInput),
                        ),
                      );
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
          ],
        );

     
  }

}
