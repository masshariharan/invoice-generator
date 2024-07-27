class Company {
  String name;
  String email;
  String phone;
  String address;

  Company({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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
