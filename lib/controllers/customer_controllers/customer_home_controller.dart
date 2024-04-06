
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/repository/customer_repository/customer_home_repository.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';

class CustomerHomeController extends GetxController{
  static CustomerHomeController get instance => Get.find();

  final homeRepo = Get.put(CustomerHomeRepository());
  //final cartController =Get.put(CartController());
  @override
  Future<void> onInit() async {
    await getProducts();
    super.onInit();
    index = 0;
  }



  int index = 0;

  final carousalCurrentIndex=0.obs;
  late Future<List<ProductModel>> productList;
  List products = [];

  void updatePageIndicator(index){
    carousalCurrentIndex.value=index;
    //getProducts();

  }
  Future<void> setIndex(int indexx) async {
    index = indexx;
  }



  setList(){
    return productList;
  }

  Future<List<ProductModel>> getProducts()  async {
    productList=homeRepo.getProducts();
    products= await productList;
      return productList;
  }



}