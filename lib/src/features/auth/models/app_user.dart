class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.favorites,
    required this.watchlist,
  });

  final String uid;
  final String name;
  final String email;
  final List<int> favorites;
  final List<int> watchlist;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      favorites: List<int>.from(json['favorites']),
      watchlist: List<int>.from(json['watchlist']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'favorites': favorites,
      'watchlist': watchlist
    };
  }
}
