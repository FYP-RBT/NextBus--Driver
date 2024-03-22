import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'homePage.dart';
import 'landingPage.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      // After the delay, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirebaseAuth.instance.currentUser == null ? LandingPage() :HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.background,
      body:
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(
              height: 200,
            ),

            Image.asset('images/fullLogo.png',
              height: 300,
              width: 300,),

            const SizedBox(
              height: 50,
            ),

            Image.asset('images/busGif.gif',
              height: 200,
              width: 200,),
          ],
        ),
      ),
    );
  }
}
