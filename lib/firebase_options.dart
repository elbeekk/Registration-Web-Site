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
    apiKey: 'AIzaSyAPNdelhgN25fC_9rdE5eMOLINs4V0EmP4',
    appId: '1:24978308222:web:8c65d967735f13589b6c2f',
    messagingSenderId: '24978308222',
    projectId: 'bright-future-9effd',
    authDomain: 'bright-future-9effd.firebaseapp.com',
    storageBucket: 'bright-future-9effd.appspot.com',
    measurementId: 'G-02MQZSS4VQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlQXxaxYq_tvU-J84JpySZdtZTTd4WsAA',
    appId: '1:24978308222:android:73832458584f748f9b6c2f',
    messagingSenderId: '24978308222',
    projectId: 'bright-future-9effd',
    storageBucket: 'bright-future-9effd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAazm5V687cnVOYhcBHm3AxpG23n3HtYzM',
    appId: '1:24978308222:ios:6abc8da8b382e4e09b6c2f',
    messagingSenderId: '24978308222',
    projectId: 'bright-future-9effd',
    storageBucket: 'bright-future-9effd.appspot.com',
    iosBundleId: 'reg.page.regWebPage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAazm5V687cnVOYhcBHm3AxpG23n3HtYzM',
    appId: '1:24978308222:ios:362a170eb7bbd4729b6c2f',
    messagingSenderId: '24978308222',
    projectId: 'bright-future-9effd',
    storageBucket: 'bright-future-9effd.appspot.com',
    iosBundleId: 'reg.page.regWebPage.RunnerTests',
  );
}
