import 'package:bidcart/repository/authentication/seller_authentication_repository.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:flutter/material.dart';

class SellerRequestScreen extends StatefulWidget {
  const SellerRequestScreen({super.key});

  @override
  State<SellerRequestScreen> createState() => _SellerRequestScreenState();
}

class _SellerRequestScreenState extends State<SellerRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Requests Screen is in Progress ... "),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          SellerAuthenticationRepository.instance.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OnBoarding()));
                        },
                        child: const Text("Logout")),
                  ),
                ])),
      ),
    );
  }
}
