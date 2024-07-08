import 'package:bidcart/model/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../repository/authentication/customer_authentication_repository.dart';
import '../../repository/customer_repository/customer_repository.dart';
import '../../screens/common/onboarding.dart';



class CustomerAccountController extends GetxController{

  static CustomerAccountController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    getCustomer();
  }

  User? auth = FirebaseAuth.instance.currentUser;
  final customerAuthRepo = Get.put(CustomerAuthenticationRepository());
  final customerRepo = Get.put(CustomerRepository());




  Rx<CustomerModel> customer = CustomerModel(
    address: '',
    email: '',
    id: '',
    location: GeoPoint(0, 0),
    name: '',
    phone: '',
  ).obs;


  Future<void> getCustomer() async {
    try {
      var customerData = await customerRepo.getCustomerrData(auth!.uid);
      if (customerData != null) {
        customer.value = customerData;
        print("Customer data loaded successfully: ${customer.value}");
      } else {
        print("Customer data is null");
      }
    } catch (e) {
      print("Error fetching customer data: $e");
    }
  }
  void logout() {
    customerAuthRepo.logout();
    Get.offAll(() => const OnBoarding());
  }

}