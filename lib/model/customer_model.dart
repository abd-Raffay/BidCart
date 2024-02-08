

class CustomerModel{
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phone;


  const CustomerModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
});
  toJson(){
    return{
      "Name":name,
      "Email":email,
      "Password":password,
      "Phone":phone,
    };
  }
}