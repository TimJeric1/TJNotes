import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/features/auth/domain/repositories/auth_repository.dart';


part 'auth_repository_impl.g.dart';

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref){
  return FirebaseAuth.instance;
}

@riverpod
AuthRepositoryImpl authRepositoryImpl(AuthRepositoryImplRef ref){
  final firebaseAuth = ref.read(firebaseAuthProvider);
  return AuthRepositoryImpl(firebaseAuth);
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }
}
