import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel{
   String id;
  final String name;
  final String email;
  //final String password;
  final String phone;

   CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    //required this.password,
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
      //"Password": password,
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
    //password: data["Password"],
    phone: data["Phone"],
  );
  }
}
