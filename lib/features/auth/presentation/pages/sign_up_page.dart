import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/navigation/router.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_field.dart';


class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previousUser, user) {
      if (user.value != null) context.go(NOTES_PAGE_PATH);
      if (user.hasError) {
        final error = user.asError?.error;
        if(error == null) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('An error has occurred: ${error.toString()}')));
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: user.isLoading ? 0.5 : 1.0,
            child: const SignUpForm(),
          ),
          if (user.isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );

  }
}



class SignUpForm extends ConsumerWidget {

  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign up.',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            AuthField(
              textEditingController: emailController,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            AuthField(
              textEditingController: passwordController,
              hintText: "Password",
              isObscureText: true,
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref
                        .read(authNotifierProvider.notifier)
                        .signUp(
                      emailController.text,
                      passwordController.text,
                    );
                  }
                },
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(height: 15),
            const SignInText(),
          ],
        ),
      ),
    );
  }
}

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return RichText(
      text: TextSpan(
        text: "Already have an account?",
        style: appTheme.textTheme.titleMedium,
        children: [
          TextSpan(
            text: ' Sign in?',
            style: appTheme.textTheme.titleMedium?.copyWith(
              color: appTheme.colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push(SIGN_IN_PAGE_PATH);
              },
          )
        ],
      ),
    );
  }
}


