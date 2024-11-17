import 'dart:ffi';

import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/data/repository/popular_producr_repo.dart';
import 'package:delivery_app/modeles/cart_model.dart';
import 'package:delivery_app/modeles/product_model.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _PopularProductList = [];
  List<dynamic> get PopularProductList => _PopularProductList;
  late CartController _cart;

  bool _isloded = false;
  bool get isloded => _isloded;
  int _quantitiy = 0;
  int get quantitiy=>_quantitiy;

  int _inCartItems = 0;
  int get inCartItems=>_inCartItems+_quantitiy;

  Future<void> getpopularproductList() async{
    Response response =await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _PopularProductList = [];
      _PopularProductList.addAll(Product.fromJson(response.body).products);
      _isloded = true;
      update();
    }else{

    }
  }

  void setQuntitiy(bool isIncrement){
    if(isIncrement){
      _quantitiy = checkQuantity(_quantitiy+1);
    }else{
      _quantitiy = checkQuantity(_quantitiy-1);
    }
    //checkQuantity(_quantitiy);
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You Can't reduce more !",
          backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      //u should return to here;
      if(_inCartItems>0){
        _quantitiy = _inCartItems;
        return _quantitiy;
      }
      return 0;}
    else if ((_inCartItems+quantity)>20){
      Get.snackbar("Item count", "You Can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
      }
    else{
      return quantity;
    }

  }

  void initiProduct(ProductModel product,CartController cart){
    _quantitiy= 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if(exist){
      _inCartItems = _cart.getQuantitiy(product);
    }
  }

 void addItemp(ProductModel product){
    _cart.addItem(product , _quantitiy);
    _quantitiy =0;
    _inCartItems = _cart.getQuantitiy(product);
    _cart.items.forEach((key, value) {
      print("the id is "+ value.id.toString() +"And the quantity is"+ value.quantitiy!.toString());
    });

    update();
 }

 int get totalItems{
    return _cart.TotalItems;
 }
 List<CartModel> get getItems{
    return _cart.getItems;
 }

}