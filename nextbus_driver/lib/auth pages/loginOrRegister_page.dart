// import 'package:flutter/material.dart';
// import 'package:nextbus_driver/auth%20pages/createAccount.dart';
// import 'package:nextbus_driver/auth%20pages/loginPage.dart';
//
// class LoginOrRegister extends StatefulWidget {
//   const LoginOrRegister({Key? key}) : super(key: key);
//
//   @override
//   State<LoginOrRegister> createState() => _LoginOrRegisterState();
// }
//
// class _LoginOrRegisterState extends State<LoginOrRegister> {
//   bool showLoginPage = true;
//
//   void togglePages() {
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage) {
//       return LoginPage(
//         onTap: togglePages,
//       );
//     } else {
//       return CreateAccount(
//         onTap: togglePages,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import '../pages/homePage.dart';
import 'createAccount.dart'; // Import the CreateAccount widget
import 'loginPage.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Depending on the value of showLoginPage, either display LoginPage or CreateAccount
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      // Handle navigation to the HomePage after successful sign-up
      return CreateAccount(
        onTap: () {
          togglePages(); // Close the CreateAccount screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      );
    }
  }
}
