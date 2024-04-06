import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String description;
  String imageUrl;
  int quantity;
  String category;
  List<String> size; // Correctly defined as List<String>

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.category,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "productid": id,
      "name": name,
      "description": description,
      "quantity": quantity,
      "imageurl": imageUrl,
      "category": category,
      "size": size, // Serialize size as List<String>
    };
  }

  static ProductModel empty() => ProductModel(
    id: "",
    name: "",
    description: '',
    imageUrl: '',
    quantity: 0,
    category: '',
    size: [],
  );

  // MAP Products Fetch From FIREBASE to Model

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final List<dynamic> sizeData = data['size'] ?? [];

    return ProductModel(
      id: document.id,
      name: data["name"],
      description: data["description"],
      imageUrl: data["imageurl"],
      quantity: data["quantity"],
      category: data["category"],
      size: sizeData.map((size) => size.toString()).toList(), // Convert size data to List<String>
    );
  }
}
