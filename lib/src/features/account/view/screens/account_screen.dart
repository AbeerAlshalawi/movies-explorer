import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/src/core/constants/app_sizes.dart';
import 'package:movies/src/features/account/view/screens/movie_grid.dart';
import 'package:movies/src/features/account/view/widgets/list_tile.dart';
import 'package:movies/src/features/account/viewmodel/account_viewmodel.dart';
import 'package:movies/src/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:movies/src/shared/view/screens/error_screen.dart';
import 'package:movies/src/shared/view/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream =
        ref.watch(userStreamProvider(FirebaseAuth.instance.currentUser!.uid));
    return userStream.when(
      data: (user) => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(authViewmodelProvider.notifier).logout();
              },
              label: const Text('Logout'),
              style: TextButton.styleFrom(
                  iconColor: const Color(0xFFFFB1B1),
                  foregroundColor: const Color(0xFFFFB1B1)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    foregroundImage:
                        AssetImage('assets/images/profile_pic.png'),
                    radius: 24,
                  ),
                  gapW12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                        ),
                      )
                    ],
                  )
                ],
              ),
              gapH32,
              AccountListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: Color(0xFFFF8888),
                ),
                title: 'Favorites',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieGrid(
                          title: 'Favorites', movieIds: user.favorites),
                    ),
                  );
                },
              ),
              gapH8,
              AccountListTile(
                leading: const Icon(Icons.bookmark, color: Color(0xFF86CBFC)),
                title: 'Watchlist',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieGrid(
                          title: 'Watchlist', movieIds: user.watchlist),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => ErrorScreen(error),
      loading: () => const LoadingScreen(),
    );
  }
}
