import 'package:bidcart/repository/authentication/authentication_repository.dart';
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
        appBar: AppBar(
          title: Center(child: Text('Customer Home Screen')),
          backgroundColor: Colors.cyan,
          automaticallyImplyLeading: false,
        ),
      body: Container(
        child: ElevatedButton(onPressed: (){
          AuthenticationRepository.instance.logout();
        },
          child: Text("Press me"))





      ),
    );
  }
}
