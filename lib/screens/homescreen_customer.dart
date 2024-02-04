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
          title: Center(child: Text('User Home Screen')),
          backgroundColor: Colors.cyan,
          automaticallyImplyLeading: false,
        ),
      body: Container(
        child:Text("HI"),
      ),
    );
  }
}
