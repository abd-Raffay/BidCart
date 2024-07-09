import 'package:bidcart/model/review_model.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/admin/admin_repository.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final adminRepo = Get.put(AdminRepository());

  late RxList<SellerModel> sellers = <SellerModel>[].obs;
  late RxList<Review> reviews = <Review>[].obs;

  @override
  Future<void> onInit() async {
    getSellerList();
    getReviews();
    print('Admin Controller initialized');
    super.onInit();
  }

  void getSellerList() {
    final sellerStream = adminRepo.getSellers();

    // Listen to changes in the seller list stream
    sellerStream.listen((updatedSellers) {
      sellers.assignAll(updatedSellers);
      sellers.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }, onError: (error) {
      print('Error getting seller list: $error');
    });
  }


  Future<void> setStatus(String storeId, String status) async {
    await adminRepo.setStatus(storeId, status);
    getSellerList();
  }

  List<SellerModel> allSellers() {
    return sellers.toList();
  }

  List<SellerModel> pendingSellers() {
    return sellers.where((seller) => seller.status == 'pending').toList();
  }

  List<SellerModel> blockedSellers() {
    return sellers.where((seller) => seller.status == 'blocked').toList();
  }

  List<SellerModel> approvedSellers() {
    return sellers.where((seller) => seller.status == 'approved').toList();
  }

  List<SellerModel> deletedSellers() {
    return sellers.where((seller) => seller.status == 'rejected').toList();
  }
  getReviews(){

     adminRepo.getReviews().listen((reviewList) {
        reviews.assignAll(reviewList);
        print(reviews);
        print(reviews);
      }, onError: (error) {
        print('Error fetching reviews: $error');
      });

  }

}
