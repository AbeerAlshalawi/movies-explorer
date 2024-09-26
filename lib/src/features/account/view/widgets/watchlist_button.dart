import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/src/features/account/repository/firestore_repository.dart';
import 'package:movies/src/features/account/viewmodel/account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchlistButton extends ConsumerWidget {
  const WatchlistButton(this.movieId, {super.key});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestore = ref.watch(firestoreRepositoryProvider);
    final userStream = ref.watch(userStreamProvider(
      FirebaseAuth.instance.currentUser!.uid,
    ));

    return userStream.when(
      data: (user) {
        final isAdded = user.watchlist.contains(movieId);

        return IconButton(
          onPressed: () {
            isAdded
                ? firestore.removeFromWatchlist(user.uid, movieId)
                : firestore.addToWatchlist(user.uid, movieId);
          },
          icon: Icon(
            isAdded ? Icons.bookmark : Icons.bookmark_border,
            color: isAdded
                ? const Color(0xFF86CBFC)
                : Theme.of(context).colorScheme.secondary,
          ),
        );
      },
      error: (error, stackTrace) => IconButton(
        onPressed: () {},
        icon: const Icon(Icons.bookmark_border),
      ),
      loading: () => IconButton(
        onPressed: () {},
        icon: const Icon(Icons.bookmark_border),
      ),
    );
  }
}