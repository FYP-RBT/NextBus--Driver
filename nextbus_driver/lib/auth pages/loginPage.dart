import 'package:flutter/material.dart';

import '../colors.dart';
import '../components/button.dart';
import '../components/textField.dart';
import '../pages/startJourneyPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

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
              SizedBox(
                width: 250,
                child: Image.asset('images/loginImg.png'),
              ),
              const SizedBox(
                height: 20,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartJourney()),
                    );
                  },
                  childText: 'Log In',
                  width: 180),
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
            ],
          ),
        ),
      ),
    );
  }
}
