// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<String?> loginFirebase() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print('userId: ${userCredential.user?.uid}');
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
}
