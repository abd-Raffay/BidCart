
import 'package:bidcart/repository/customer_repository/customer_home_repository.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';

class CustomerHomeController extends GetxController{
  static CustomerHomeController get instance => Get.find();

  final homerepo = Get.put(CustomerHomeRepository());

  final carousalCurrentIndex=0.obs;
  late Future<List<ProductModel>> productList ;

  void updatePageIndicator(index){
    carousalCurrentIndex.value=index;
    //getProducts();

  }
  setList(){
    return productList;
  }

  Future<List<ProductModel>> getProducts()  async {
    productList=homerepo.getProducts();
    print(productList);
      return productList;
  }



}