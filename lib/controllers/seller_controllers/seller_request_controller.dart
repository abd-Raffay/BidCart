import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/model/offer_model.dart';

import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:get/get.dart';



class SellerRequestController extends GetxController {
  final storeRepo = Get.put(SellerStoreRepository());
  final homeController = Get.put(SellerHomeController());
  final sellerrepo = Get.put(SellerLoginRepository());

  late List<RequestData> orderRequests = [];
  late RxList<RequestData> rxOrderRequests = <RequestData>[].obs;
  late RxList<OfferData> rxsellermadeoffers = <OfferData>[].obs;



  final _auth = FirebaseAuth.instance;

  late String? userid= _auth.currentUser?.uid;

  late int index;


  @override
  Future<void> onInit() async {
    super.onInit();
    getRequests();
    getOffersbyseller();
    getOrderStatus();
  }

  RxList<RequestData> getRequests() {
    storeRepo.getOrderRequests().listen((requests) {
      orderRequests = requests;
      rxOrderRequests.assignAll(orderRequests);

      getOffersbyseller();
      // Call getOrderStatus after updating rxOrderRequests
      getOrderStatus();
      calculatedistance();
    });

    return rxOrderRequests;
  }


  totalAvailableProducts(String orderid) {
    int availableProducts = 0;
    int index =0;

    for (int j = 0; j < orderRequests.length; j++) {
      if(orderid == orderRequests[j].orderId){
        index=j;
        break;
      }

    }


    for (int j = 0; j < orderRequests[index].items.length; j++) {

      for (int k = 0; k < homeController.rxInventory.length; k++) {
        //Inventory inventoryItem = homeController.rxInventory[k];

        if (orderRequests[index].items[j].id == homeController.rxInventory[k].productid && orderRequests[index].items[j].size == homeController.rxInventory[k].size) {
          // If a match is found, add the product to available products
          availableProducts++;
          // Add other properties of Product if needed
          break; // Break the loop since a match is found for this item
        }
      }
    }
    return availableProducts;
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

  getOffersbyseller() {
    final String? sellerId = _auth.currentUser?.uid;
    storeRepo.getOffersBySeller(sellerId!).listen((List<OfferData> offers) {
      rxsellermadeoffers.assignAll(offers);
      getOrderStatus();
      //print("Offers ${rxsellermadeoffers.length}");
    }, onError: (dynamic error) {
      print('Error fetching offers: $error');
      // Handle error (e.g., show a snackbar)
    });
  }

  getOrderStatus() {
    //rxOrderRequests.removeWhere((request) => request.status == "accepted");
    for (int i = 0; i < rxOrderRequests.length; i++) {
      //print("Order id ${rxsellermadeoffers[i].orderId} ");
      for (int j = 0; j < rxsellermadeoffers.length; j++) {
        if (rxsellermadeoffers[j].orderId == rxOrderRequests[i].orderId) {
          if (rxOrderRequests[i].status != "accepted") {
            rxOrderRequests[i].status = rxsellermadeoffers[j].status;
          }
        }
      }
      rxOrderRequests.removeWhere((request) => request.status == "rejected");
      //print(rxOrderRequests.length);
      for (int i = 0; i < rxOrderRequests.length; i++) {
        print("${i} Order id ${rxOrderRequests[i].orderId} :: Status ${rxOrderRequests[i].status} ");

      }
    }
  }

  calculatedistance() async {
    SellerModel seller = await sellerrepo.getSellerData(_auth.currentUser!.uid);
    FlutterMapMath mapMath = FlutterMapMath();
    for(int i=0 ;i<rxOrderRequests.length;i++) {
      double distance = mapMath.distanceBetween(
        seller.location.latitude,
        seller.location.longitude,
        rxOrderRequests[i].location.latitude,
        rxOrderRequests[i].location.longitude,
        "meters",
      );
      if(distance > 1000){
        rxOrderRequests.removeAt(i);
      }
      print(
          "Distance is +++++++++++++++++++++++++++++++++++++++++++++++++++++++ ${distance}");
    }
  }


















}
