import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/database/database_service.dart';
import 'package:product_management/themes/my_colors.dart';

class DeleteAlertDialog extends StatelessWidget {
  final int id;

  const DeleteAlertDialog({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Alert',
        style: TextStyle(color: MyColors.accent,fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Are you sure you want to delete this item',
        textAlign: TextAlign.center,
        style: TextStyle(color: MyColors.accent,fontWeight: FontWeight.w500),
      ),
      actions: [
        TextButton(onPressed: (){
          DataBaseService.deleteProducts(id).then((value){
            Navigator.pop(context,'success');
          });
        }, child: Text('Confirm',style: TextStyle(color: MyColors.accent),)),
        TextButton(onPressed: ()async{
          Navigator.pop(context);
        }, child: Text('Cancel',style: TextStyle(color: MyColors.accent),)),
      ],
    );
  }
}
