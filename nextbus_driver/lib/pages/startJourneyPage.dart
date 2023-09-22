import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/button.dart';

class StartJourney extends StatefulWidget {
  const StartJourney({Key? key}) : super(key: key);

  @override
  State<StartJourney> createState() => _StartJourneyState();
}

class _StartJourneyState extends State<StartJourney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Center(
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
              const SizedBox(
                height: 80,
              ),
              const Text('Start Journey!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(
                height: 15,
              ),
              const Text('Stay Connected in Real Time: ',
                style: TextStyle(
                    fontSize: 14,
                ),),
              const Text('Track Your Journey Live! ',
                style: TextStyle(
                  fontSize: 14,
                ),),
              const SizedBox(
                height: 100,
              ),
              MyButton(onTap: () {}, childText: 'Start', width: 200),
              const SizedBox(
                height: 200,
              ),



            ],

          ),
        ),
      ),
    );
  }
}
