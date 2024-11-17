import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/pages/cart/cart_page.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:delivery_app/utils/app_constains.dart';
import 'package:delivery_app/widget/Icon_and_text_widget.dart';
import 'package:delivery_app/widget/app_icon.dart';
import 'package:delivery_app/widget/big_text.dart';
import 'package:delivery_app/widget/expandable_text_widget.dart';
import 'package:delivery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widget/app_column.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PopualrFoodDetail extends StatelessWidget {
  int pageId;
  PopualrFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().PopularProductList[pageId];
    Get.find<PopularProductController>().initiProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+product.img!)),
                ),
              )),
          Positioned(
            top: 45,
            right: 20, left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap:(){
                    Get.to(()=> MainFoodPage());
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios)),
             GetBuilder<PopularProductController>(builder: (controller){
               return GestureDetector(
                 onTap: (){
                   if(controller.totalItems>=1)
                   Get.toNamed(RouteHelper.getCartPage);
                 },
                 child: Stack(
                   children: [
                     AppIcon(icon: Icons.shopping_cart_outlined),
                     controller.totalItems>=1?
                     Positioned(
                         right:0, top:0,
                         child: AppIcon(icon: Icons.circle, size: 20, iconcolor: Colors.transparent, backgroundcolor: AppColors.mainColor,)):
                     Container(),
                     controller.totalItems>=1?
                     Positioned(
                         right:5, top:1,
                         child:BigText(text: controller.totalItems.toString(),
                           size: 12,color: Colors.white, )):Container(),
                   ],
                 ),
               );
             })
             // AppIcon(icon: Icons.shopping_cart_outlined)
            ],
          )),
          Positioned(
            left: 0, right: 0, top:290, bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text : product.name!),
                    SizedBox(height: 20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: 10,),
                    Expanded(child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!),
                    ))

                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
                    GestureDetector(
                      onTap:(){
                        popularProduct.setQuntitiy(false);
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: 5,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: 5,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuntitiy(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor,)),
                  ],
                ),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: (){
                    popularProduct.addItemp(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor,
                    ),
                        child: BigText(text: "\$${product.price!} | Add to cart"),
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
