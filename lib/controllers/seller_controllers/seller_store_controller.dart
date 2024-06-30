import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SellerStoreController extends GetxController{

  final homeController = Get.put(SellerHomeController());

  @override
  Future<void> onInit() async {
    await getProducts();
    super.onInit();

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

  SellerStoreController get instance => Get.find();
  final storeRepo= Get.put(SellerStoreRepository());
  late Future<List<ProductModel>> productList;

  TextEditingController dateController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  TextEditingController prizeController=TextEditingController();
  TextEditingController batchController=TextEditingController();
  String size="";

  List products = [];
  int index=0;

  List unfilteredList = [];
  List<Inventory> filteredList = [];

  late RxList<Inventory> allproducts = <Inventory>[].obs;
  //late RxList<Inventory> inventory = <Inventory>[].obs;
  final RxList<Inventory> rxSellerProducts = RxList<Inventory>();


  Future<void> setIndex(int indexx) async {
     index = indexx;
     filterList();
  }

  List<String>getSizes(id){

    ProductModel matchedProduct =products.firstWhere((product) => product.id == id);
    return matchedProduct.size ?? [];

  }

  addProducttoInventory(Inventory product){


    var inventory =homeController.rxInventory;

    inventory.add(product);


    product.size=size;
    product.quantity=int.parse(quantityController.text.toString());
    product.batch=batchController.text.toString();
    product.price=int.parse(prizeController.text.toString());
    product.dateofexpiry=dateController.text;


    storeRepo.saveToInventory(product);
    size="";
    quantityController.clear();
    batchController.clear();
    prizeController.clear();
    dateController.clear();

  }


  filterList() async {
    print("filteredList.length ${filteredList.length}");
    print("index $index");

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