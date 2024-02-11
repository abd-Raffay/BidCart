import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:flutter/material.dart';

class CustomerExploreScreen extends StatefulWidget {
  const CustomerExploreScreen({super.key});

  @override
  State<CustomerExploreScreen> createState() => _CustomerExploreScreenState();
}

class _CustomerExploreScreenState extends State<CustomerExploreScreen> {
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
                  const Text("Explore Screen in Progress ... "),
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
