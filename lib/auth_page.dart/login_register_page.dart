import 'package:flutter/material.dart';
import 'package:senior_hekmat/auth_page.dart/ragister_page.dart';

import 'login_page.dart';


class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

//hon he page la etna2al ben sign in w sign up pages tb3it l user

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  bool show = true;


  void tooglePages() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return LoginPage(
        onTap: tooglePages,
      );
    } else {
      return RegisterPage(
        onTap: tooglePages,
      );
    }
  }
}