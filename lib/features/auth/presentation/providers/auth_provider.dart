import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/user_sign_in.dart';
import '../../domain/usecases/user_sign_up.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late UserSignUp _userSignUp;
  late UserSignIn _userSignIn;

  @override
  Future<User?> build() async {
    _userSignUp = ref.read(userSignUpProvider);
    _userSignIn = ref.read(userSignInProvider);
    final currentUser = ref.read(firebaseAuthProvider).currentUser;
    return currentUser;
  }

  onSignInButtonClick(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _userSignIn.call(email, password) );
  }

  onSignUpButtonClick(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _userSignUp.call(email, password) );
  }


}
