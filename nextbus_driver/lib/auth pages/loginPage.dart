import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/pages/homePage.dart';

import '../colors.dart';
import '../components/button.dart';
import '../components/textField.dart';
import '../methods/sizes.dart';
import '../pages/startJourneyPage.dart';
import 'createAccount.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required void Function() onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );


    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailOrPhoneController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {

      Navigator.pop(context);
      // incorrect EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // incorrect PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // incorrect email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // incorrect password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: 230,
                  height: 130,
                  child: Image.asset(
                    'images/VerLogoBlue 1.png',
                  )),
              SizedBox(
                width: 250,
                child: Image.asset('images/loginImg.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: emailOrPhoneController,
                hintText: 'Email or Phone Number',
                obscureText: false,
                suffixIcon: Icon(
                  Icons.person_outline_rounded,
                  color: AppColor.iconColor,
                ),
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter Your Password',
                obscureText: true,
                suffixIcon: Icon(
                  Icons.password_outlined,
                  color: AppColor.iconColor,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, bottom: 15),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  )
                ],
              ),
              MyButton(
                  onTap: signUserIn,
                  childText: 'Log In',
                  width: 180),
              const SizedBox(
                height: 15,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Image.asset('images/Or.png')),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(2),
                    child: Image.asset(
                      'images/google.png',
                      height: 40,
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Facebook button
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(2),
                    child: Image.asset(
                      'images/facebook.png',
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: getPageWidth(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount(onTap: () {  },)),
                          );
                        },
                        child: const Text(
                          'Create an Account',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
