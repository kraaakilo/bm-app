class User {
  String? email = "";

  User({this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
    );
  }
}
