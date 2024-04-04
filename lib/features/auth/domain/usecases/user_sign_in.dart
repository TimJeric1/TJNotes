import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

part 'user_sign_in.g.dart';

@riverpod
UserSignIn userSignIn(UserSignInRef ref) {
  final authRepository = ref.read(authRepositoryImplProvider);
  return UserSignIn(authRepository);
}


class UserSignIn {
  AuthRepository _authRepository;

  UserSignIn(this._authRepository);

  Future<User?> call(String email, String password) async {
    return await _authRepository.signInWithEmailAndPassword(email, password);
  }

}