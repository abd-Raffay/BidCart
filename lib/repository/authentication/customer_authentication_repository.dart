
import 'package:bidcart/screens/customer/customer_navigation_bar.dart';
import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/repository/exception/exceptions.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:bidcart/screens/customer/customer_login.dart';
import 'package:bidcart/screens/customer/customer_mail_verfication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomerAuthenticationRepository extends GetxController {
  static CustomerAuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final customerrepo = Get.put(CustomerRepository());

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    setIntialScreen(firebaseUser.value);
    //ever(firebaseUser, setIntialScreen);
  }

  setIntialScreen(User? user) async {

    if (user == null) {
      //Get.offAll(()=> AdminNavigationBar());
      //print("User isssssssssssssssssssssss ${user}");
      Get.offAll(() => const OnBoarding());
    } else if (user.emailVerified) {
      //print("++++++++++++++++++++++++++++++++++++++++${sellerrepo.getApprovalStatus(user.uid).toString()}+++++++++++++++++++++++++++++++++");
      //checks if the user is customer

      if (await customerrepo.getCustomer(user.email.toString()) ==
          user.email.toString()) {
        //print("ccccustomer sadasdsdasasdsdadsasadsasda");
        //Get.offAll(() => const CustomerScreen());
        Get.offAll(()=>const CustomerNavigationBar());
      } else {
        Get.offAll(() => CustomerLoginPage());

      }
    } else {
      Get.offAll(() => const CustomerMailVerification());
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password,
      CustomerModel customer) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      customer.id = (await _auth.currentUser?.uid)!;



      //if(firebaseUser.value!.emailVerified){
        customerrepo.createUser(customer);

      //}

      firebaseUser.value != null
          ? Get.offAll(() => OnBoarding())

            : Get.to(() =>CustomerNavigationBar() );
      return true;
    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);
      Get.snackbar(e.code, ex.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white);
      return false ;


    } catch (_) {
     return false;

    }
  }

  Future<bool> loginUserWithEmailAndPassword(String email,
      String password) async {
    try {
      String emailformdb = (await customerrepo.getCustomer(email));
      //print("Email from customerrepo ${emailformdb}");
      if (email == emailformdb) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return true;
      } else {
        Get.snackbar(
            "User Not Found", "User the the provided Email doesn't exists",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);
      Get.snackbar(e.code, ex.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white);

      // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      return false;
      throw ex;

      // TODO
    } catch (_) {
      return false;
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      //print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      //throw ex;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      print(
          "+++++++++++++++++++++++++++++++++1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print(
          "+++++++++++++++++++++++++++++++++2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      print(
          "+++++++++++++++++++++++++++++++++3 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      print(
          "+++++++++++++++++++++++++++++++++4 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
      final ex = Exceptions.code(e.code);
      throw ex.message;
      // TODO
    } catch (_) {
      const ex = Exceptions();
      throw ex.message;
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


  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);
      throw ex.message;
      // TODO
    }
    catch (_) {
      const ex = Exceptions();
      throw ex.message;
    }
    }
}

