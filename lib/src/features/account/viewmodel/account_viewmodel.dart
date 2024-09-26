import 'package:movies/src/features/account/repository/firestore_repository.dart';
import 'package:movies/src/features/auth/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.family<AppUser, String>(
  (ref, uid) => ref
      .watch(firestoreRepositoryProvider)
      .getUserStream(uid),
);
