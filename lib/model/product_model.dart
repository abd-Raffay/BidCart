import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
   String id;
   String name;
    String description;
    String imageUrl;
    String quantity;
   String category;
String size;
  ProductModel({
      required this.category,
    required this.quantity,
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.size
  });

  toJson() {
    return {
      "productid": id,
      "name": name,
      "description": description,
      "quantity":quantity,
      "imageurl":imageUrl,
      "category":category,
    };
  }
  static ProductModel empty() => ProductModel(id: "", name: "", description:'', imageUrl: '',quantity:'',category:'',size:'');

  //MAP Products Fetch  From FIREBASE to Model

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      name: data["name"],
      description: data["description"],
      imageUrl: data["imageurl"],
      quantity: data["quantity"],
        category: data["category"],
      size: data["size"],
    );
  }
}
