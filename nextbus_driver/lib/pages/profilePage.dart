import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';

import '../components/navBar.dart';

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
      body: Center(
        child: Column(

        ),
      ),
      bottomNavigationBar: const NavBarHome(),
    );

  }
}
