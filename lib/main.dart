import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_hekmat/auth_page.dart/auth_page.dart';
import 'package:senior_hekmat/home/home_page.dart';

import 'auth_page.dart/login_page.dart';
import 'auth_page.dart/provider/provider.dart';
import 'components/navigationbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
     MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: 
      MaterialApp(
        debugShowCheckedModeBanner: false,
     theme: ThemeData(
          fontFamily: "PathwayExtreme",
          scaffoldBackgroundColor:Colors.white,
          primaryColor: Colors.white,
           textTheme: TextTheme(
button: TextStyle(fontWeight: FontWeight.bold),
          
          ) ),
      
      home:  AuthPage(),
      ),
    );
  }
}