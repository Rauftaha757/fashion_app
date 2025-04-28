class OderModel {
  int? oderid;
  String name;
  double price;
  int count;
  int userId;

  OderModel({
    this.oderid,
    required this.name,
    required this.price,
    required this.count,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    final map = {
      "name": name,
      "price": price,
      "count": count,
      "userId": userId,
    };
    if (oderid != null) {
      map["oderid"] = oderid.toString();
    }
    return map;
  }

  factory OderModel.fromMap(Map<String, dynamic> map) {
    return OderModel(
      oderid: map["oderid"],
      name: map["name"],
      price: map["price"],
      count: map["count"],
      userId: map["userId"],
    );
  }
}
