

import 'package:bidcart/controllers/seller_controllers/seller_offer_controller.dart';
import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/model/review_model.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/customer_repository/cart_repository.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:bidcart/screens/customer/customer_orderscreen.dart';
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
  final sellerOfferController=Get.put( SellerOfferController());
  Future<void> onInit() async {
    // Perform initialization tasks herep
    getRequests();
    super.onInit();
  }


  late List<RequestData> orderRequests = [];
  late RxList<RequestData> rxOrderRequests = <RequestData>[].obs;

  late List<OfferData> orderoffers = [];
  late RxList<OfferData> rxorderOffers = <OfferData>[].obs;
  RxList<OfferData> rejectedoffers=<OfferData>[].obs;
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

  Future<List<OfferData>> getOffers(String orderId) async {
    try {
      final List<OfferData> offers = await cartRepo.getOffersByOrderId(orderId).first;
      rxorderOffers.assignAll(offers);
      print("Order Length ${rxorderOffers.length}");
      return offers;
    } catch (error) {
      print('Error fetching offers: $error');
      // Handle error (e.g., show a snackbar)
      Get.snackbar(
        "Error",
        "Failed to fetch offers",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
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



  Future<void> acceptOrder(String sellerId,String orderId,int price,GeoPoint sellerLocation) async {

    rejectedoffers.clear();
    print("Seller ID : ${sellerId} && Order ID : ${orderId}");
    rejectedoffers.assignAll(rxorderOffers);
    print("Rejected orders Length : ${rejectedoffers.length}");
    rejectedoffers.removeWhere((element) => element.sellerId == sellerId);
    print("Rejected orders Length after : ${rejectedoffers.length}");
    for(int i=0;i<rejectedoffers.length;i++){
      print("Rejected offer ${rejectedoffers[i].orderId},Seller ID ${rejectedoffers[i].sellerId}");
      rejectOrder(rejectedoffers[i].orderId,rejectedoffers[i].sellerId);
    }
    await cartRepo.acceptOrder(sellerId, orderId,price,sellerLocation);

    await checkOrder(orderId);


  }

  void rejectOrder(String orderid,String sellerId){

    sellerOfferController.cancelOffer(orderid, sellerId, "rejected");

  }




  Future<int> getDistance(String orderid, String sellerid,GeoPoint sellerLocation) async {
    late GeoPoint customerlocation;
    FlutterMapMath mapMath = FlutterMapMath();
    for (int i = 0; i < rxOrderRequests.length; i++) {
      if (rxOrderRequests[i].orderId == orderid) {
        customerlocation = GeoPoint(rxOrderRequests[i].location.latitude, rxOrderRequests[i].location.longitude);
        break;
      }
    }
    double tempdistance = mapMath.distanceBetween(
      sellerLocation.latitude,
      sellerLocation.longitude,
      customerlocation.latitude,
      customerlocation.longitude,
      "kilometers",
    );

    return tempdistance.toInt();;
  }

  getLocation(String orderid, String sellerid) async {
    late GeoPoint location;
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
    return ' ${first.locality},${first.subLocality},${first.thoroughfare}, ${first.subThoroughfare}';
  }

  getSellerLocation(String sellerid) async {

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


  }



  Future<void> checkOrder(String orderId)async {
    try {
      print("+++++++++++++++++++++ CHECKING ORDER +++++++++++++++++++++++++++++++++");
      // Find the order with the given orderId
      RequestData order = rxOrderRequests.firstWhere(
            (element) => element.orderId == orderId,
        orElse: () => throw Exception('Order not found'),
      );
      List<CartModel> newItems=[];
      OfferData? offer =await storeRepo.getSellerOffer(order.sellerId!,order.orderId!);

      int totalcount=0;
      int count=0;
      for(int i=0; i<order.items.length;i++){
        count=0;
        for(int j=0 ;j<offer!.items.length;j++){

          if(order.items[i].id == offer.items[j].productid && order.items[i].size == offer.items[j].size ){
            count++;
            totalcount++;
          }
        }
        if(count == 0){
          newItems.add(order.items[i]);
          count=0;
        }
      }

      print("TOTAL COUNT ${totalcount} ORDER COUNT ${order.items.length}");
      print("NEW ITEMSS AREEEE ${newItems.length}");
      if(totalcount == order.items.length){
        Get.back();
      }else {
        RequestData tempOrder = RequestData(
            customerId: order.customerId,
            items: newItems,
            customerName: order.customerName,
            dateTime: "",
            status: "",
            sellerId: "",
            location: order.location,
            distance: order.distance,
            price: 0,
            sellerLocation: const GeoPoint(0, 0)
        );
        cartRepo.generateNewRequest(tempOrder);
      }

    } catch (e) {
      print('Error: $e');
    }



  }















}