import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
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
                  const Text("Home Screen in Progress ... "),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          CustomerAuthenticationRepository.instance.logout();
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
