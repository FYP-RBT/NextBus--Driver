import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';

class StartLocationPage extends StatefulWidget {
  const StartLocationPage({Key? key}) : super(key: key);

  @override
  State<StartLocationPage> createState() => _StartLocationPageState();
}

class _StartLocationPageState extends State<StartLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), // Add a back button icon here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 320,
                height: 550,
                color: Colors.amberAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
