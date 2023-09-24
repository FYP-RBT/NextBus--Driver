import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/navBarProfile.dart';
import 'package:nextbus_driver/methods/sizes.dart';
import '../components/navBarHome.dart';

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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Add spacing between AppBar and profile picture
              // Circular Avatar for Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/profile_picture.png'),
                ),
              ),
              SizedBox(height: 20), // Add spacing between profile picture and content
              // Add your profile content here
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: getPageWidth(context),
              height: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // shadow color
                    offset: Offset(0, 3), // shadow's offset
                    blurRadius: 5, // blur radius
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Add content for the container here
                    // For example, additional user details or actions
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBarProfile(),
    );
  }
}
