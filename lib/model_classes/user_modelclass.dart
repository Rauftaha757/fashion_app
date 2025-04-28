class usermodel {
  int ?id;
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

    if (id != null && id != 0) {
      map["id"] = id.toString();
    }

    return map;
  }


  factory usermodel.fromMap(Map<String, dynamic> map) {
    return usermodel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

}
