import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_management/database/database_service.dart';
import 'package:product_management/model/product_model.dart';
import 'package:product_management/themes/my_colors.dart';

class ViewProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: DataBaseService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  style: TextStyle(color: MyColors.accent, fontSize: 18,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8,),
                Text(
                  productModel.description,
                  style: TextStyle(color: MyColors.accent),
                ),
                SizedBox(height: 5,),
                Text(
                  'Rs ${productModel.price}',
                  style: TextStyle(color: MyColors.accent),
                ),
              ],
            ),
          ),
          Text(
            'qty ${productModel.quantity}',
            style: TextStyle(color: MyColors.accent),
          ),
        ],
      ),
    );
  }
}
