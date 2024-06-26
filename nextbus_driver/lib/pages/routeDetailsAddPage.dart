import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/button.dart';
import 'package:nextbus_driver/components/textFieldDataAdd.dart';
import 'package:nextbus_driver/methods/commonMethods.dart';
import 'package:nextbus_driver/methods/sizes.dart';
import 'package:nextbus_driver/pages/startLocation.dart';

import '../components/navBarHome.dart';

class RouteDetailsAdd extends StatefulWidget {
  const RouteDetailsAdd({Key? key}) : super(key: key);

  @override
  State<RouteDetailsAdd> createState() => _RouteDetailsAddState();
}

class _RouteDetailsAddState extends State<RouteDetailsAdd> {

  final routNumberController = TextEditingController();
  final busNumberController = TextEditingController();
  final seatsCountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), // Add a back button icon here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: SizedBox(
          width: 230,
          height: 130,
          child: Image.asset(
            'images/VerLogoBlue 1.png',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the app bar shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50), // Add vertical padding here
          child: Center(
            child: Column(
              children: [
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
                            controller: routNumberController,
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
                            controller: busNumberController,
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
                            controller: seatsCountController,
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
                                  onTap: () {
                                    // Simple validation to check if the text fields are not empty
                                    if (routNumberController.text.isEmpty || busNumberController.text.isEmpty || seatsCountController.text.isEmpty) {
                                      snackBar(context, 'Please fill all the fields', Colors.redAccent);
                                    } else {
                                      // Navigate to StartLocationPage if all fields are valid
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => StartLocationPage(
                                          routNumber: routNumberController.text,
                                          busNumber: busNumberController.text,
                                          seatsCount: seatsCountController.text,
                                        )),
                                      );
                                    }
                                  },
                                  childText: 'Start', width: 180))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBarHome(),
    );
  }
}
