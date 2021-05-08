class ProductModel {
   int id;
   String name;
   String description;
   String price;
   String quantity;
   String imgPath;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.imgPath});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'quantity': this.quantity,
      'image': this.imgPath
    };
  }
}