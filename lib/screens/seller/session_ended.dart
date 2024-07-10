import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionMonitor extends StatefulWidget {
  @override
  _SessionMonitorState createState() => _SessionMonitorState();
}

class _SessionMonitorState extends State<SessionMonitor> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("Session IS SALDKJASLDJASKDJASLKDJALSKDJLASKDJLASKDJLASKDJ");
      FirebaseFirestore.instance
          .collection('seller')
          .doc(user.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.data()?['Status'] == "blocked") {
          // Sign out the user
          FirebaseAuth.instance.signOut();
          // Navigate to login screen or show message
         Get.offAll(()=>SLoginPage());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}