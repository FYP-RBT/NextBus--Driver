import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nextbus_driver/colors.dart';

import '../comman_var.dart';
import '../models/map_theme_methods.dart';
import '../pushNotification/push_notification_system.dart';

class StartLocationPage extends StatefulWidget {
  final String routNumber;
  final String busNumber;
  final String seatsCount;
  const StartLocationPage({Key? key, required this.routNumber, required this.busNumber, required this.seatsCount}) : super(key: key);

  @override
  State<StartLocationPage> createState() => _StartLocationPageState();
}

class _StartLocationPageState extends State<StartLocationPage> {

  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;

  Position? currentPositionOfDriver;

  Color colorToShow = Colors.green;
  String titleToShow = "GO ONLINE NOW";
  bool isDriverAvailable = false;

  DatabaseReference? newTripRequestReference;

  MapThemeMethods themeMethods = MapThemeMethods();



  getCurrentLiveLocationOfDriver() async
  {
    Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfDriver=positionOfUser;
    driverCurrentPosition = currentPositionOfDriver;

    LatLng positionOfUserInLatLng=LatLng(currentPositionOfDriver!.latitude, currentPositionOfDriver!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: positionOfUserInLatLng,zoom: 15);

    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }


  goOnlineNow()
  {
    //all drivers who are Available for new trip requests
    Geofire.initialize("onlineDrivers");

    Geofire.setLocation(
      FirebaseAuth.instance.currentUser!.uid,
      currentPositionOfDriver!.latitude,
      currentPositionOfDriver!.longitude,
    );

    newTripRequestReference = FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid);

    newTripRequestReference!.child("newTripStatus").set("started");
    newTripRequestReference!.child("busNumber").set(widget.busNumber);
    newTripRequestReference!.child("routeNumber").set(widget.routNumber);
    newTripRequestReference!.child("seats").set(widget.seatsCount);


    newTripRequestReference!.onValue.listen((event) { });
  }


  setAndGetLocationUpdates()
  {
    positionStreamHomePage = Geolocator.getPositionStream()
        .listen((Position position)
    {
      currentPositionOfDriver = position;

      if(isDriverAvailable == true)
      {
        Geofire.setLocation(
          FirebaseAuth.instance.currentUser!.uid,
          currentPositionOfDriver!.latitude,
          currentPositionOfDriver!.longitude,
        );
      }

      LatLng positionLatLng = LatLng(position.latitude, position.longitude);
      controllerGoogleMap!.animateCamera(CameraUpdate.newLatLng(positionLatLng));
    });
  }


  goOfflineNow()
  {
    //stop sharing driver live location updates
    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);

    //stop listening to the newTripStatus
    newTripRequestReference!.child("newTripStatus").remove();
    newTripRequestReference!.child("busNumber").remove();
    newTripRequestReference!.child("routeNumber").remove();
    newTripRequestReference!.child("seats").remove();
  }

  initializePushNotificationSystem()
  {
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.startListeningForNewNotification(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePushNotificationSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text('Start Your Journey',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // Add a back button icon here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor:AppColor.textFieldBlue, // Make the app bar transparent
        elevation: 0,
      ),
      body: Stack(
        children: [

          GoogleMap(
            padding: EdgeInsets.only(top: 40),
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googleGooglePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController){
              controllerGoogleMap=mapController;
              themeMethods.updateMapTheme(controllerGoogleMap!);
              googleMapCompleterController.complete(controllerGoogleMap);
              getCurrentLiveLocationOfDriver();
            },
          ),

          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   color: Colors.black54,
          // ),

          ///go online offline button
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: ()
                    {
                      showModalBottomSheet(
                          context: context,
                          isDismissible: false,
                          builder: (BuildContext context)
                          {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.black87,
                                boxShadow:
                                [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(
                                      0.7,
                                      0.7,
                                    ),
                                  ),
                                ],
                              ),
                              height: 221,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                                child: Column(
                                  children: [

                                    const SizedBox(height:  11,),

                                    Text(
                                      (!isDriverAvailable) ? "GO ONLINE NOW" : "GO OFFLINE NOW",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 21,),

                                    Text(
                                      (!isDriverAvailable)
                                          ? "You are about to go online, you will become available to share live location for passengers."
                                          : "You are about to go offline, you will stop share live location to for passengers.",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),

                                    const SizedBox(height: 25,),

                                    Row(
                                      children: [

                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: ()
                                            {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                                "BACK"
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 16,),

                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: ()
                                            {
                                              if(!isDriverAvailable)
                                              {
                                                ///go online
                                                goOnlineNow();

                                                ///get driver location updates
                                                setAndGetLocationUpdates();

                                                Navigator.pop(context);

                                                setState(() {
                                                  colorToShow = Colors.pink;
                                                  titleToShow = "GO OFFLINE NOW";
                                                  isDriverAvailable = true;
                                                });
                                              }
                                              else
                                              {
                                                //go offline
                                                goOfflineNow();

                                                Navigator.pop(context);

                                                setState(() {
                                                  colorToShow = Colors.green;
                                                  titleToShow = "GO ONLINE NOW";
                                                  isDriverAvailable = false;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: (titleToShow == "GO ONLINE NOW")
                                                  ? Colors.green
                                                  : Colors.pink,
                                            ),
                                            child: const Text(
                                                "CONFIRM"
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorToShow,
                      foregroundColor: Colors.white
                    ),
                    child: Text(
                      titleToShow,
                    ),
                  ),

                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}
