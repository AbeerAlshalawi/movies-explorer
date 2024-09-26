import 'package:movies/firebase_options.dart';
import 'package:movies/src/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/src/core/view/main_screen.dart';
import 'package:movies/src/features/auth/view/screens/welcome_screen.dart';
import 'package:movies/src/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:movies/src/shared/view/screens/error_screen.dart';
import 'package:movies/src/shared/view/screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MoviesApp(),
    ),
  );
}

class MoviesApp extends ConsumerWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: AppTheme.themeData,
      home: authState.when(
        data: (user) {
          if (user == null) {
            return const WelcomeScreen();
          }

          return const MainScreen();
        },
        error: (error, stackTrace) => ErrorScreen(error),
        loading: () => const LoadingScreen(),
      ),
    );
  }
}
