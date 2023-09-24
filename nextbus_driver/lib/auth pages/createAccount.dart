import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/textField.dart';

import '../components/button.dart';
import '../methods/sizes.dart';
import 'loginPage.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key, required void Function() onTap})
      : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final enterNameController = TextEditingController();
  final enterEmailController = TextEditingController();
  final enterMobileNumberController = TextEditingController();
  final enterPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
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
      if (enterPasswordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: enterEmailController.text,
          password: enterPasswordController.text,
        );
      } else {
        wrongPasswordMessage();
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'email-already-in-use') {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Email Already in Use', style: TextStyle(color: Colors.red),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (e.code == 'user-not-found') {
        // Show an error message to the user for other cases
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
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
                height: 20,
              ),
              SizedBox(
                  width: 230,
                  height: 130,
                  child: Image.asset(
                    'images/VerLogoBlue 1.png',
                  )),
              MyTextField(
                controller: enterNameController,
                hintText: 'Enter Your Name',
                obscureText: false,
                suffixIcon: Icon(
                  Icons.person_outline_rounded,
                  color: AppColor.iconColor,
                ),
              ),
              MyTextField(
                controller: enterEmailController,
                hintText: 'Enter Your Email',
                obscureText: false,
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColor.iconColor,
                ),
              ),
              MyTextField(
                controller: enterMobileNumberController,
                hintText: 'Enter Your Mobile Number',
                obscureText: false,
                suffixIcon: Icon(
                  Icons.phone_android_rounded,
                  color: AppColor.iconColor,
                ),
              ),
              MyTextField(
                controller: enterPasswordController,
                hintText: 'Enter Your Password',
                obscureText: true,
                suffixIcon: Icon(
                  Icons.password_outlined,
                  color: AppColor.iconColor,
                ),
              ),
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Your Password',
                obscureText: true,
                suffixIcon: Icon(
                  Icons.password_outlined,
                  color: AppColor.iconColor,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              MyButton(onTap: signUserUp, childText: 'Sign Up', width: 180),

              const SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Image.asset('images/Or.png')),
              const SizedBox(
                height: 20,
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

                  //facebook button
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
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(
                                  onTap: () {},
                                )),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
