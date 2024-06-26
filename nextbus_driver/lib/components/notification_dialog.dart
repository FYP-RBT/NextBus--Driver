import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nextbus_driver/methods/commonMethods.dart';

import '../comman_var.dart';
import '../models/trip_details.dart';
import '../pages/new_trip_page.dart';
import 'loading.dart';

class NotificationDialog extends StatefulWidget {
  TripDetails? tripDetailsInfo;

  NotificationDialog({
    super.key,
    this.tripDetailsInfo,
  });

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  String tripRequestStatus = "";
  CommonMethods cMethods = CommonMethods();
  String driversRouteNumber = "";

  cancelNotificationDialogAfter20Sec() {
    const oneTickPerSecond = Duration(seconds: 1);

    var timerCountDown = Timer.periodic(oneTickPerSecond, (timer) {
      driverTripRequestTimeout = driverTripRequestTimeout - 1;

      if (tripRequestStatus == "accepted") {
        timer.cancel();
        driverTripRequestTimeout = 20;
      }

      if (driverTripRequestTimeout == 0) {
        Navigator.pop(context);
        timer.cancel();
        driverTripRequestTimeout = 20;
        // audioPlayer.stop();
      }
    });
  }

  Future<void> getDriversRoute() async {
    DatabaseReference driverRef = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid);

    // Get the route number from Firebase
    DataSnapshot snapshot = await driverRef.child("routeNumber").get();
    if (snapshot.exists) {
      // Update the state if the value is fetched successfully
      setState(() {
        driversRouteNumber = snapshot.value.toString();
        print("Driver's Route Number: $driversRouteNumber");
        // Check if the route numbers match and take appropriate action
        if (driversRouteNumber == widget.tripDetailsInfo!.busRoute) {
          tripRequestStatus = "accepted";
          autoAcceptTrip();
        } else {
          tripRequestStatus = "declined";

          Timer(Duration(seconds: 3), () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        }
      });
    } else {
      print("Route number not found.");
      tripRequestStatus = "declined";
    }
  }

  void autoAcceptTrip() {
    // Set the trip request status to accepted before checking its availability
    setState(() {
      tripRequestStatus = "accepted";
    });
    checkAvailabilityOfTripRequest(context);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDriversRoute();
    cancelNotificationDialogAfter20Sec();
  }

  checkAvailabilityOfTripRequest(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => LoadingDialog(
        messageText: 'please wait...',
      ),
    );

    DatabaseReference driverTripStatusRef = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("newTripStatus");

    await driverTripStatusRef.once().then((snap) {
      Navigator.pop(context);
      Navigator.pop(context);

      String newTripStatusValue = "";
      if (snap.snapshot.value != null) {
        newTripStatusValue = snap.snapshot.value.toString();
      } else {
        snackBar(context, "Trip Request Not Found.", Colors.white);
      }

      if (newTripStatusValue == widget.tripDetailsInfo!.tripID) {
        driverTripStatusRef.set("accepted");

        //disable homepage location updates
        // cMethods.turnOffLocationUpdatesForHomePage();
        ///edited as we want for testing

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) =>
                    NewTripPage(newTripDetailsInfo: widget.tripDetailsInfo)));
      } else if (newTripStatusValue == "cancelled") {
        snackBar(
            context, "Trip Request has been Cancelled by user.", Colors.white);
      } else if (newTripStatusValue == "timeout") {
        snackBar(context, "Trip Request timed out.", Colors.white);
      } else {
        snackBar(context, "Trip Request removed. Not Found.", Colors.white);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30.0,
            ),

            Image.asset(
              "images/fullLogo.png",
              width: 140,
            ),

            const SizedBox(
              height: 16.0,
            ),

            //title
            Text(
              "NEW TRIP REQUEST - ${widget.tripDetailsInfo!.busRoute}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),

            const Divider(
              height: 1,
              color: Colors.white,
              thickness: 1,
            ),

            const SizedBox(
              height: 10.0,
            ),

            //pick - dropoff
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //pickup
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/initial.png",
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Text(
                          widget.tripDetailsInfo!.pickupAddress.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //dropoff
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/final.png",
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Text(
                          widget.tripDetailsInfo!.dropOffAddress.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            const Divider(
              height: 1,
              color: Colors.white,
              thickness: 1,
            ),

            const SizedBox(
              height: 8,
            ),

            //decline btn - accept btn
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                tripRequestStatus == "accepted" ? "Checked route and accepted" : "Checked route didn't match",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
