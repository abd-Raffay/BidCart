import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:bidcart/widget/snackbar/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/request_model.dart';


class SellerOfferController extends GetxController {
 //final requestController = Get.put(SellerRequestController());
  final homeController = Get.put(SellerHomeController());
  final storeRepo = Get.put(SellerStoreRepository());
  final sellerRepo = Get.put(SellerLoginRepository());


  final _auth = FirebaseAuth.instance;
  late String? sellerId = _auth.currentUser?.uid;

  late RxList<Inventory> rxOffers = <Inventory>[].obs;
  late RxList<OfferData> returnOffers=<OfferData>[].obs;
  late RxList<OfferData> rxsellermadeoffers = <OfferData>[].obs;
  late RxList<RequestData> rxOrderRequests = <RequestData>[].obs;
  RxList<Inventory> inventory=<Inventory>[].obs;



  void sendOffer(String orderid) async {
    int price=0;
    storeRepo.getOrderRequests().listen((requests) {
      rxOrderRequests.assignAll(requests);
    });


    //var inventoryItems = homeController.rxInventory;
    //print(orderRequests[0].items.length);
    for (var order in rxOrderRequests) {
     // print("ORders id = ${order.orderId} && Orderid = ${orderid}");
      if (order.orderId == orderid) {
        for (var orderItem in order.items) {
          for (var item in homeController.rxInventory) {
            if (orderItem.id == item.productid && orderItem.size == item.size) {
              if (item.quantity > orderItem.quantity) {
                price = price + (item.price * orderItem.quantity);

                item.quantity -= orderItem.quantity;

                print("Seller Id ${sellerId!} PRODUCT IDDDDDDDDDD ${item
                    .inventoryid}  QUNATITYYYYYYYYY ${item.quantity}");

                storeRepo.updateInventory(
                    sellerId!, item.inventoryid, item.quantity);

                var modifiedItem = Inventory(
                  productid: item.productid,
                  name: item.name,
                  imageUrl: item.imageUrl,
                  quantity: orderItem.quantity,
                  size: item.size!,
                  batch: item.batch,
                  category: item.category,
                  price: item.price,
                  dateofexpiry: item.dateofexpiry,
                  inventoryid: "",

                );
                rxOffers.add(modifiedItem);
              }
              else{
                break;
              }
            }
          }
        }
      }
    }

    if (rxOffers.isNotEmpty) {
      final String? userId = _auth.currentUser?.uid;
      SellerModel? seller = await sellerRepo.getSellerData(userId!);
      // Create an OfferData instance with all required fields filled
      OfferData offer = OfferData(

        sellerId: seller!.userId,
        // Replace with actual customer ID
        items: rxOffers.toList(),
        // Convert RxList to List
        sellerName: seller.storename,
        // Replace with actual customer name
        dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        // Replace with actual date/time
        orderId: orderid,
        // Replace with actual order ID
        status: 'pending',
          sellerLocation:seller.location,
        totalPrice: price

      );

      bool success = await storeRepo.postOffers(offer, orderid);
      await storeRepo.Offerstoseller(offer, orderid);
      if (success == true) {
        update();
      }
      rxOffers.clear();
    }
  }

  void rejectOffer(String orderid) async {

      final String? userId = _auth.currentUser?.uid;
      SellerModel seller = await sellerRepo.getSellerData(userId!);
      // Create an OfferData instance with all required fields filled
      OfferData offer = OfferData(
          sellerId: seller.userId,
          items: [],
          sellerName: seller.storename,
          dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          orderId: orderid,
          status: 'rejected',
          totalPrice: 0,
          sellerLocation: GeoPoint(0,0),
      );
      await storeRepo.postOffers(offer, orderid);
      await storeRepo.Offerstoseller(offer, orderid);


    }

  void resetOffer(String orderid) async {
    final String? userId = _auth.currentUser?.uid;
    SellerModel? seller = await sellerRepo.getSellerData(userId!);
    // Create an OfferData instance with all required fields filled
    OfferData offer = OfferData(
        sellerId: seller!.userId,
        items: [],
        sellerName: seller.storename,
        dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        orderId: orderid,
        status: 'null',
        totalPrice: 0,
      sellerLocation:GeoPoint(0,0),
    );
    await storeRepo.postOffers(offer, orderid);
    await storeRepo.Offerstoseller(offer, orderid);


  }

  Future<void> cancelOffer(String orderid,String sellerId,String status) async {
    try {
      await getOffersbyseller(sellerId);
      print("RXSELLER MADE OFFERS LENGTH +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ${returnOffers.length}");
      await getInventory(sellerId);
      print("INVENTORY LENGTH +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ${inventory.length}");
      print("+++++++++++++++++++++++++++++++++++ ${returnOffers.length}");

      if (returnOffers.isNotEmpty) {
        for (int i = 0; i < returnOffers.length; i++) {
          if (returnOffers[i].orderId == orderid) {
            for (int j = 0; j < returnOffers[i].items.length; j++) {
              for (int k = 0; k < inventory.length; k++) {

                if (returnOffers[i].items[j].productid == inventory[k].productid &&
                    returnOffers[i].items[j].batch == inventory[k].batch &&
                    returnOffers[i].items[j].size == inventory[k].size) {

                  inventory[k].quantity += returnOffers[i].items[j].quantity;
                  await storeRepo.updateInventory(sellerId, inventory[k].inventoryid, inventory[k].quantity);
                }
              }
            }
          }
        }
        inventory.clear();
        await storeRepo.deleteOffer(orderid, sellerId);
        await storeRepo.deleteOfferSeller(orderid, sellerId,status);

      } else {
        print("No offers returned.");
        // Handle case where no offers were returned
      }
    } catch (error) {
      print('Error fetching offers: $error');
      // Handle error (e.g., show a snackbar)
    }

  }



  Future<void> getOffersbyseller(String sellerId) async {
      returnOffers.assignAll(await storeRepo.getSellerOffers(sellerId));
    print("++++++++++++++++++++++ GET OFFERS BY SELLER ++++++++++++++++++++++++");
  }
  Future<void> getInventory(String sellerId) async {

    inventory.assignAll( await storeRepo.getInventory(sellerId));
    print("++++++++++++++++++++++ GET INventoryyyy ++++++++++++++++++++++++");
  }





}
