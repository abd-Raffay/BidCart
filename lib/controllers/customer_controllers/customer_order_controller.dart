

import 'package:bidcart/controllers/seller_controllers/seller_offer_controller.dart';
import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/model/review_model.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/customer_repository/cart_repository.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class CustomerOrderController extends GetxController{
  CustomerOrderController get instance=> Get.find();

  final storeRepo = Get.put(SellerStoreRepository());
  final cartRepo = Get.put(CartRepository());
final sellerRepo =Get.put(SellerLoginRepository());
final customerRepo=Get.put(CustomerRepository());
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


    return rxOrderRequests;
  }

  removeOrder(String orderId){

    storeRepo.removeOrder(orderId);

  }


  Future<void> updateDistance(int distance,String orderid) async {
    await cartRepo.updateDistance(distance,orderid);
  }

   getOffers(String orderId) {
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

  OfferData? getOffer(String sellerId) {
    try {
      print(rxorderOffers.length);
      return rxorderOffers.firstWhere((offer) => offer.sellerId == sellerId);
    } catch (e) {

      print('Offer with sellerId $sellerId not found: $e');
      return null; // Return null if offer is not found
    }
  }



  void acceptOrder(String sellerId,String orderId,int price){

   //print("Seller ID : ${sellerId} && Order ID : ${orderId}");
    cartRepo.acceptOrder(sellerId, orderId,price);

  }

  void rejectOrder(String orderid,String sellerId){
    final sellerOfferController=Get.put( SellerOfferController());
    sellerOfferController.cancelOffer(orderid, sellerId, "rejected");

  }



  Future<int> getDistance(String orderid, String sellerid) async {
    late GeoPoint customerlocation;
    SellerModel seller = await sellerRepo.getSellerData(sellerid);
    FlutterMapMath mapMath = FlutterMapMath();

    for (int i = 0; i < rxOrderRequests.length; i++) {
      if (rxOrderRequests[i].orderId == orderid) {
        customerlocation = GeoPoint(rxOrderRequests[i].location.latitude, rxOrderRequests[i].location.longitude);
        break;
      }
    }

    double tempdistance = mapMath.distanceBetween(
      seller.location.latitude,
      seller.location.longitude,
      customerlocation.latitude,
      customerlocation.longitude,
      "meters",
    );
    print("TEMP DISTANCE IS ++++++++++++++++++++++++++ ${tempdistance}");

    return tempdistance.toInt();
  }

  Future<String> getLocation(String orderid, String sellerid) async {
    late GeoPoint location;
    SellerModel seller = await sellerRepo.getSellerData(sellerid);
    FlutterMapMath mapMath = FlutterMapMath();

    for (int i = 0; i < rxOrderRequests.length; i++) {
      if (rxOrderRequests[i].orderId == orderid) {
        location = GeoPoint(rxOrderRequests[i].location.latitude,
            rxOrderRequests[i].location.longitude);
        break;
      }
    }




    List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude, location.longitude);
    Placemark first = placemarks[0];
    return ' ${first.locality},${first.subLocality},${first
        .thoroughfare}, ${first.subThoroughfare}';
  }

  Future<GeoPoint> getSellerLocation(String sellerid) async {
    SellerModel seller = await sellerRepo.getSellerData(sellerid);
    return seller.location;
  }

  Future<void> saveReview(OfferData offer,String review) async {

    User? _auth=FirebaseAuth.instance.currentUser;

    CustomerModel? customer=await customerRepo.getCustomerrData(_auth!.uid);

    Review tempReview=Review(
        customerId: _auth.uid,
        offer: offer,
        customerName: customer!.name,
        reviewDateTime: "",
        review: review,
    );

    cartRepo.saveReview(tempReview);


    //orderid
    //customerid
    //sellerid
    //date
    //review


  }















}