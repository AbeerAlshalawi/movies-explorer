import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/src/features/auth/models/app_user.dart';
import 'package:movies/src/features/auth/repository/auth_repository.dart';
import 'package:movies/src/features/auth/repository/firestore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final authViewmodelProvider =
    NotifierProvider<AuthViewmodel, AsyncValue<AppUser?>>(
  () {
    return AuthViewmodel();
  },
);

class AuthViewmodel extends Notifier<AsyncValue<AppUser?>> {
  late AuthRepository _authRepository;
  late FirestoreRepository _firestoreRepository;

  @override
  build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return const AsyncValue.data(null);
  }

  loginWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final userCredential =
          await _authRepository.loginWithEmail(email, password);
      final user = await _firestoreRepository.getUser(userCredential.user!.uid);
      state = AsyncValue.data(user);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  signUpWithEmail(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final userCredential =
          await _authRepository.signupWithEmail(name, email, password);
      final user = AppUser(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        favorites: [],
        watchlist: []
      );
      await _firestoreRepository.createUser(user);
      state = AsyncValue.data(user);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  googleLogin() async {
    state = const AsyncValue.loading();
    try {
      final userCredential = await _authRepository.googleLogin();
      if (userCredential == null) {
        state = const AsyncValue.data(null);
        return;
      }
      AppUser? user =
          await _firestoreRepository.getUser(userCredential.user!.uid);

      if (user != null) {
        state = AsyncValue.data(user);
        return;
      }

      // new google login
      user = AppUser(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
        favorites: [],
        watchlist: []
      );
      await _firestoreRepository.createUser(user);
      state = AsyncValue.data(user);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  logout() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.logout();
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
