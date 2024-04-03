import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String driverName = '';
String driverEmail = '';
String driverPhone = '';
String googleMapKey="AIzaSyBsxELn_PL513ny9ZMo8AORfg0tf-m2aKk";


const CameraPosition googleGooglePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

StreamSubscription<Position>? positionStreamHomePage;

StreamSubscription<Position>? positionStreamNewTripPage;

int driverTripRequestTimeout = 20;

// final audioPlayer = AssetsAudioPlayer();

Position? driverCurrentPosition;