import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  String inventoryid;
  String productid;
  String name;
  String batch;
  String imageUrl;
  int quantity;
  String category;
  String? size; // Nullable string
  int price;
  String dateofexpiry;

  Inventory({
    required this.inventoryid,
    required this.productid,
    required this.name,
    required this.batch,
    required this.imageUrl,
    required this.quantity,
    required this.category,
    required this.size,
    required this.price,
    required this.dateofexpiry,
  });

  Map<String, dynamic> toJson() {
    return {
      "inventoryid": inventoryid,
      "productid": productid,
      "name": name,
      "quantity": quantity,
      "imageurl": imageUrl,
      "category": category,
      "size": size,
      "dateofexpiry": dateofexpiry,
      "price": price,
      "batch": batch,
    };
  }

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      inventoryid: json["inventoryid"] ?? "",
      productid: json["productid"] ?? "",
      name: json["name"] ?? "",
      batch: json["batch"] ?? "",
      imageUrl: json["imageurl"] ?? "",
      quantity: json["quantity"] ?? 0,
      category: json["category"] ?? "",
      size: json["size"] ?? "", // Nullable field, handle null appropriately
      price: json["price"] ?? 0,
      dateofexpiry: json["dateofexpiry"] ?? "",
    );
  }

  factory Inventory.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Inventory(
      inventoryid: document.id,
      productid: data["productid"] ?? "",
      name: data["name"] ?? "",
      batch: data["batch"] ?? "",
      imageUrl: data["imageurl"] ?? "",
      quantity: data["quantity"] ?? 0,
      category: data["category"] ?? "",
      size: data["size"] ?? "", // Nullable field, handle null appropriately
      price: data["price"] ?? 0,
      dateofexpiry: data["dateofexpiry"] ?? "",
    );
  }

  static Inventory empty() => Inventory(
    productid: "",
    inventoryid: "",
    name: "",
    batch: '',
    imageUrl: '',
    quantity: 0,
    category: '',
    size: "",
    price: 0,
    dateofexpiry: "",
  );
}
