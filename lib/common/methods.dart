
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> navigateTo(BuildContext context ,Widget widget)async{
  return await Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

toast(String message){
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      timeInSecForIosWeb: 2,
      textColor: Colors.black,
      gravity: ToastGravity.CENTER
  );
}
