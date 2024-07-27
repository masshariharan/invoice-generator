class Client {
  String name;
  String address;
  String phone;
  String email;
  Client(
      {required this.name,
      required this.address,
      required this.phone,
      required this.email});

  factory Client.fromMap(Map<String, dynamic> json) => Client(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
      };
}
