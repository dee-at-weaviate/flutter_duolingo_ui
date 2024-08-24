import 'package:duolingo/shared/firebase_authentication.dart';
import 'package:duolingo/util/user_provider.dart';
import 'package:duolingo/views/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleButton extends StatefulWidget {
  final FirebaseAuthentication auth;

  const GoogleButton(this.auth, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return GoogleButtonState();
  }
}

class GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 3, color: Colors.grey.shade400)),
        child: ElevatedButton(
          onPressed: googlePressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/google-icon.png',
                height: 20,
              ),
              Text(
                ' GOOGLE',
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 5,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  googlePressed() {
    widget.auth.loginWithGoogle().then((value) {
      if (value == null) {
        setState(() {
          print('Google failed');
          // _message = 'Google Login Error';
        });
      } else {
        setState(() {
          // print('Google good: $value');
          logger.info(value);
          logger.info(value.user);
          String? name = value.user?.displayName;
          String? email = value.user?.email;
          logger.info(name);
          logger.info(email);
          User user = User(name: name , email: email);
          Provider.of<UserProvider>(context, listen: false).setUser(user);

          
        
        // Navigate to the home screen
          Navigator.pushNamed(context, '/home');

          // _message = 'User $value successfully logged in with Google';
        });
      }
    });
  }
}
