import 'package:bidcart/repository/exception/exceptions.dart';
import 'package:bidcart/screens/customer/homescreen.dart';
import 'package:bidcart/screens/customer/login.dart';
import 'package:bidcart/screens/mail_verfication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;


  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    //setIntialScreen(firebaseUser.value);
    ever(firebaseUser, setIntialScreen);
  }

  setIntialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginPage())
        :Get.offAll(() => const CustomerScreen());
        //:Get.offAll(()=>MailVerification());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("firebase uuser value ${firebaseUser.value}");

      firebaseUser.value != null
          ? Get.offAll(() => const CustomerScreen())
          : Get.to(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      final ex = Exceptions.code(e.code);

      print('FIREBASE AUTH EXCEPTION - ${e.code}');
      throw ex;
    } catch (_) {
      const ex = Exceptions();
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      //final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      // throw ex;

      // TODO
    } catch (_) {
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      //print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      //throw ex;
    }
  }

  Future<UserCredential?>signInWithGoogle()async{
    try {
      print("heeeeeeeeeeeeeee");
      final GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );
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
      // TODO
    } catch (_) {
      const ex = Exceptions();
      throw ex.message;
    }
  }
}
