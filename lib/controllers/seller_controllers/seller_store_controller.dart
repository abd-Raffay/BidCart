import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SellerStoreController extends GetxController {
  SellerStoreController get instance => Get.find();


  @override
  Future<void> onInit() async {
    await getProducts();
    super.onInit();
    inventory.assignAll(homeController.rxInventory);
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


  final storeRepo = Get.put(SellerStoreRepository());
  final homeController = Get.put(SellerHomeController());

  User? _auth = FirebaseAuth.instance.currentUser;

  late Future<List<ProductModel>> productList;

  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  String size = "";

  List products = [];
  int index = 0;

  List<Inventory> filteredList = [];


  final RxList<Inventory> rxSellerProducts = RxList<Inventory>();

  RxList<Inventory> inventory = <Inventory>[].obs;

  Future<void> setIndex(int indexx) async {
    index = indexx;
    filterList();
  }

  List<String> getSizes(id) {
    ProductModel matchedProduct = products.firstWhere((product) =>
    product.id == id);
    return matchedProduct.size ?? [];
  }

  addProducttoInventory(Inventory product) {
    inventory.assignAll(homeController.rxInventory);
    bool flag = true;
    product.size = size;
    product.quantity = int.parse(quantityController.text.toString());
    product.batch = batchController.text.toString();
    product.price = int.parse(prizeController.text.toString());
    product.dateofexpiry = dateController.text;

    for (int i = 0; i < inventory.length; i++) {
      if (inventory[i].productid == product.productid &&
          inventory[i].batch == product.batch &&
          inventory[i].size == product.size)

        inventory[i].quantity = inventory[i].quantity + product.quantity;

      storeRepo.updateInventory(_auth!.uid,inventory[i].inventoryid, inventory[i].quantity);
      flag = false;
      print("NO id found");
    }

    if (flag == true) {
      inventory.add(product);
      storeRepo.saveToInventory(product);
    }

    size = "";
    quantityController.clear();
    batchController.clear();
    prizeController.clear();
    dateController.clear();
  }



  filterList() async {

    filteredList.clear();
    for (int i = 0; i < rxSellerProducts.length; i++) {
      if (rxSellerProducts[i].category == index.toString()) {
        filteredList.add(rxSellerProducts[i]); // Add filtered items to filteredList
      }
    }
    print(filteredList.length);
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if(picked != null){
      print(picked);
      dateController.text=DateFormat('yyyy-MM-dd').format(picked);
    }
  }










  Future<List<ProductModel>> getProducts()  async {
    print("products.length ${products.length}");
    productList=storeRepo.getProducts();
    products= await productList;
    //allproducts.assignAll(await storeRepo.getProducts());

    print("products.length ${products.length}");

    final List<Inventory> sellerProducts = products.map((product) {
      // Convert ProductModel to SellerProductModel
      return Inventory(
        // Assign relevant fields accordingly
        name: product.name,
        imageUrl: product.imageUrl,
        inventoryid: '',
        productid: product.id,
        quantity: 0,
        batch: '',
        category: product.category,
        size: "",
        dateofexpiry: '',
        price: 0,
      );
    }).toList();

    rxSellerProducts.assignAll(sellerProducts);


    return productList;
  }



}