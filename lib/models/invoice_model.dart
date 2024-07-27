import 'client_model.dart';
import 'company_model.dart';
import 'item_model.dart';

class Invoice {
  String id;
  String date;
  dynamic from;
  dynamic to;
  List<Item> items;
  double total;
  String? invoiceDocId;

  Invoice(
      {required this.id,
      required this.date,
      required this.from,
      required this.to,
      required this.items,
      required this.total,
      this.invoiceDocId});

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
      id: json["id"],
      date: json["date"],
      from: Company.fromJson(json["from"]),
      to: Client.fromMap(json["to"]),
      items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      total: json["total"],
      invoiceDocId: json["invoiceItemId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "from": from,
        "to": to,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "total": total,
        "invoiceItemId": invoiceDocId
      };
}
