import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/comman_var.dart';
import 'package:nextbus_driver/components/navBarProfile.dart';
import 'package:nextbus_driver/methods/sizes.dart';
import '../components/button.dart';
import '../components/navBarHome.dart';
import 'landingPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Navigate back when the back button is pressed
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ), // Add the "Profile" title

            SizedBox(
              width: 120,
              height: 90,
              child: Image.asset('images/VerLogoBlue 1.png'), // Your logo image
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.person_3_rounded,
                      size: 40,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 80,
                    width: 3,
                    color: AppColor.lightBlueBack,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(driverName,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      Text(driverEmail,style: TextStyle(fontSize: 16,),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          MyButton(onTap: (){
            FirebaseAuth.instance.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          }, childText: 'Logout', width: 200)
        ],
      ),
      bottomNavigationBar: const NavBarProfile(),
    );
  }
}
