import 'package:bidcart/model/product_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:bidcart/widget/products/product_cards/product_card_vertical.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerHomeController extends GetxController {
  SellerHomeController get instance => Get.find();

  final storeRepo = Get.put(SellerStoreRepository());

  @override
  Future<void> onInit() async {
    await getInventory(_auth.currentUser!.uid);
     storeRepo.getOrderRequests();
    super.onInit();
  }
  final RxString searchQuery = ''.obs;

  final _auth = FirebaseAuth.instance;

  late Future<List<Inventory>> inventory;
  RxList<Inventory> rxInventory = <Inventory>[].obs;
  int index = 0;


  Future<RxList<Inventory>> getInventory(String sellerId) async {
    try {
      // Listen to the stream of inventory data
      storeRepo.getProductsFromInventory(sellerId).listen((List<Inventory> inventory) {
        // Update the rxInventory with the fetched inventory
        rxInventory.assignAll(inventory);
      });
      print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG ${rxInventory.length}");
      return rxInventory;

    } catch (e) {
      print('Error getting inventory: $e');
      return rxInventory;
    }
  }

  Future<void> setIndex(int indexx) async {
    index = indexx;
  }

  removeProduct(id) {
    try {
      storeRepo.deleteProduct(id);
      rxInventory.removeWhere((element) => element.inventoryid == id);
      Get.back();
      Get.snackbar("Success", "Item Deleted Successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.5),
          colorText: Colors.white);

    } on Exception catch (e) {

      // TODO
    }
  }

  // ____________------------- Dialogs _---------------------

  showDeleteDialog(BuildContext context, inventoryid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shadowColor: Colors.white10,
          title: const Text("Delete item"),
          content: Text(
              "Are you sure you want to delete this item? This action cannot be undone. ${inventoryid}"),
          actions: [
            TextButton(
              onPressed: () {
                removeProduct(inventoryid);
                //clearCart();

                // Add your logic for OK button
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                // Add your logic for cancel button
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
