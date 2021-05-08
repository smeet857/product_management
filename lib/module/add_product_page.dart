import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_management/common/methods.dart';
import 'package:product_management/database/database_service.dart';
import 'package:product_management/model/product_model.dart';
import 'package:product_management/themes/my_colors.dart';

class AddProductPage extends StatefulWidget {
  final bool forEdit;
  final ProductModel productModel;

  const AddProductPage({Key key, this.forEdit, this.productModel}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  final _productNameCtrl = TextEditingController();
  final _productDescCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();

  final _spaceBetweenTextField = 20.0;
  final _formKey = GlobalKey<FormState>();

  String _imgPath;

  @override
  void initState() {
    if(widget.forEdit){
      _productNameCtrl.text = widget.productModel.name;
      _productDescCtrl.text = widget.productModel.description;
      _priceCtrl.text = widget.productModel.price;
      _qtyCtrl.text = widget.productModel.quantity;
      _imgPath = widget.productModel.imgPath;
    }
    super.initState();
  }

  @override
  void dispose() {
    _productNameCtrl.dispose();
    _productDescCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: _buildSaveButton(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _textField(title: 'Product Name', controller: _productNameCtrl),
                SizedBox(height: _spaceBetweenTextField,),
                _textField(
                    title: 'Product Description', controller: _productDescCtrl),
                SizedBox(height: _spaceBetweenTextField,),
                _textField(title: 'Price', controller: _priceCtrl),
                SizedBox(height: _spaceBetweenTextField,),
                _textField(title: 'Quantity', controller: _qtyCtrl),
                SizedBox(height: _spaceBetweenTextField,),
                _buildUploadImage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({String title, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (value){
        switch(title){

          case 'Product Name':
            if(value.isEmpty){
              return 'Please enter product name';
            }
            return null;
          case 'Product Description':
            if(value.isEmpty){
              return 'Please enter product description';
            }
            return null;
          case 'Price':
            if(value.isEmpty){
              return 'Please enter product price';
            }
            return null;
          case 'Quantity':
            if(value.isEmpty){
              return 'Please enter product quantity';
            }
            return null;
          default:
            return null;
        }
      },
      keyboardType: title == 'Price' ? TextInputType.number : TextInputType.text ,
      decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
  }

  Widget _buildUploadImage() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColors.accent, width: 1)
        ),
        child: _imgPath == null ? FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: MyColors.accent.withOpacity(0.1),
          onPressed: _pickImage, child: Column(
          children: [
            Icon(Icons.upload_outlined, color: MyColors.accent, size: 40,),
            SizedBox(height: 5,),
            Text('Upload Image',
              style: TextStyle(color: MyColors.accent, fontSize: 20),)
          ],
        ),
        ) : GestureDetector(
          onTap: _pickImage,
            child: Image.file(File(_imgPath),fit: BoxFit.cover,))

    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FlatButton(
          onPressed: _onSaveTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          color: MyColors.accent,
          child: Text(widget.forEdit ? 'Update info':'Save Info', style: TextStyle(color: Colors.white,fontSize: 15),)),
    );
  }

  void _pickImage()async{
    var _file = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if(_file != null){
     setState(() {
       _imgPath = _file.path;
     });
    }
  }

  void _onSaveTap(){
    var _result = true;

    if(_imgPath == null){
      toast('Please select image');
      _result = false;
    }
    if(!_formKey.currentState.validate()){
      _result = false;
    }

    print(_result);
    if(_result){
      print('name : ${_productNameCtrl.text}');

      if(widget.forEdit){
        widget.productModel.name = _productNameCtrl.text;
        widget.productModel.description = _productDescCtrl.text;
        widget.productModel.price = _priceCtrl.text;
        widget.productModel.quantity = _qtyCtrl.text;
        widget.productModel.imgPath = _imgPath;

        print('update');
        DataBaseService.updateProducts(widget.productModel).then((value){
          Navigator.pop(context,'update');
        });
      }else{
        print('add');
        var _p = ProductModel(
            id: DateTime.now().millisecondsSinceEpoch,
            name: _productNameCtrl.text,
            description: _productDescCtrl.text,
            price: _priceCtrl.text,
            quantity: _qtyCtrl.text,
            imgPath: _imgPath
        );
        DataBaseService.insertProduct(_p).then((value){
          Navigator.pop(context);
        });
      }
    }
  }
}
