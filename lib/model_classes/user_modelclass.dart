class usermodel {
  int? id;
  String name;
  String email;
  String password;

  usermodel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> tomap() {
    final map = {
      "name": name,
      "email": email,
      "password": password,
    };


    return map;
  }

  factory usermodel.fromMap(Map<String, dynamic> map) {
    return usermodel(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) : null,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
