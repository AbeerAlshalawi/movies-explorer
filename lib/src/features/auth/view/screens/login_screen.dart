import 'package:movies/src/core/constants/app_sizes.dart';
import 'package:movies/src/features/auth/view/screens/sign_up_screen.dart';
import 'package:movies/src/features/auth/view/widgets/auth_field.dart';
import 'package:movies/src/features/auth/view/widgets/auth_button.dart';
import 'package:movies/src/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final authViewmodel = ref.read(authViewmodelProvider.notifier);
    authViewmodel.loginWithEmail(
      emailController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewmodelProvider);

    ref.listen(
      authViewmodelProvider,
      (previous, next) {
        if (next.hasValue && next.value != null) {
          WidgetsBinding.instance.scheduleFrameCallback(
            (_) {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome back',
                style: TextStyle(fontSize: 32),
                textAlign: TextAlign.center,
              ),
              gapH32,
              const Text('Email'),
              gapH8,
              AuthField(hintText: 'Email', controller: emailController),
              gapH16,
              const Text('Password'),
              gapH8,
              AuthField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              gapH16,
              AuthButton(
                onPressed: submit,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: authState.when(
                  data: (user) {
                    return const Text('Login');
                  },
                  error: (error, stackTrace) => const Text('Login'),
                  loading: () => SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              gapH24,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No account? '),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
              gapH24,
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              gapH24,
              const Googlesigninbutton(),
            ],
          ),
        ),
      ),
    );
  }
}
