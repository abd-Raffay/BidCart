import 'package:bidcart/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class CustomerHomeRepository extends GetxController {
  static CustomerHomeRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _db.collection("products").get();
      print("Data found");

      List<ProductModel> productList = [];

      snapshot.docs.forEach((doc) {
        ProductModel product = ProductModel.fromSnapshot(doc);
        productList.add(product);
      });
      return productList;
    } catch (e) {
      // Handle any errors that may occur during fetching data
      print("Error getting products: $e");
      return [];
    }


  }






}