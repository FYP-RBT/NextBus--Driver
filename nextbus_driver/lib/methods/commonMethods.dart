import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';

import '../comman_var.dart';

class CommonMethods{
  checkConnectivity(BuildContext context)async{
    var connectionResult = await Connectivity().checkConnectivity();

    if (connectionResult != ConnectivityResult.mobile && connectionResult != ConnectivityResult.wifi)
      {
        if(!context.mounted) return;
        snackBar(context, 'Internet is not Available, Try Again', Colors.cyan);

      }

  }


  turnOffLocationUpdatesForHomePage()
  {
    positionStreamHomePage!.pause();

    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);
  }

  turnOnLocationUpdatesForHomePage()
  {
    positionStreamHomePage!.resume();

    Geofire.setLocation(
      FirebaseAuth.instance.currentUser!.uid,
      driverCurrentPosition!.latitude,
      driverCurrentPosition!.longitude,
    );
  }




}

Future<void> snackBar(BuildContext context, String message, Color color) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: color, fontSize: 17.0),
    ),
  ));
}