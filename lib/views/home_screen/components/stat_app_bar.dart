import 'package:duolingo/util/user_provider.dart';
import 'package:duolingo/views/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatAppBar({Key? key}) : super(key: key);
  // final Provider  userProvider;

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    String? username;
    final userProvider = Provider.of<UserProvider>(context);
    try {
      final user = userProvider.user;   
      // logger.info('in app bar');
      // logger.info(user);   
      if(user != null) {
        username = user.username;
      } else {
        username = 'Guest';
      }
    } catch (e) {
      logger.finer(e);
    }

    return AppBar(
      toolbarHeight: 120,
      backgroundColor: Colors.white,
      elevation: 1.5,
      leading: logout(context, userProvider, username),
      title: Row(
        children: [
          const Padding(padding: EdgeInsets.all(20)),
          title(),
        ],
      ),
      actions: [
        heart(username),
      ],
    );
  }

  Widget heart(username) {
    return Row(
      children: [
        Image.asset(
          'assets/images/heart.png',
          width: 36,
        ),
        const Padding(
          padding: EdgeInsets.all(2),
        ),
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF9600),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5),
        ),
      ],
    );
  }

  Widget title() {
    return Row(
      children: [
        Image.asset(
          'assets/icons/wealingo.png',
          width: 24,
        ),
        const Padding(
          padding: EdgeInsets.all(4),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Tutorials',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget crown(int n) {
    return Row(
      children: [
        Image.asset(
          'assets/images/crown.png',
          width: 30,
        ),
        const Padding(
          padding: EdgeInsets.all(4),
        ),
        Text(
          '$n',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFC800),
          ),
        )
      ],
    );
  }

  Widget logout(context, userProvider, username) {
    return GestureDetector(
      onTap: () {
        logger.info('tapped');
        userProvider.clearUser();
        Navigator.pushNamed(context, '/home');
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          username =='Guest'?'': 'Logout',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      )
    ); 
  }

}
