
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/repository/customer_repository/customer_home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';

class CustomerHomeController extends GetxController{
  static CustomerHomeController get instance => Get.find();

  final homeRepo = Get.put(CustomerHomeRepository());
  //final cartController =Get.put(CartController());
  @override
  Future<void> onInit() async {
    await getProducts();
    super.onInit();
    index = 0;
  }



  int index = 0;
  TextEditingController search=TextEditingController();

  final carousalCurrentIndex=0.obs;
  late Future<List<ProductModel>> productList;
  //List products = [];


  late final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString searchQuery = ''.obs;


    List<ProductModel> filteredProducts() {
    final query = searchQuery.value.toLowerCase();
    return products.where((product) {
      final productName = product.name.toLowerCase();
      return productName.contains(query);
    }).toList();
  }

  void filterProducts(String query) {
    searchQuery.value = query;
  }

  void updatePageIndicator(index){
    carousalCurrentIndex.value=index;
    //getProducts();

  }
  Future<void> setIndex(int indexx) async {
    index = indexx;
  }



  setList(){
    return productList;
  }

  Future<List<ProductModel>> getProducts()  async {
    productList=homeRepo.getProducts();
    products.assignAll(await homeRepo.getProducts());
      return products;
  }



}