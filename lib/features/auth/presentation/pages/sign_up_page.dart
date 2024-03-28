import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todoapp/features/auth/presentation/widgets/auth_field.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorScheme.fromSeed(seedColor: Colors.deepPurple).surface,
      systemNavigationBarColor:ColorScheme.fromSeed(seedColor: Colors.deepPurple).surfaceVariant,
    ));

    final TextEditingController emailController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthField(textEditingController: textEditingController, hintText: hintText)
          ],
        ),
      ),
    );

  }
}
