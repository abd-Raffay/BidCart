import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
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
        titleTextStyle: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100,color: Colors.black,fontFamily: "Preahvihear",
        ),

        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () {

                Get.back();
                //print("I m pressed");
                //print("Current Route ${Get.currentRoute}");
                }, icon: const Icon(Icons.arrow_back))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                : null,
        title: title,
        actions: actions,


      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
