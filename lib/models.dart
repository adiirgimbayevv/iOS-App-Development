class AppUser {
  final String fullName;
  final String email;
  final String role;
  final String password;

  const AppUser({
    required this.fullName,
    required this.email,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'role': role,
        'password': password,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? 'Customer',
      password: json['password'] as String? ?? '',
    );
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String category;
  final String date;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.date,
  });
}
