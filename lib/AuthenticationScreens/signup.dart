import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Constants/constants.dart';
import 'package:news_app/CustomWidgets/enterButton.dart';
import 'package:news_app/CustomWidgets/textInput.dart';
//import 'package:lib/CustomWidgets/textInput.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User is signed up successfully
      Navigator.pushNamed(context,'/homepage');
      print('User signed up: ${userCredential.user!.email}');
    } on FirebaseAuthException catch (e) {
      if(e.code=='weak password'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak'),
              backgroundColor: Colors.red,
            ),
        );
      }
      else if(e.code=='email already in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already in-use'),
            backgroundColor: Colors.red,
          ),
        );
      }
      // Handle login errors here
      print('Error during login: $e');
    }
  }

  @override

  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('MyNews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppStyle.appBlue,
            fontSize: 21,
          ),
        ),
        backgroundColor: AppStyle.appLightBlue, //Color(0xfff5f8fd),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: AppStyle.appLightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height/(6.69),),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextInput(
                        w: 392,
                        hintText: 'Name',
                      controller: _nameController,
                    ),
                    SizedBox(height: 10),
                    TextInput(
                      w: 392,
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    SizedBox(height: 10),
                    TextInput(
                      w: 392,
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                  ],
                ),
              ), //inputs
              SizedBox(height: height/3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EnterButton(
                     function: (){
                       _signUp();
                      },
                    text: 'Signup' ,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already a member?',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context,'/login');

                        },
                        child: Text(
                          'Login',
                          style:  GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:AppStyle.appBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),        //signup button
             // SizedBox(height: height/11),
            ],
          ),       //main-body
        ),
      ),
    );
  }
}
