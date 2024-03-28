import 'package:firebase_auth/firebase_auth.dart';
abstract interface class AuthRepository {


  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithEmailAndPassword(String email, String password);
}
