import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  String? inventoryid;
  String productid;
  String name;
  String batch;
  String imageUrl;
  int quantity;
  String category;
  String? size;
  int price;
  String dateofexpiry;
  // Correctly defined as List<String>

  Inventory({
    required this.inventoryid,
    required this.productid,
    required this.name,
    required this.batch,
    required this.imageUrl,
    required this.quantity,
    required this.category,
    required this.size,
    required this.dateofexpiry,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "inventoryid":inventoryid,
      "productid": productid,
      "name": name,
      "description": batch,
      "quantity": quantity,
      "imageurl": imageUrl,
      "category": category,
      "size": size,
      "dateofexpiry":dateofexpiry,
      "price":price,// Serialize size as List<String>
    };
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
    dateofexpiry: ""
  );

  // MAP Products Fetch From FIREBASE to Model

  factory Inventory.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Inventory(
      inventoryid: document.id,
      productid: data["productid"] ?? "", // Use empty string as default value if null
      name: data["name"] ?? "", // Use empty string as default value if null
      batch: data["batch"] ?? "", // Use empty string as default value if null
      imageUrl: data["imageurl"] ?? "", // Use empty string as default value if null
      quantity: data["quantity"] ?? 0, // Use 0 as default value if null
      category: data["category"] ?? "", // Use empty string as default value if null
      size: data["size"] ?? "", // Use empty string as default value if null
      price: data["price"] ?? 0, // Use 0 as default value if null
      dateofexpiry: data["dateofexpiry"] ?? "", // Use empty string as default value if null
    );
  }

}
