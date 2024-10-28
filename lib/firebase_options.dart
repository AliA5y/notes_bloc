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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyB4fC1Y1lNzM7YcZ-tpp4i0WrumjWpQ5Bo',
    appId: '1:668231243255:android:b0d643c9a7e16fbe404af2',
    messagingSenderId: '668231243255',
    projectId: 'notes-bloc-20386',
    storageBucket: 'notes-bloc-20386.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNJTsPWu4gYbpT2xEt1KSz61SQrdKwQiY',
    appId: '1:668231243255:ios:134054a0b7390e15404af2',
    messagingSenderId: '668231243255',
    projectId: 'notes-bloc-20386',
    storageBucket: 'notes-bloc-20386.appspot.com',
    iosBundleId: 'com.example.notesBloc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCNJTsPWu4gYbpT2xEt1KSz61SQrdKwQiY',
    appId: '1:668231243255:ios:134054a0b7390e15404af2',
    messagingSenderId: '668231243255',
    projectId: 'notes-bloc-20386',
    storageBucket: 'notes-bloc-20386.appspot.com',
    iosBundleId: 'com.example.notesBloc',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAN_ivQedNz222jxUwK_H65is5qf9gxg-0',
    appId: '1:668231243255:web:b1fc62dd23fefa26404af2',
    messagingSenderId: '668231243255',
    projectId: 'notes-bloc-20386',
    authDomain: 'notes-bloc-20386.firebaseapp.com',
    storageBucket: 'notes-bloc-20386.appspot.com',
    measurementId: 'G-9620PBYNJH',
  );
}