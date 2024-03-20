import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/textField.dart';

import '../components/button.dart';
import '../components/loading.dart';
import '../methods/commonMethods.dart';
import '../methods/sizes.dart';
import '../pages/homePage.dart'; // Import the HomePage widget
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

  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);
    signUpFormValidation();
  }

  signUpFormValidation() {
    if (enterNameController.text.trim().length < 3) {
      snackBar(
          context, 'Your name must be 4 or more characters', Colors.redAccent);
    } else if (enterMobileNumberController.text.trim().length < 8) {
      snackBar(context, 'Your mobile number must be 8 or more characters',
          Colors.redAccent);
    } else if (!enterEmailController.text.contains('@')) {
      snackBar(context, 'Please enter a valid email', Colors.redAccent);
    } else if (enterPasswordController.text.trim().length < 6) {
      snackBar(context, 'Your password must be 6 or more characters',
          Colors.redAccent);
    } else if (enterPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      snackBar(context, 'Passwords do not match', Colors.redAccent);
    } else {
      registerNewDriver();
      // Proceed with the sign-up process as all validations are passed
    }
  }

  registerNewDriver() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: 'Registering your account...'),
    );

    final User? userFirebase = (await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: enterEmailController.text.trim(),
      password: enterPasswordController.text.trim(),
    ).catchError((errorMsg){
      Navigator.pop(context);
      snackBar(context, errorMsg.toString(), Colors.red);
    })
    ).user;

    if(!context.mounted)return;
    Navigator.pop(context);

    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('drivers').child(userFirebase!.uid);
    Map driverDataMap =
    {
      "name": enterNameController.text.trim(),
      "email": enterEmailController.text.trim(),
      "phone": enterMobileNumberController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    userRef.set(driverDataMap);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage()),
    );

    snackBar(context, 'Account created, you can Login now!', Colors.green.shade500);


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

              MyButton(onTap: checkIfNetworkIsAvailable, childText: 'Sign Up', width: 180),

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
                  // Google button
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
