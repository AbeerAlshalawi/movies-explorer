import 'package:movies/src/features/auth/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreRepositoryProvider = Provider(
  (ref) => FirestoreRepository(),
);

class FirestoreRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addToFavorites(String userId, int movieId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    List<int> favorites = List<int>.from(userDoc.data()!['favorites']);
    favorites.add(movieId);
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'favorites': favorites});
  }

  Future<void> removeFromFavorites(String userId, int movieId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    List<int> favorites = List<int>.from(userDoc.data()!['favorites']);
    favorites.remove(movieId);
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'favorites': favorites});
  }

  Future<void> addToWatchlist(String userId, int movieId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    List<int> watchlist = List<int>.from(userDoc.data()!['watchlist']);
    watchlist.add(movieId);
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'watchlist': watchlist});
  }

  Future<void> removeFromWatchlist(String userId, int movieId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    List<int> watchlist = List<int>.from(userDoc.data()!['watchlist']);
    watchlist.remove(movieId);
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'watchlist': watchlist});
  }

  Stream<AppUser> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
          (doc) => AppUser.fromJson(doc.data()!),
        );
  }
}
