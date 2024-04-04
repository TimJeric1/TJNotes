import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/navigation/router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.read(goRouterProvider);
    final appThemeLight = ref.read(appThemeProvider(Brightness.light));
    final appThemeDark = ref.read(appThemeProvider(Brightness.dark));

    final systemUiIconsBrightness =
    MediaQuery.platformBrightnessOf(context) == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    final appColorScheme = MediaQuery.platformBrightnessOf(context) == Brightness.light
        ? appThemeLight.colorScheme
        : appThemeDark.colorScheme;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: appColorScheme.surface,
        systemNavigationBarColor: appColorScheme.surface,
        systemNavigationBarIconBrightness: systemUiIconsBrightness,
        statusBarIconBrightness: systemUiIconsBrightness,
      ),
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Todo App',
      theme: appThemeLight,
      themeMode: ThemeMode.system,
      darkTheme: appThemeDark,
    );
  }
}
