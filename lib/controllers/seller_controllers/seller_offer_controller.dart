import 'package:bidcart/controllers/seller_controllers/seller_home_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class SellerOfferController extends GetxController {
  final requestController = Get.put(SellerRequestController());
  final homeController = Get.put(SellerHomeController());
  final storeRepo = Get.put(SellerStoreRepository());
  final sellerRepo = Get.put(SellerLoginRepository());


  final _auth = FirebaseAuth.instance;

  late List<Inventory> rxOffers = <Inventory>[].obs;


  late RxList<OfferData> rxsellermadeoffers = <OfferData>[].obs;


  void sendOffer(String orderid) async {
    int price=0;
    var orderRequests = requestController.rxOrderRequests;
    var inventoryItems = homeController.rxInventory;
    //print(orderRequests[0].items.length);
    for (var order in orderRequests) {
     // print("ORders id = ${order.orderId} && Orderid = ${orderid}");
      if (order.orderId == orderid) {
        for (var orderItem in order.items) {
          for (var item in inventoryItems) {
            if (orderItem.id == item.productid && orderItem.size == item.size) {
              print(
                  "Orderitemid == ${orderItem.id} Inventoryid == ${item.productid}");
              print("Order Quantity ${orderItem.quantity}");
              price=price+(item.price * orderItem.quantity);


              var modifiedItem = Inventory(
                productid: item.productid,
                name: item.name,
                imageUrl: item.imageUrl,
                quantity:orderItem.quantity ,
                size: item.size!,
                batch:item.batch ,
                category: item.category,
                price: item.price,
                dateofexpiry: item.dateofexpiry,
                inventoryid: "",

              );
              rxOffers.add(modifiedItem);
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
      SellerModel? seller = await sellerRepo.getSellerData(userId!);
      // Create an OfferData instance with all required fields filled
      OfferData offer = OfferData(
          sellerId: seller!.userId,
          items: [],
          sellerName: "",
          dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          orderId: orderid,
          status: 'rejected',
          totalPrice: 0
      );
      await storeRepo.postOffers(offer, orderid);
      await storeRepo.Offerstoseller(offer, orderid);


    }



  void getOffersbyseller() {
    final String? sellerId = _auth.currentUser?.uid;
    storeRepo.getOffersBySeller(sellerId!).listen((List<OfferData> offers) {
      rxsellermadeoffers.assignAll(offers);

      print("Offers ${rxsellermadeoffers.length}");
    }, onError: (dynamic error) {
      print('Error fetching offers: $error');
      // Handle error (e.g., show a snackbar)
    });
  }



}
