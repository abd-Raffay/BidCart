import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:get/get.dart';

class SellerRequestController extends GetxController {
  final storeRepo = Get.put(SellerStoreRepository());
  final homeController = Get.put(SellerHomeController());
  late List<RequestData> orderRequests = [];
  late RxList<RequestData> rxOrderRequests = <RequestData>[].obs;
  late int index;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRequests();
  }

  Future<RxList<RequestData>> getRequests() async {
    // Listen to changes in the order requests
     storeRepo.getOrderRequests().listen((requests) {
      orderRequests = requests;
      rxOrderRequests.assignAll(orderRequests);
      rxOrderRequests.sort((request1, request2) {
        try {
          // Parse the date strings into DateTime objects
          DateTime parsedDate1 = DateTime.parse(request1.dateTime);
          DateTime parsedDate2 = DateTime.parse(request2.dateTime);

          // Debugging print to verify parsed dates
          //print("Parsed Date 1: $parsedDate1, Parsed Date 2: $parsedDate2");

          // Compare the DateTime objects
          return parsedDate2.compareTo(parsedDate1);
        } catch (e) {
          // Error handling in case of invalid date strings
          print("Error parsing dates: $e");
          // Return 0 to maintain the current order if parsing fails
          return 0;
        }
      });
    });

    return rxOrderRequests;
  }

  totalAvailableProducts(int index) {
    int availableProducts = 0;
    for (int j = 0; j < orderRequests[index].items.length; j++) {
      //CartModel item = orderRequest.items[j];
      // Check if the current item's ID and size match with any inventory item

      for (int k = 0; k < homeController.rxInventory.length; k++) {
        //Inventory inventoryItem = homeController.rxInventory[k];

        if (orderRequests[index].items[j].id ==
                homeController.rxInventory[k].productid &&
            orderRequests[index].items[j].size ==
                homeController.rxInventory[k].size) {
          // If a match is found, add the product to available products
          availableProducts++;
          // Add other properties of Product if needed
          break; // Break the loop since a match is found for this item
        }
      }
    }
    return availableProducts;
  }

  totalProducts(index) {
    return orderRequests[index].items.length;
  }

  availableProduct(String productid, String size) {
    int quantity=0;
    for (int i = 0; i < homeController.rxInventory.length; i++) {
      if(homeController.rxInventory[i].productid==productid && homeController.rxInventory[i].size==size)
        {
          quantity= homeController.rxInventory[i].quantity;
          break;
        }

    }
    return quantity;
  }
}
