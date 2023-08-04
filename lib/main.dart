import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/AuthenticationScreens/login.dart';
import 'package:news_app/AuthenticationScreens/signup.dart';
import 'package:news_app/CustomWidgets/newsPost.dart';
import 'package:news_app/HomePage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'signup',
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      routes: {
        '/': (context) => const SignUp(),
        '/signup': (context) => const SignUp(),
        '/login': (context) => const Login(),
        '/homepage': (context) => const HomePage(),
        },
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
    );
  }
}
