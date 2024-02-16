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
    apiKey: 'AIzaSyBN_Z3RwoFo0OMFNXgZxarVHsRNW7xx1hk',
    appId: '1:739952823804:web:35c3b8e79c1003feb43679',
    messagingSenderId: '739952823804',
    projectId: 'flutter-chat-app-44a15',
    authDomain: 'flutter-chat-app-44a15.firebaseapp.com',
    storageBucket: 'flutter-chat-app-44a15.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiBluw4FBI_LsParC0RVF_-qtTW9UGbJ4',
    appId: '1:739952823804:android:fca54783a076ccbfb43679',
    messagingSenderId: '739952823804',
    projectId: 'flutter-chat-app-44a15',
    storageBucket: 'flutter-chat-app-44a15.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEaPiOWCSeUcvxgpS1eDM7BHLZI3NGdIM',
    appId: '1:739952823804:ios:fe5b3081ad60c9bbb43679',
    messagingSenderId: '739952823804',
    projectId: 'flutter-chat-app-44a15',
    storageBucket: 'flutter-chat-app-44a15.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEaPiOWCSeUcvxgpS1eDM7BHLZI3NGdIM',
    appId: '1:739952823804:ios:429564a93cb8c609b43679',
    messagingSenderId: '739952823804',
    projectId: 'flutter-chat-app-44a15',
    storageBucket: 'flutter-chat-app-44a15.appspot.com',
    iosBundleId: 'com.example.chatapp.RunnerTests',
  );
}