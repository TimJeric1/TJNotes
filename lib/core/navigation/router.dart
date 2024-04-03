import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/features/auth/presentation/pages/sign_in_page.dart';
import 'package:todoapp/features/auth/presentation/pages/sign_up_page.dart';
import 'package:todoapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:todoapp/features/note_managment/presentation/pages/samplePage.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final user = ref.read(authNotifierProvider);
  String initalLocation = SIGN_UP_PATH;
  if(user.hasValue && user.value != null) initalLocation = '$SAMPLE_PATH/${user.value!.email}';
  return GoRouter(
    initialLocation: initalLocation,
    routes: [
      GoRoute(
        path: SIGN_UP_PATH,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: SIGN_IN_PATH,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '$SAMPLE_PATH/:string',
        builder: (context, state) =>
            SamplePage(extraString: state.pathParameters['string']!),
      ),
    ],
  );
}

const SIGN_UP_PATH = "/sign_up";
const SIGN_IN_PATH = "/sign_in";
const SAMPLE_PATH = "/sample";
