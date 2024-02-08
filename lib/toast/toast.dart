import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';


LoadingToast(context) async {
  MotionToast toast = MotionToast(
    primaryColor: Colors.cyan,

    icon: Icons.rotate_left,
    title: Text(
      'Loading ...',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),

    description: Text(
      'Please wait', style: TextStyle(fontSize: 12),
    ),
    layoutOrientation: ToastOrientation.ltr,
    animationType: AnimationType.fromTop,
    dismissable: true,
    height: 80,
    width: 300,
    position: MotionToastPosition.top,
  );
  toast.show(context);

  Future.delayed(const Duration(seconds: 0)).then((value) {
   // toast.dismiss();
  });

}

SuccessToast (context,title,description) async{
  MotionToast.success(
      title:Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
      description:Text( description),
      layoutOrientation: ToastOrientation.ltr,
      animationType: AnimationType.fromTop,
      dismissable: true,
      height: 80,
      width: 300,
      position: MotionToastPosition.top,
      ).show(context);
}

void ErrorToast(context,title,description){
  MotionToast.error(
    title:Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
    description:Text( description),
    layoutOrientation: ToastOrientation.ltr,
    animationType: AnimationType.fromTop,
    dismissable: true,
    height: 80,
    width: 300,
    position: MotionToastPosition.top,
  ).show(context);
}