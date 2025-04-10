import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD8K48DLVpilH5RGdFGEJuF_hD49EOQVSE',
    appId: '1:858884928597:web:7a3c1e35f6cf28936990dc',
    messagingSenderId: '858884928597',
    projectId: 'zhidodotest',
    authDomain: 'zhidodotest.firebaseapp.com',
    storageBucket: 'zhidodotest.appspot.com',
    measurementId: 'G-4SVE1BQMH4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvrCoyJthNSH2wkgyh9wHof443SR5BSTg',
    appId: '1:131377555436:android:f7b5c924a0777343fb42c9',
    messagingSenderId: '131377555436',
    projectId: 'test-fd132',
    storageBucket: 'test-fd132.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9YHdtu9CiirYvSFsbBO2CuZQszm3BNS0',
    appId: '1:858884928597:ios:5b1c81eb6c67b3ea6990dc',
    messagingSenderId: '858884928597',
    projectId: 'zhidodotest',
    storageBucket: 'zhidodotest.firebasestorage.app',
    iosBundleId: 'com.example.zhiDuoDuo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD8K48DLVpilH5RGdFGEJuF_hD49EOQVSE',
    appId: '1:858884928597:web:231dca7f918d95aa6990dc',
    messagingSenderId: '858884928597',
    projectId: 'zhidodotest',
    authDomain: 'zhidodotest.firebaseapp.com',
    storageBucket: 'zhidodotest.firebasestorage.app',
    measurementId: 'G-5CMRFQCQ10',
  );
}
