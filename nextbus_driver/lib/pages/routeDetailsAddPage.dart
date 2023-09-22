import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';

class RouteDetailsAdd extends StatefulWidget {
  const RouteDetailsAdd({Key? key}) : super(key: key);

  @override
  State<RouteDetailsAdd> createState() => _RouteDetailsAddState();
}

class _RouteDetailsAddState extends State<RouteDetailsAdd> {
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
          ],

        ),
      ),
    );
  }
}
