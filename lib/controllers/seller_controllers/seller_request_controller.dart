import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/request_model.dart';
import 'package:bidcart/repository/seller_repository/seller_store_repository.dart';
import 'package:get/get.dart';

class SellerRequestController extends GetxController {
  final storeRepo = Get.put(SellerStoreRepository());
  late List<RequestData> orderRequests=[];
  late RxList<RequestData>rxOrderRequests=<RequestData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Call main function to initialize orderRequests list
    getRequests();
  }

  Future<RxList<RequestData>> getRequests() async {
    // Listen to changes in the order requests
    storeRepo.getOrderRequests().listen((requests) {
      orderRequests = requests;
      rxOrderRequests.assignAll(orderRequests);
    });
    return rxOrderRequests;
  }

}
