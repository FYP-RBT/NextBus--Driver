// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBd58hNorXyEnVtXtkrjJ8lar7qYfnVolY',
    appId: '1:899877287712:web:ff45182bcfd399f57b8945',
    messagingSenderId: '899877287712',
    projectId: 'nextbus-driver',
    authDomain: 'nextbus-driver.firebaseapp.com',
    storageBucket: 'nextbus-driver.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBV2BLg_WHthaa_UIbLn6cVZCjLmCYA40A',
    appId: '1:899877287712:android:e4dcf588e23f13227b8945',
    messagingSenderId: '899877287712',
    projectId: 'nextbus-driver',
    storageBucket: 'nextbus-driver.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-pVERyxVtRU2ipSY8MxUQ8-RfuonAMu0',
    appId: '1:899877287712:ios:bf8dd0467724d2777b8945',
    messagingSenderId: '899877287712',
    projectId: 'nextbus-driver',
    storageBucket: 'nextbus-driver.appspot.com',
    iosBundleId: 'com.example.nextbusDriver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-pVERyxVtRU2ipSY8MxUQ8-RfuonAMu0',
    appId: '1:899877287712:ios:0eb08a7d9acb69a27b8945',
    messagingSenderId: '899877287712',
    projectId: 'nextbus-driver',
    storageBucket: 'nextbus-driver.appspot.com',
    iosBundleId: 'com.example.nextbusDriver.RunnerTests',
  );
}
