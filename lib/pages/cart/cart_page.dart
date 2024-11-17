import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:delivery_app/utils/app_constains.dart';
import 'package:delivery_app/widget/app_icon.dart';
import 'package:delivery_app/widget/big_text.dart';
import 'package:delivery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60, left: 20, right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(icon: Icons.arrow_back_ios,iconcolor: Colors.white,size:40, backgroundcolor: AppColors.mainColor, ),
              SizedBox(width: 60,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getInitial);
                  //Get.to(()=>MainFoodPage());
                },
                  child: AppIcon(icon: Icons.home_outlined,iconcolor: Colors.white,size: 40, backgroundcolor: AppColors.mainColor, )),
              AppIcon(icon: Icons.shopping_cart,iconcolor: Colors.white,size: 40, backgroundcolor: AppColors.mainColor, )
            ],
          )),
          Positioned(
            top:100, left: 20, right: 20, bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                //color: Colors.red,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child:GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return  ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_,index){
                          return Container(
                            width: double.maxFinite,
                            height: 120,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    var populrIndex = Get.find<PopularProductController>().PopularProductList.indexOf(_cartList[index].product);
                                    if(populrIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularFood(populrIndex));
                                    }
                                    else{
                                      var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex));

                                    }
                                  },
                                  child: Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+_cartList[index].img!)
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ) ,),
                                SizedBox(width: 10,),
                                Expanded(child: Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: _cartList[index].name!, color: Colors.black,),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: _cartList[index].price.toString(), color: Colors.black,),
                                          Container(
                                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      cartController.addItem(_cartList[index].product!, -1);
                                                    },
                                                    child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                SizedBox(width: 5,),
                                                BigText(text:_cartList[index].quantitiy!.toString()), //popularProduct.inCartItems.toString()),
                                                SizedBox(width: 5,),
                                                GestureDetector(
                                                    onTap: (){
                                                      cartController.addItem(_cartList[index].product!, 1);
                                                    },
                                                    child: Icon(Icons.add, color: AppColors.signColor,)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                )),
                              ],
                            ),
                          );
                        });
                  },)

                ),
              ))

        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartcontroller){
        return Container(
          height: 100,
          padding: EdgeInsets.only(top:30, bottom: 30,left: 20, right: 20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5,),
                    BigText(text: "\$  "+cartcontroller.totalPrice.toString()),
                    SizedBox(width: 5,),

                  ],
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: (){
                   // popularProduct.addItemp(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(text: "Check out"),
                  ),
                ),
              )

            ],
          ),
        );
      },),
    );
  }
}
