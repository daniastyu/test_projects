import 'dart:async';

import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashScrren extends StatefulWidget {
  const SplashScrren({super.key});

  @override
  State<SplashScrren> createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

Future<void> _loadRecource() async {
 await Get.find<PopularProductController>().getpopularproductList();
 await Get.find<RecommendedProductController>().getrecommendedproductList();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRecource();
    controller = new AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      Duration(seconds: 4),
      ()=> Get.offNamed(RouteHelper.getInitial)
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/logo part 1.png", width: 250,))),
          Center(child: Image.asset("assets/image/logo part 2.png", width: 250,))
        ],
      ),
    );
  }
}
