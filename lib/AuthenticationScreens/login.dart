import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Constants/constants.dart';
import 'package:news_app/CustomWidgets/enterButton.dart';
import 'package:news_app/CustomWidgets/textInput.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _logInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If login is successful, you can navigate to another screen or perform other actions
      Navigator.pushNamed(context,'/homepage');
      print('User logged in: ${userCredential.user!.email}');

    } on FirebaseAuthException catch (e) {
      if(e.code=='weak password'){
        print('The password provided is too weak');
      }
      else if(e.code=='email already in-use'){
        print('The account for that email already exists');
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
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
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
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: height/(6.69)),
                Column(
                  children: [
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
                ), //inputs
                SizedBox(height: height/2.4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EnterButton(text: 'Login',
                        function: () {
                          _logInWithEmailAndPassword();
                        },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New here?',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                         ),
                        ),
                        const SizedBox(width: 1),
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Signup',
                              style:  GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppStyle.appBlue,
                              ),
                            ),
                        )
                      ],
                    ),
                  ],
                ), //login button
              ],
            ),
          ),       //main-body
        ),
      ),
    );
  }
}
