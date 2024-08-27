import 'package:duolingo/util/user_provider.dart';
import 'package:duolingo/views/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(75);

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
      toolbarHeight: 400,
      backgroundColor: Colors.white,
      elevation: 1.5,
      leading: account(username, email),
      leadingWidth: 500,
      centerTitle: false,
      actions: [
        avatar(),
      ],
    );
  }

  Widget avatar() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/images/profile.jpg'),
        radius: 37,
      ),
    );
  }

  Widget account(username, email) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              username,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B4B4B),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              email,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFFAFAFAF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
