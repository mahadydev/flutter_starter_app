// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdsMW183Qh4mef9klhGrWnOYBCHIUV2As',
    appId: '1:364143433660:android:aafc3e3147c231adb6bdb9',
    messagingSenderId: '364143433660',
    projectId: 'my-starter-app-flutter',
    storageBucket: 'my-starter-app-flutter.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpIbPeYEMSo40-PZGoUV4-j4h1c9gzjiI',
    appId: '1:364143433660:ios:1281b87e20bdf134b6bdb9',
    messagingSenderId: '364143433660',
    projectId: 'my-starter-app-flutter',
    storageBucket: 'my-starter-app-flutter.firebasestorage.app',
    iosBundleId: 'com.example.flutterStarterApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAJn4J2KOTqtn2MFifZyy1NS1O3o8GrLBA',
    appId: '1:364143433660:web:9ea1fd58b241a061b6bdb9',
    messagingSenderId: '364143433660',
    projectId: 'my-starter-app-flutter',
    authDomain: 'my-starter-app-flutter.firebaseapp.com',
    storageBucket: 'my-starter-app-flutter.firebasestorage.app',
    measurementId: 'G-ZQBB92ZK7L',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpIbPeYEMSo40-PZGoUV4-j4h1c9gzjiI',
    appId: '1:364143433660:ios:1281b87e20bdf134b6bdb9',
    messagingSenderId: '364143433660',
    projectId: 'my-starter-app-flutter',
    storageBucket: 'my-starter-app-flutter.firebasestorage.app',
    iosBundleId: 'com.example.flutterStarterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAJn4J2KOTqtn2MFifZyy1NS1O3o8GrLBA',
    appId: '1:364143433660:web:4875ea95165b2dddb6bdb9',
    messagingSenderId: '364143433660',
    projectId: 'my-starter-app-flutter',
    authDomain: 'my-starter-app-flutter.firebaseapp.com',
    storageBucket: 'my-starter-app-flutter.firebasestorage.app',
    measurementId: 'G-TWS7R4G8PW',
  );

}