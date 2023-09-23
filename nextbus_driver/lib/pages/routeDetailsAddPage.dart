import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/button.dart';
import 'package:nextbus_driver/components/textFieldDataAdd.dart';
import 'package:nextbus_driver/methods/sizes.dart';

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
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: getPageWidth(context),
                  height: 480,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white, //  border color
                      width: 2.0, //  the border width
                    ),
                    borderRadius: BorderRadius.circular(20), // border radius
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey, // shadow color
                        offset: Offset(0, 3), // shadow's offset
                        blurRadius: 5, // blur radius
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Select Route Number : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('*',
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        DataAddTextField(
                          hintText: 'ex: 002 / 17',
                          prefixIcon: Icon(
                            Icons.location_on_rounded,
                            color: AppColor.iconColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Enter Bus Number : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('*',
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        DataAddTextField(
                          hintText: 'ex: NA - 2100',
                          prefixIcon: Icon(
                            Icons.directions_bus_filled_rounded,
                            color: AppColor.iconColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Number of Seats in Bus: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('*',
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        DataAddTextField(
                          hintText: 'ex: 54',
                          prefixIcon: Icon(
                            Icons.airline_seat_recline_normal_outlined,
                            color: AppColor.iconColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: MyButton(
                                onTap: () {}, childText: 'Next', width: 180))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
