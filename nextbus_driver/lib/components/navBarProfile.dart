import 'package:flutter/material.dart';
import 'package:nextbus_driver/pages/profilePage.dart';
import '../colors.dart';
import '../pages/homePage.dart';
import 'navBarHome.dart';

class NavBarProfile extends StatefulWidget {
  const NavBarProfile({super.key});

  @override
  State<NavBarProfile> createState() => _NavBarProfileState();
}

class _NavBarProfileState extends State<NavBarProfile> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                backgroundColor: AppColor.iconColor,
                elevation: 0.1,
                onPressed: () {},
                child: const Icon(Icons.location_on)),
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color:  Colors.grey.shade400,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()),
                    );

                  },
                  splashColor: Colors.white,
                ),

                Container(
                  width: size.width * 0.20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.person_2_rounded,
                      color: AppColor.iconColor
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()),
                      );

                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}