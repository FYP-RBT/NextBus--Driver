import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/colors.dart';
import 'package:nextbus_driver/components/navBarHome.dart';
import 'package:nextbus_driver/pages/routeDetailsAddPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../comman_var.dart';
import '../methods/commonMethods.dart';
import '../methods/sizes.dart';
import 'landingPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState() {
    super.initState();
    getUserInfoAndCheckBlockStatus();
  }

  getUserInfoAndCheckBlockStatus() async{
    DatabaseReference userRef = FirebaseDatabase.instance.ref()
        .child('drivers')
        .child(FirebaseAuth.instance.currentUser!.uid);

    await userRef.once().then((snap){
      if(snap.snapshot.value!=null){
        if((snap.snapshot.value as Map)['blockStatus']=='no'){
          setState(() {
            driverName = (snap.snapshot.value as Map)['name'];
            driverEmail = (snap.snapshot.value as Map)['email'];
          });

        }
        else{
          snackBar(context, 'You are blocked, Contact admin!',
              Colors.redAccent);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );

          FirebaseAuth.instance.signOut();

        }

      }
      else{
        FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      }
    });
  }



  // Function to handle logout
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.homeBox, // Make the app bar transparent
        elevation: 0, // Remove the app bar shadow
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: signUserOut, // Call the signUserOut method when the button is pressed
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: getPageWidth(context),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: AppColor.homeBox,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'images/fullLogo.png',
                      width: 250,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 5),
                  child: Text(driverName,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RouteDetailsAdd(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'images/startTrip.png',
                      width: 150,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => StartJourney()), // Replace SecondPage with the actual name of your second page class
                      // );
                    },
                    child: Image.asset(
                      'images/activities.png',
                      width: 150,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBarHome(),
    );
  }
}
