import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/navBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String get userName => "Suren Perera";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
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

            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Welcome...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),

                ),
              ],
            ),

             Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),),
                ),
              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar: NavBarHome(),
    );
  }
}
