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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAEnZn_GVskSnq_ThcFkXNWbdk8kJ8ISY0',
    appId: '1:507661018958:web:ddcb38b4dbb943c356201f',
    messagingSenderId: '507661018958',
    projectId: 'kalena-mart-8fbf0',
    authDomain: 'kalena-mart-8fbf0.firebaseapp.com',
    storageBucket: 'kalena-mart-8fbf0.appspot.com',
    measurementId: 'G-DNH8TY4CD8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6wkz1qWJGRiNwLgbwigll_4c_tZUjUAs',
    appId: '1:507661018958:android:87840b509f3bf32056201f',
    messagingSenderId: '507661018958',
    projectId: 'kalena-mart-8fbf0',
    storageBucket: 'kalena-mart-8fbf0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAMDWTlLs-cN-TdTZByrw5QnW9B-vQipw',
    appId: '1:507661018958:ios:67bb6e4194b8bf8e56201f',
    messagingSenderId: '507661018958',
    projectId: 'kalena-mart-8fbf0',
    storageBucket: 'kalena-mart-8fbf0.appspot.com',
    iosBundleId: 'com.example.kalenaMart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAMDWTlLs-cN-TdTZByrw5QnW9B-vQipw',
    appId: '1:507661018958:ios:67bb6e4194b8bf8e56201f',
    messagingSenderId: '507661018958',
    projectId: 'kalena-mart-8fbf0',
    storageBucket: 'kalena-mart-8fbf0.appspot.com',
    iosBundleId: 'com.example.kalenaMart',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAEnZn_GVskSnq_ThcFkXNWbdk8kJ8ISY0',
    appId: '1:507661018958:web:ee752c2242ba176656201f',
    messagingSenderId: '507661018958',
    projectId: 'kalena-mart-8fbf0',
    authDomain: 'kalena-mart-8fbf0.firebaseapp.com',
    storageBucket: 'kalena-mart-8fbf0.appspot.com',
    measurementId: 'G-X106QEVBPZ',
  );
}
