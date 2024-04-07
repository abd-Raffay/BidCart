import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/repository/exception/exceptions.dart';
import 'package:bidcart/repository/seller_repository/seller_repository.dart';
import 'package:bidcart/screens/admin/admin_navigationbar.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:bidcart/screens/seller/approval_screen.dart';
import 'package:bidcart/screens/seller/seller_homescreen.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:bidcart/screens/seller/seller_mail_verfication.dart';
import 'package:bidcart/screens/seller/seller_rejected_screen.dart';
import 'package:bidcart/screens/seller/seller_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SellerAuthenticationRepository extends GetxController {
  static SellerAuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final sellerrepo = Get.put(SellerRepository());

  @override

  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    setInitialScreen(firebaseUser.value);
    //ever(firebaseUser, setIntialScreen);
  }

  setInitialScreen(User? user) async {

    if (user == null) {
      //Get.offAll(()=> AdminNavigationBar());
      //print("User isssssssssssssssssssssss ${user}");
      Get.offAll(() => const OnBoarding());
    } else if (user.emailVerified) {
      //print("++++++++++++++++++++++++++++++++++++++++${sellerrepo.getApprovalStatus(user.uid).toString()}+++++++++++++++++++++++++++++++++");

      //checks if the user is seller
      if (await sellerrepo.getSeller(user.email.toString())==user.email.toString()) {
        //check if the seller is approved
        if(await sellerrepo.getApprovalStatus(user.uid)=="approved"){
          //Get.offAll(() => const SellerHomeScreen());
          Get.to(()=>SellerNavigationBar());
        }else if(await sellerrepo.getApprovalStatus(user.uid)=="rejected"){
          Get.offAll(()=> RejectionScreen());
        }
        else{
          Get.offAll(() => const ApprovalScreen());
        }
      }else{
        Get.offAll(()=> SLoginPage());
      }

    } else {
      Get.offAll(() => const SellerMailVerification());
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, SellerModel seller) async {
    try {
      print("*********************************************************Creating user with email and password*********************************************************************");

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      seller.userId = (await _auth.currentUser?.uid)!;
      seller.status="pending";
      seller.dateTime=Timestamp.now();


      sellerrepo.createUser(seller);
      firebaseUser.value != null
          ? Get.offAll(() => OnBoarding())
          //: Get.to(() => SellerHomeScreen());
      :Get.to(()=>SellerNavigationBar());


    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);

      Get.snackbar(e.code, ex.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white);

      throw ex;
    } catch (_) {
      const ex = Exceptions();
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      String emailformdb = await sellerrepo.getSeller(email);
      //print("Email from customerrepo ${emailformdb}");
      print("Coomparing Input Email: ${email} and DB Email ${emailformdb}");
      if (email == emailformdb) {

        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      else{
        Get.snackbar("User Not Found", "User the the provided Email doesn't exists",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }

    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);
      Get.snackbar(e.code, ex.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white);

      // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;

      // TODO
    } catch (_) {
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      //print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      //throw ex;
    }
  }



  Future<void> logout() async {
    await _auth.signOut();

  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = Exceptions();
      throw ex.message;
    }
  }

  Future GetApprovalStatus() async {
    return await SellerRepository.instance.getApprovalStatus(firebaseUser.value!.uid);
  }


}
