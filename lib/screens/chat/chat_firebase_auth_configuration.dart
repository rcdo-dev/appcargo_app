import 'package:firebase_auth/firebase_auth.dart';

class ChatFirebaseAuthConfiguration {
  Future<void> handleFirebaseAuth() async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}