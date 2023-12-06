class User {
  final String email;
  final String fullname;
  final String jabatan;
  final String telepon;

  User({
    required this.email,
    required this.fullname,
    required this.jabatan,
    required this.telepon,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      jabatan: json['jabatan'] ?? '',
      telepon: json['telepon'] ?? '',
    );
  }
}
