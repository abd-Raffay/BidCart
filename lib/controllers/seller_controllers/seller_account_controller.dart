import 'package:bidcart/repository/seller_repository/seller_login_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../model/seller_model.dart';
import '../../repository/authentication/seller_authentication_repository.dart';
import '../../screens/common/onboarding.dart';

class SellerAccountController extends GetxController {
  SellerAccountController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    getSeller();
  }

  User? auth = FirebaseAuth.instance.currentUser;
  final sellerAuthRepo = Get.put(SellerAuthenticationRepository());
  final sellerRepo = Get.put(SellerLoginRepository());

  Rx<SellerModel>seller = SellerModel(
          userId: '',
          sellername: '',
          phone: '',
          cnic: '',
          email: '',
          storename: '',
          address: '',
          status: '',
          storeId: '',
          dateTime: Timestamp(0,0),
          location: GeoPoint(0, 0),
  )
      .obs;



  Future<void> getSeller() async {
    try {
      var sellerData = await sellerRepo.getActualSellerData(auth!.uid);
      if (sellerData != null) {
        seller.value = sellerData;
        print("Customer data loaded successfully: ${seller.value}");
      } else {
        print("Customer data is null");
      }
    } catch (e) {
      print("Error fetching customer data: $e");
    }
  }
  void logout() {
    sellerAuthRepo.logout();
    Get.offAll(() => const OnBoarding());
  }


}

