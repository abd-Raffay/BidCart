import 'dart:async';
import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/customer_controllers/customer_home_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerExploreCardCOntroller extends GetxController{

  static CustomerExploreCardCOntroller get instance => Get.find();
  int index=0;
  RxBool showProducts = true.obs;

  void onInit() {
    super.onInit();
    index=0;
    showProducts = true.obs;
    print("Controller initialized");
  }

  final List<Map<String, dynamic>> exploreCards = [
    {
      'imageUrl': Images.fruits,
      'title': 'Fruits & Vegetables',
      'color': Colors.green,
    },
    {
      'imageUrl': Images.cookingOil,
      'title': 'Cooking Oil & Ghee',
      'color': Colors.yellow,
    },
    {
      'imageUrl': Images.meatAndFish,
      'title': 'Meat & Seafood',
      'color': Colors.red,
    },
    {
      'imageUrl': Images.bakeryAndSnacks,
      'title': 'Bakery & Snacks',
      'color': Colors.orange,
    },
    {
      'imageUrl': Images.dairyAndEggs,
      'title': 'Dairy & eggs',
      'color': Colors.grey,
    },
    {
      'imageUrl': Images.beverages,
      'title': 'Beverages',
      'color': Colors.purple,
    },
    {
      'imageUrl': Images.condiments,
      'title': 'Condiments',
      'color': Colors.brown,
    },
    {
      'imageUrl': Images.grains,
      'title': 'Grains and Rice',
      'color': Colors.yellow,
    },
    {
      'imageUrl': Images.personalProducts,
      'title': 'Personal Products',
      'color': Colors.pinkAccent,
    },
    {
      'imageUrl': Images.houseHold,
      'title': 'Household Items',
      'color': Colors.blueAccent,
    },
  ];


  final homecontroller = Get.put(CustomerHomeController());



  late Future<List<ProductModel>> productList ;

  List unfilteredList=[];
  List<ProductModel> filteredList=[];

  void toggleShowProducts() {
    //print("RX SHOW PRODUCTS ${showProducts}");
    showProducts.value = !showProducts.value;
  }
  Future<void> setIndex(int indexx) async {
    index=indexx;
    toggleShowProducts();
    filterList();
    //print("From Controller ${index}");
  }

 Future<List<ProductModel>>getProductsList()  async {

  // print("RX SHOW PRODUCTS ${showProducts}");
    productList=homecontroller.getProducts();
    unfilteredList=await productList;
    return productList;
  }

  filterList() async {
    getProductsList();
    print(index);
    print("unFILTERED LIST ${unfilteredList.length}");
    filteredList.clear(); // Clear the filteredList before adding new items

    for (int i = 0; i < unfilteredList.length; i++) {
      if (unfilteredList[i].category == index.toString()) {
        filteredList.add(unfilteredList[i]); // Add filtered items to filteredList
      }
    }
    print("FILTERED LIST ${filteredList.length}");

    // Code here will only be executed after the loop is completed
    return filteredList;
  }




  Future<List<ProductModel>>getFilteredProducts() async {
     return filterList();
  }
}
