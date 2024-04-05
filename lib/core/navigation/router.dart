import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tjnotes/features/note_managment/presentation/pages/edit_note_page.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/note_managment/presentation/pages/notes_page.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final user = ref.read(authNotifierProvider);
  String initalLocation = SIGN_UP_PAGE_PATH;
  if (user.hasValue && user.value != null) initalLocation = NOTES_PAGE_PATH;
  return GoRouter(
    initialLocation: initalLocation,
    routes: [
      GoRoute(
        path: SIGN_UP_PAGE_PATH,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: SIGN_IN_PAGE_PATH,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: NOTES_PAGE_PATH,
        builder: (context, state) => const NotesPage(),
      ),
      GoRoute(
        path: '$EDIT_NOTE_PAGE_PATH/:note_uuid',
        builder: (context, state) => EditNotePage(
          note_uuid: state.pathParameters['note_uuid'],
        ),
      ),
      GoRoute(
          path: '$EDIT_NOTE_PAGE_PATH',
          builder: (context, state) => const EditNotePage()),
    ],
  );
}

const SIGN_UP_PAGE_PATH = "/sign_up";
const SIGN_IN_PAGE_PATH = "/sign_in";
const NOTES_PAGE_PATH = "/notes";
const EDIT_NOTE_PAGE_PATH = "/edit_note";
