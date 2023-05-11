
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_hekmat/auth_page.dart/login_register_page.dart';
import 'package:senior_hekmat/home/home_page.dart';

//heda class auth la 7ta a3rf ana wen bkon b aya page fa iza fi 
//information w ma3mol login aw sign up d8ri byji bl home page

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}