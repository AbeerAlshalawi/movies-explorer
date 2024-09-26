import 'package:movies/src/core/constants/app_sizes.dart';
import 'package:movies/src/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    required this.child,
  });

  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          side: borderColor == null? null : BorderSide(color: borderColor!)
        ),
        child: child);
  }
}

class Googlesigninbutton extends ConsumerWidget {
  const Googlesigninbutton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewmodelProvider);

    return AuthButton(
      onPressed: () {
        ref.read(authViewmodelProvider.notifier).googleLogin();
      },
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      child: authState.when(
        data: (user) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/google_logo.svg'),
              gapW8,
              const Text('Continue with Google')
            ],
          );
        },
        error: (error, stackTrace) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/google_logo.svg'),
            gapW8,
            const Text('Continue with Google')
          ],
        ),
        loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
