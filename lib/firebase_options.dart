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
    apiKey: 'AIzaSyAi8ENDnFgesjkWmlu8SOrk36wwQcb-09k',
    appId: '1:645366766918:web:72c821cbe553b91f46d947',
    messagingSenderId: '645366766918',
    projectId: 'fir-sample-fed8c',
    authDomain: 'fir-sample-fed8c.firebaseapp.com',
    storageBucket: 'fir-sample-fed8c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-MNpYGObONOR1LlqlTYro3XH-wBRSGnc',
    appId: '1:645366766918:android:2b39aad97c6c36ff46d947',
    messagingSenderId: '645366766918',
    projectId: 'fir-sample-fed8c',
    storageBucket: 'fir-sample-fed8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2cBvjAlTzyLDdZOW0jeLTrIyEYTUPNwY',
    appId: '1:645366766918:ios:f67590dc7041503a46d947',
    messagingSenderId: '645366766918',
    projectId: 'fir-sample-fed8c',
    storageBucket: 'fir-sample-fed8c.appspot.com',
    iosClientId: '645366766918-l2rijmo0c1v3cs64nm9j0sc01bv4urgk.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatFirebaseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2cBvjAlTzyLDdZOW0jeLTrIyEYTUPNwY',
    appId: '1:645366766918:ios:f67590dc7041503a46d947',
    messagingSenderId: '645366766918',
    projectId: 'fir-sample-fed8c',
    storageBucket: 'fir-sample-fed8c.appspot.com',
    iosClientId: '645366766918-l2rijmo0c1v3cs64nm9j0sc01bv4urgk.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatFirebaseApp',
  );
}
