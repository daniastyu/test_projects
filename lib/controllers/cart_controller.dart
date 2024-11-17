import 'package:delivery_app/data/repository/cart_repo.dart';
import 'package:delivery_app/modeles/cart_model.dart';
import 'package:delivery_app/modeles/product_model.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int , CartModel> _items = {};

  Map<int, CartModel> get items => _items;
//only for storage and sharedpreference
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity){
    var totalQuantitiy = 0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantitiy = value.quantitiy!+quantity;
        return CartModel(
            id:value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantitiy: value.quantitiy!+quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
        );
      }
      );
      if(totalQuantitiy<=0){
        _items.remove(product.id);
      }

    }else{
     if(quantity>0){
       _items.putIfAbsent(product.id!, () {
         return CartModel(
             id:product.id,
             name: product.name,
             price: product.price,
             img: product.img,
             quantitiy: quantity,
             isExist: true,
             time: DateTime.now().toString(),
             product: product,
         );
       });
    }else{
       Get.snackbar("Item count", "You Should at least add an item in the cart !",
           backgroundColor: AppColors.mainColor,
           colorText: Colors.white);
    }
  }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else{
      return false;
    }
  }

 int getQuantitiy(ProductModel product){
   var quantity = 0;
    if(_items.containsKey(product.id )){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantitiy!;
        }

      });
    }
    return quantity;
  }

  int get TotalItems{
    var total = 0;
    _items.forEach((key, value) {
      total+= value.quantitiy!;
    });
    return total;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalPrice{
    var total = 0;
    _items.forEach((key, value) {
      total += value.price!*value.quantitiy!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart =  cartRepo.getCartList();//CartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    for(int i=0; i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }
}
