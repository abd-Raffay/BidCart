import 'package:bidcart/repository/authentication/customer_authentication_repository.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:flutter/material.dart';
class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Seller Home Screen')),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
      ),
      body: Container(
          child: ElevatedButton(onPressed: (){
            CustomerAuthenticationRepository.instance.logout();
            Navigator.push(context,MaterialPageRoute(builder: (context) =>OnBoarding()));
          },
              child: Text("Press me"))





      ),
    );
  }
}
