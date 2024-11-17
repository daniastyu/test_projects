import 'dart:convert';

import 'package:delivery_app/modeles/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{

  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart=[];

  void addToCartList(List<CartModel> cartList){
    cart =[];
    // convert object to string because sharedpreferences accept only string
    cartList.forEach((element) {
      cart.add(jsonEncode(element));
    });
   sharedPreferences.setStringList("Cart_List", cart);
   print(sharedPreferences.getStringList("Cart_List"));
    getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey("Cart_List")){
     carts =  sharedPreferences.getStringList("Cart_List")!;
    }
    List<CartModel> cartList =[];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
   }
}