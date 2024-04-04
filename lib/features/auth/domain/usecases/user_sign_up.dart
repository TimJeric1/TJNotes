import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

part 'user_sign_up.g.dart';

@riverpod
UserSignUp userSignUp(UserSignUpRef ref) {
  final authRepository = ref.read(authRepositoryImplProvider);
  return UserSignUp(authRepository);
}


class UserSignUp {
  AuthRepository _authRepository;

  UserSignUp(this._authRepository);

  Future<User?> call(String email, String password) async {
    return await _authRepository.signUpWithEmailAndPassword(email, password);
  }

}