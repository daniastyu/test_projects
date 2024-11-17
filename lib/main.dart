import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/pages/food/popular_food_detail.dart';
import 'package:delivery_app/pages/food/recommended_food_detail.dart';
import 'package:delivery_app/pages/home/food_page_body.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Get.find<CartController>().getCartData();
   return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RouteHelper.getSplashpage,
          getPages: RouteHelper.routes,//MainFoodPage(),
        );
      });
    },);}
    //Get.find<PopularProductController>().getpopularproductList();
    //Get.find<RecommendedProductController>().getrecommendedproductList();
  /*  return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     /* theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
     // home:MainFoodPage(),
      initialRoute: RouteHelper.getSplashpage,
      getPages: RouteHelper.routes,//MainFoodPage(),
    );
  }*/
}
