import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> initialize() async {
    if (identical(0, 0.0)) { // kIsWeb não está importado, então uso workaround
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyB3FYrA1nKu7ytvRRq7BRhwBVLYPIvLXZg',
          appId: '1:1051714663308:ios:65108fcda0ce5bf8b51ca9',
          messagingSenderId: '1051714663308',
          projectId: 'horoscope-6225b',
          storageBucket: 'horoscope-6225b.firebasestorage.app',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  }

  static Future<UserCredential> signInWithEmail(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<UserCredential> registerWithEmail(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> saveUserHoroscopeData({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance.collection('horoscopos').doc(uid).set(data, SetOptions(merge: true));
  }
}