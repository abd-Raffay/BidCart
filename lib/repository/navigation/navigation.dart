import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class Navigation extends GetxController{
  Navigation  get instance =>Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final customerrepo = Get.put(CustomerRepository());
  final customerAuth = Get.put(CustomerAuthenticationRepository());
  final sellerAuth = Get.put(SellerAuthenticationRepository());

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    setIntialScreen(firebaseUser.value);
  }

  setIntialScreen(User? user) async {

    if (user == null) {
      //Get.offAll(()=> AdminNavigationBar());
      //print("User isssssssssssssssssssssss ${user}");
      Get.offAll(() => const OnBoarding());
    } else if (await customerrepo.getCustomer(user.email.toString()) ==
          user.email.toString()) {
        //Customer

      customerAuth.setIntialScreen(user);

        //Get.offAll(()=>const CustomerNavigationBar());
      } else{
        //Seller
      sellerAuth.setInitialScreen(user);

        //Get.offAll(() => CustomerLoginPage());


    }

  }



}