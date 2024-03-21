
import 'package:bidcart/repository/customer_repository/customer_home_repository.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';

class CustomerHomeController extends GetxController{
  static CustomerHomeController get instance => Get.find();

  final homeRepo = Get.put(CustomerHomeRepository());
  @override
  void onInit() {
    super.onInit();
    index = 0;
    //print("indexsadasdasdasdasdasdds ${index}");
    //getProductsList();
  }



  int index = 0;


  final carousalCurrentIndex=0.obs;
  late Future<List<ProductModel>> productList ;
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