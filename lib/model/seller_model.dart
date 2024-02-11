import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel {
  String id;
  final String sellername;
  final String phone;
  final String cnic;
  final String email;
  //final String password;
  final String storename;
  final String address;
   String status;

  SellerModel ({
    required this.id,
    required this.sellername,
    required this.phone,
    required this.cnic,
    required this.email,
    //required this.password,
    required this.storename,
    required this.address,
    required this.status,
  });

  setid(String id){
    this.id=id;
  }

  toJson() {
    return {
      "Userid":id,
      "SellerName": sellername,
      "Email": email,
      //"Password": password,
      "Phone": phone,
      "StoreName":storename,
      "Address":address,
      "Status":status,
    };
  }


  //MAP user Fetch  From FIREBASE to Model

  factory SellerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data=document.data()!;

    return SellerModel(
      id:data["Userid"],
      sellername: data["SellerName"],
      email: data["Email"],
      //password: data["Password"],
      phone: data["Phone"],
      cnic:data["CNIC"],
      storename:data["StoreName"],
      address:data["Address"],
        status: data["Status"]
    );
  }
}

