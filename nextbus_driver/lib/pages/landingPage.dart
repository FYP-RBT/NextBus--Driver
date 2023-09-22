import 'package:flutter/material.dart';

import '../auth pages/createAccount.dart';
import '../auth pages/loginPage.dart';
import '../colors.dart';
import '../components/button.dart';
import '../methods/sizes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 230,
              height: 130,
              child: Image.asset(
                'images/VerLogoBlue 1.png',
              )),
          SizedBox(
            height: 500, // Set a fixed height for the PageView
            child: PageView(
              children: [
                SizedBox(
                  height: 500,
                  child: Image.asset('images/bus1.png'),
                ),
                SizedBox(
                  height: 500,
                  child: Image.asset('images/bus2.png'),
                ),
                SizedBox(
                  height: 500,
                  child: Image.asset('images/bus3.png'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAccount()),
              );
            },
            childText: 'Create an Account',
            width: 280,
          ),
          const SizedBox(
            height: 10,
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
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );},
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
