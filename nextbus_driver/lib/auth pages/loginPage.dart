import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/pages/homePage.dart';

import '../colors.dart';
import '../comman_var.dart';
import '../components/button.dart';
import '../components/loading.dart';
import '../components/textField.dart';
import '../methods/commonMethods.dart';
import '../methods/sizes.dart';
import '../pages/startJourneyPage.dart';
import 'createAccount.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,} ) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);
    signInFormValidation();
  }

  signInFormValidation() {
    if (!emailOrPhoneController.text.contains('@')) {
      snackBar(context, 'Please enter a valid email', Colors.redAccent);
    } else if (passwordController.text.trim().length < 6) {
      snackBar(context, 'Your password must be 6 or more characters',
          Colors.redAccent);
    } else {
      signInUser();
      // Proceed with the sign-up process as all validations are passed
    }
  }

  signInUser()async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: 'Allowing you to login...'),
    );

    final User? userFirebase = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailOrPhoneController.text.trim(),
      password: passwordController.text.trim(),
    ).catchError((errorMsg){
      Navigator.pop(context);
      snackBar(context, 'Incorrect email or password!', Colors.red);
    })
    ).user;

    if(!context.mounted)return;
    Navigator.pop(context);

    if(userFirebase != null){
      DatabaseReference userRef = FirebaseDatabase.instance.ref().child('drivers').child(userFirebase.uid);
      userRef.once().then((snap){
        if(snap.snapshot.value!=null){
          if((snap.snapshot.value as Map)['blockStatus']=='no'){
            userName = (snap.snapshot.value as Map)['name'];
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );

          }
          else{
            snackBar(context, 'You are blocked, Contact admin!',
                Colors.redAccent);
            FirebaseAuth.instance.signOut();

          }

        }
        else{
          FirebaseAuth.instance.signOut();
          snackBar(context, 'Your record do not exist as driver..',
              Colors.redAccent);
        }
      });
    }
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
                  onTap: checkIfNetworkIsAvailable,
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
