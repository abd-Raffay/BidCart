import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel{
   String id;
  final String name;
  final String email;
  final String phone;

   CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  setid(String id){
    this.id=id;
  }

  toJson() {
    return {
      "Userid":id,
      "Name": name,
      "Email": email,
      "Phone": phone,
    };
  }

  //MAP user Fetch  From FIREBASE to Model

  factory CustomerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data=document.data()!;

    return CustomerModel(
    id:data["Userid"],
    name: data["Name"],
    email: data["Email"],
    phone: data["Phone"],
  );
  }
}
