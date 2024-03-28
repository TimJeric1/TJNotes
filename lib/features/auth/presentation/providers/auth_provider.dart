import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/features/auth/domain/usecases/user_sign_in.dart';
import 'package:todoapp/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late UserSignUp _userSignUp;
  late UserSignIn _userSignIn;

  @override
  User? build() {
    _userSignUp = ref.read(userSignUpProvider);
    _userSignIn = ref.read(userSignInProvider);
    return null;
  }

  onSignInButtonClick(String email, String password) async{
    final user = await _userSignIn.call(email, password);
    state = user;
  }

  onSignUpButtonClick(String email, String password) async{
    final user = await _userSignUp.call(email, password);
    state = user;
  }


}
