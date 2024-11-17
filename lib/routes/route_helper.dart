import 'dart:ui';

import 'package:delivery_app/pages/cart/cart_page.dart';
import 'package:delivery_app/pages/food/popular_food_detail.dart';
import 'package:delivery_app/pages/food/recommended_food_detail.dart';
import 'package:delivery_app/pages/home/home_page.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashpage = '$splashPage';
  static String getInitial = '$initial';
  static String getPopularFood(int pageId)=> '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId)=> '$recommendedFood?pageId=$pageId';
  static String getCartPage = '$cartPage';
  //static String getRecommendedFood()=> '$recommendedFood';
  //static String getRecommendedFood(int pageId2)=> '$recommendedFood?pageId2:$pageId2';

  static List<GetPage> routes=[
    GetPage(name: splashPage, page: ()=>SplashScrren()),
    GetPage(name: initial, page:()=> HomePage()),
    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'] ;
      return PopualrFoodDetail(pageId:int.parse(pageId!));
    }, transition: Transition.fadeIn),
    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['pageId'] ;
      return RecommendedFoodDetail(pageId:int.parse(pageId!));
    }, transition: Transition.fadeIn),
    GetPage(name: cartPage, page:()=> CartPage()),
   /* GetPage(name: recommendedFood, page: () {
      var pageId2 = Get.parameters['pageId2'] ;
      return RecommendedFoodDetail(pageId2:int.parse(pageId2!));
    }, transition: Transition.fadeIn),*/
  ];
}