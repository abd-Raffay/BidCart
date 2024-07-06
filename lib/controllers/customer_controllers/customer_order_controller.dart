
import 'package:bidcart/controllers/seller_controllers/seller_offer_controller.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/repository/customer_repository/cart_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderController extends GetxController{
  CustomerOrderController get instance=> Get.find();

  final storeRepo = Get.put(SellerStoreRepository());
  final cartRepo = Get.put(CartRepository());

  Future<void> onInit() async {
    // Perform initialization tasks herep
    getRequests();
    super.onInit();
  }


  late List<RequestData> orderRequests = [];
  late RxList<RequestData> rxOrderRequests = <RequestData>[].obs;

  late List<OfferData> orderoffers = [];
  late RxList<OfferData> rxorderOffers = <OfferData>[].obs;

  final _auth = FirebaseAuth.instance;


  RxList<RequestData> getRequests()   {
    // Listen to changes in the order requests
    storeRepo.getOrder(_auth.currentUser?.uid).listen((requests) {
      orderRequests = requests;
      rxOrderRequests.assignAll(orderRequests);
    });

    //print("Order Found ${orderRequests.length}");

    return rxOrderRequests;
  }

  removeOrder(String orderId){

    storeRepo.removeOrder(orderId);

  }

  Future<void> updateDistance(int distance,String orderid) async {
    await cartRepo.updateDistance(distance,orderid);
  }
  void getOffers(String orderId) {
    cartRepo.getOffersByOrderId(orderId).listen((List<OfferData> offers) {
      rxorderOffers.assignAll(offers);

      print("Order Length ${rxorderOffers.length}");
    }, onError: (dynamic error) {
      print('Error fetching offers: $error');
      // Handle error (e.g., show a snackbar)
      Get.snackbar(
        "Error",
        "Failed to fetch offers",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }


  void acceptOrder(String sellerId,String orderId){

   //print("Seller ID : ${sellerId} && Order ID : ${orderId}");
    cartRepo.acceptOrder(sellerId, orderId);

  }

  void rejectOrder(String orderid,String sellerId){
    final sellerOfferController=Get.put( SellerOfferController());
    sellerOfferController.cancelOffer(orderid, sellerId, "rejected");

  }







}