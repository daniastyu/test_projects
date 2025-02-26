import 'package:delivery_app/modeles/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantitiy;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantitiy,
        this.isExist,
        this.time,
        this.product
       });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantitiy = json['quantitiy'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "quantitiy": this.quantitiy,
      "isExist":this.isExist,
      "time":this.time,
      "product":this.product?.toJson(),
    };


  }
}