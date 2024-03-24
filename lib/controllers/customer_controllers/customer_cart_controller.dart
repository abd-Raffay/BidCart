import 'package:bidcart/model/product_model.dart';
import 'package:get/get.dart';

import 'customer_home_controller.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final homecontroller = Get.put(CustomerHomeController());


  late Future<List<ProductModel>> productListFuture;

  List<ProductModel> cart = [];
  List productList = [];

  Future<List<ProductModel>>  getProductsList() async {
     print("RX SHOW PRODUCTS ");
    productListFuture = homecontroller.setList();
    productList = await productListFuture;
    return await productListFuture;
  }

  //List<ProductModel> cart=ProductModel.empty();
  addProductstoCart(productId) {

    int quantity;

    if (cart.any((item) => item.id == productId)) {
      for (int i = 0; i < cart.length; i++) {
        if (cart[i].id == productId) {
          quantity = int.parse(cart[i].quantity) + 1;
          cart[i].quantity = quantity.toString();
          break; // Once the item is found and updated, we can exit the loop
        }
      }
    } else {
      for (int i = 0; i < productList.length; i++) {
        if (productList[i].id == productId) {
           i;
          cart.add(productList[i]);
          break; // Once the item is found and updated, we can exit the loop
        }
      }

    }
    print("Cart Length${cart.length}");
    print("product list Length${productList.length}");
  }

  removeProducts() {}

  showCart() {
    print(cart.length);
    return Future.value(cart);
  }

  cartCounter() {
    return cart.length;
  }

  increaseQuantity() {}

  decreaseQuantity() {}
}
