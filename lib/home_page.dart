import 'package:flutter/material.dart';
import 'package:product_management/database/database_service.dart';
import 'package:product_management/module/add_product_page.dart';
import 'package:product_management/themes/my_colors.dart';

import 'common/methods.dart';
import 'module/update_delete_product_page.dart';
import 'module/view_products_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    DataBaseService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Management',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    height: 140,
                      color: MyColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: _onAddProductTap,
                      child: Text(
                        'Add Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: FlatButton(
                      height: 140,
                      color: MyColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: _onUDProductTap,
                      child: Text(
                        'Update/Delete\nProduct',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
            SizedBox(height: 20,),
            FlatButton(
                height: 140,
                minWidth: double.infinity,
                color: MyColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: _onViewProductTap,
                child: Text(
                  'View Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  void _onAddProductTap(){
    navigateTo(context,AddProductPage(forEdit: false,));
  }

  void _onUDProductTap(){
    navigateTo(context,UpdateDeleteProductPage());
  }

  void _onViewProductTap(){
    navigateTo(context,ViewProductsPage());
  }
}
