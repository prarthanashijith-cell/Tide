import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCZIIeL-IXDqMJbKVKV9Vv0e05Vorl9Deg',
    authDomain: 'tide-596e4.firebaseapp.com',
    projectId: 'tide-596e4',
    storageBucket: 'tide-596e4.firebasestorage.app',
    messagingSenderId: '86940034790',
    appId: '1:86940034790:web:f043776528e514f2f9fd27',
    measurementId: 'G-ZH3VDPGKRR',
  );
}
