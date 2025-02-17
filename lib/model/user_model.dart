class User {
  final String id;
  final String name;
  final String profilePic;
  final String time;

  User({required this.id, required this.name, required this.profilePic, required this.time});

  // Factory method to create a User from JSON (if needed for API integration)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      profilePic: json['profilePic'] ?? '',
      time: json['time'] ?? '',
    );
  }

  // Convert User object to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePic': profilePic,
      'time': time,
    };
  }
}
