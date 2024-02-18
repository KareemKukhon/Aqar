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
    apiKey: 'AIzaSyCQZ5JCqlbphpd1T-Ir1R4EIDY7lCrAbFU',
    appId: '1:962199653806:web:668869beb3bd06b771cc3f',
    messagingSenderId: '962199653806',
    projectId: 'gp1-notification',
    authDomain: 'gp1-notification.firebaseapp.com',
    storageBucket: 'gp1-notification.appspot.com',
    measurementId: 'G-20YZKEHKZ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqEEQ9H8EewtfMu9bbRBLn2LnaaZQiK1k',
    appId: '1:962199653806:android:790d8f45b1c324dd71cc3f',
    messagingSenderId: '962199653806',
    projectId: 'gp1-notification',
    storageBucket: 'gp1-notification.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVuCAslqKzOrhcIp5QS3oGu182G3oLAeE',
    appId: '1:962199653806:ios:037f1d58b2df521471cc3f',
    messagingSenderId: '962199653806',
    projectId: 'gp1-notification',
    storageBucket: 'gp1-notification.appspot.com',
    iosBundleId: 'com.example.flutterAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVuCAslqKzOrhcIp5QS3oGu182G3oLAeE',
    appId: '1:962199653806:ios:037f1d58b2df521471cc3f',
    messagingSenderId: '962199653806',
    projectId: 'gp1-notification',
    storageBucket: 'gp1-notification.appspot.com',
    iosBundleId: 'com.example.flutterAuth',
  );
}