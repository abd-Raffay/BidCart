
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomerOrderController extends GetxController{
  CustomerOrderController get instance=> Get.find();

  final storeRepo = Get.put(SellerStoreRepository());

  Future<void> onInit() async {
    // Perform initialization tasks herep
    getRequests();
    super.onInit();
  }


  late List<RequestData> orderRequests = [];
  late RxList<RequestData> rxOrderRequests = <RequestData>[].obs;

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








}