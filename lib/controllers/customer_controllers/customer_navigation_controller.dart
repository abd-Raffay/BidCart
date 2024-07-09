import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../screens/customer/customer_account_screen.dart';
import '../../screens/customer/customer_explore_screen.dart';
import '../../screens/customer/customer_homescreen.dart';
import '../../screens/customer/customer_orderscreen.dart';

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens=[
    const CustomerScreen(),
    const CustomerExploreScreen(),
    const CustomerOrderScreen(),
    const CustomerAccountScreen(),
  ];


  setIndex(int index)
  {

    selectedIndex.value=index.obs();
    print(selectedIndex.value);
  }


}