class Item {
  String name;
  int quantity;
  double price;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
  });

  List<String> toList() => [
        name,
        "$quantity",
        "\$${price.toStringAsFixed(2)}",
        ((price * quantity).toStringAsFixed(2))
      ];

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "quantity": quantity,
        "price": price,
      };
}
