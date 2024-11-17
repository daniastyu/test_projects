import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/data/repository/cart_repo.dart';
import 'package:delivery_app/data/repository/popular_producr_repo.dart';
import 'package:delivery_app/data/repository/recommended_product_repo.dart';
import 'package:delivery_app/utils/app_constains.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> init()async {
  final sharedperferences = await SharedPreferences.getInstance();
  Get.lazyPut(()=> sharedperferences);
  //apiclienthttps://mvs.bslmeiyu.com
  Get.lazyPut(()=> ApiClient(appBaseUrl:AppConstants.BASE_URL));
  //apiClient.updateToken("hardcoded_token_for_testing");
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepo(sharedPreferences:Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));


}