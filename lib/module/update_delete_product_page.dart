import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/methods.dart';
import 'package:product_management/database/database_service.dart';
import 'package:product_management/dialogs/delete_alert_dialog.dart';
import 'package:product_management/model/product_model.dart';
import 'package:product_management/module/add_product_page.dart';
import 'package:product_management/themes/my_colors.dart';

class UpdateDeleteProductPage extends StatefulWidget {

  @override
  _UpdateDeleteProductPageState createState() =>
      _UpdateDeleteProductPageState();
}

class _UpdateDeleteProductPageState extends State<UpdateDeleteProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update / Delete',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: DataBaseService.getProducts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot) {
            print('future');
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(MyColors.accent),),
              );
            }else if (snapshot.data.length == 0) {
              print('empty list');
              return Center(
                  child: Text(
                'No Products',
                style: TextStyle(color: MyColors.accent),
              ));
            }else {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var _data = snapshot.data[index];
                  return _buildItemList(_data);
                },
                itemCount: snapshot.data.length,
              );
            }
          },
        )
    );
  }

  Widget _buildItemList(ProductModel productModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: MyColors.lightBlue),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(productModel.imgPath),
            width: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  style: TextStyle(
                      color: MyColors.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  productModel.description,
                  style: TextStyle(color: MyColors.accent),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rs ${productModel.price}',
                  style: TextStyle(color: MyColors.accent),
                ),
                Text(
                  'qty ${productModel.quantity}',
                  style: TextStyle(color: MyColors.accent),
                ),
              ],
            ),
          ),
          FlatButton(
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                navigateTo(context,AddProductPage(forEdit: true,productModel: productModel,)).then((value){
                  if(value != null && value == 'update'){
                    setState(() {});
                  }
                });
              },
              height: 40,
              minWidth: 40,
              color: MyColors.lightBlue,
              child: Icon(
                Icons.edit,
                color: MyColors.accent,
              )),
          SizedBox(
            width: 10,
          ),
          FlatButton(
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: (){
                _onDeleteTap(productModel.id);
              },
              height: 40,
              minWidth: 40,
              color: MyColors.lightBlue,
              child: Icon(
                Icons.delete,
                color: MyColors.accent,
              )),
        ],
      ),
    );
  }

  void _onDeleteTap(int id) {
    showDialog(context: context, builder: (context) => DeleteAlertDialog(id: id,)).then((value){
      if(value != null && value == 'success'){
        setState(() {});
      }
    });
  }
}
