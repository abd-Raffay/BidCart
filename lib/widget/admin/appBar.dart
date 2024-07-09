import 'package:bidcart/screens/common/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({
    Key? key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  }) : super(key: key);

  final Widget? title;
  final bool showBackArrow;
  final String? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {

    void logout() {
      Get.offAll(()=> OnBoarding());
    }

    List<Widget> updatedActions = [...actions ?? []];

    // Add a logout button to actions
    updatedActions.add(
      IconButton(
        onPressed: logout,
        icon: Icon(Icons.logout),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black.withOpacity(0),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        )
            : leadingIcon != null
            ? Image.asset(
          leadingIcon!,
          width: 54, // Adjust the width as needed
          height: 54, // Adjust the height as needed
        )
            : null,
        title: title,
        actions: updatedActions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
