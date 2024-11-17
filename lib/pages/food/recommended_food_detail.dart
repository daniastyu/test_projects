import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/pages/cart/cart_page.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:delivery_app/utils/app_constains.dart';
import 'package:delivery_app/widget/app_icon.dart';
import 'package:delivery_app/widget/big_text.dart';
import 'package:delivery_app/widget/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter/widgets.dart';



class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    // var product = recommendedProductController.recommendedProductList[pageId];
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initiProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial);
                  },
                    child: AppIcon(icon: Icons.clear)),
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
            ),
            bottom:  PreferredSize(preferredSize: Size.fromHeight(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                  ),
                  // color: Colors.white,
                  child: Center(child: BigText(text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top:10, bottom: 10),
                )),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+"/uploads/"+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,),

            ),

          ),
          SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandableTextWidget(text: product.description!,),
                    margin: EdgeInsets.only(left: 20, right: 20),
                  )
                ],
              ) )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top:10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuntitiy(false);
                      },
                      child: AppIcon(iconcolor:Colors.white,backgroundcolor: AppColors.mainColor,icon: Icons.remove)),
                  BigText(text: "\$${product.price!}  X  ${controller.inCartItems} "),
                  GestureDetector(
                      onTap: (){
                        controller.setQuntitiy(true);
                      },
                      child: AppIcon(iconcolor:Colors.white,backgroundcolor: AppColors.mainColor,icon: Icons.add)),
                ],
              ),
            ),
            Container(
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
                    child:
                    Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItemp(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(text: "\$${product.price!} | Add to cart",),
                    ),
                  )

                ],
              ),
            ),
          ],
        );
      },)

    );
  }
}
