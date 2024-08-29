import 'package:flutter/material.dart';
import 'package:duolingo/util/user_provider.dart';
import 'package:duolingo/views/app.dart';
import 'package:provider/provider.dart';


class LeaderboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LeaderboardAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(250);
 

  @override
  Widget build(BuildContext context) {

    String? username;
    String? email;
    try {
      final user = Provider.of<UserProvider>(context).user;      
      if(user != null) {
        username = user.name;
        email = user.email;
      } else {
        username = 'Guest';
        email = "";
      }
    } catch (e) {
      logger.finer(e);
    }
    
    return AppBar(
      toolbarHeight: 250,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 2.0,
      title: Column(
        children: [
          leagues(),
          bigTitle('Leaderboard'),
          message(username),
          remainingDay(email),
        ],
      ),
    );
  }

  leagues() {
    ScrollController _controller =
        ScrollController(initialScrollOffset: 89.8 * 4.4);

    return SizedBox(
      height: 100,
      child: ListView(
        // itemExtent: 80,
        controller: _controller,
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Image.asset('assets/images/badge_bronze_blank.png'),
          Image.asset('assets/images/badge_silver_blank.png'),
          Image.asset('assets/images/badge_gold_blank.png'),
          Image.asset('assets/images/badge_diamond_blank.png'),
          Image.asset('assets/images/badge_ruby_blank.png'),
          Image.asset('assets/images/badge_emerald_blank.png'),
          Container(
            margin: const EdgeInsets.only(left: 12, right: 8),
            child: Image.asset('assets/images/badge_amethyst.png', scale: 0.5),
          ),
          Image.asset('assets/images/badge_locked.png'),
          Image.asset('assets/images/badge_locked.png'),
          Image.asset('assets/images/badge_locked.png'),
        ],
      ),
    );
  }

  remainingDay(text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFC800),
        ),
      ),
    );
  }

  message(text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFFAFAFAF),
        ),
      ),
    );
  }

  bigTitle(text) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4B4B4B),
        ),
      ),
    );
  }
}
