import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/modeles/product_model.dart';
import 'package:delivery_app/pages/food/popular_food_detail.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:delivery_app/utils/Colors.dart';
import 'package:delivery_app/utils/app_constains.dart';
import 'package:delivery_app/widget/Icon_and_text_widget.dart';
import 'package:delivery_app/widget/big_text.dart';
import 'package:delivery_app/widget/dots_indicator.dart';
import 'package:delivery_app/widget/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currentpagevalue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentpagevalue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Slider
           GetBuilder<PopularProductController>(builder:(popularProducts) {
             return popularProducts.isloded? Container(
               height: 320,
                 child: PageView.builder(
                   controller: pageController,
                   itemCount: popularProducts.PopularProductList.length,
                   itemBuilder: (context, position) {
                     return _buildPageItem(position, popularProducts.PopularProductList[position]);
                   },

               ),
             ): CircularProgressIndicator(color: AppColors.mainColor,);
                       }),
          // Dots Indicator
          GetBuilder<PopularProductController>(builder: (popularProducts){
            return SmoothDotsIndicator(
              count: popularProducts.PopularProductList.isEmpty?1:popularProducts.PopularProductList.length,
              position: _currentpagevalue,
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
            );
          }),

          // Popular Text
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food pairing"),
                ),
              ],
            ),
          ),
          // List of Food and Images
          GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            return recommendedProduct.isloded?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    //print('Index: $index  ddddddddddddddddd');
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: [
                        // Image Container
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:NetworkImage(
                                  AppConstants.BASE_URL+"/uploads/"+ recommendedProduct.recommendedProductList[index].img!),
                            ),// image: NetworkImage(
                             // AppConstants.BASE_URL+"/uploads/"+ popularProduct.img!),
                          ),
                        ),
                        // Text Container
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                  SizedBox(height: 10),
                                  SmallText(text: "With Chinese characteristics"),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                        icon: Icons.circle_sharp,
                                        text: "Normal",
                                        iconcolor: AppColors.iconColor1,
                                        sizeicon: 10,
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.location_on,
                                        text: "1.7 km",
                                        iconcolor: AppColors.mainColor,
                                        sizeicon: 10,
                                      ),
                                      IconAndTextWidget(
                                        icon: Icons.access_time_rounded,
                                        text: "32min",
                                        iconcolor: AppColors.iconColor2,
                                        sizeicon: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ): CircularProgressIndicator(color: AppColors.mainColor,);
          })

        ],
      ),
    );
  }

  Widget _buildPageItem(int index,ProductModel popularProduct) {
    double scale;
    double translationY;

    if (index == _currentpagevalue.floor()) {
      scale = 1 - (_currentpagevalue - index) * (1 - _scaleFactor);
      translationY = _height * (1 - scale) / 2;
    } else if (index == _currentpagevalue.floor() + 1) {
      scale = _scaleFactor +
          (_currentpagevalue - index + 1) * (1 - _scaleFactor);
      translationY = _height * (1 - scale) / 2;
    } else {
      scale = _scaleFactor;
      translationY = _height * (1 - _scaleFactor) / 2;
    }

    return Transform(
      transform: Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, translationY, 0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: 220,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven
                    ? Color(0xFF69c5df)
                    : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.BASE_URL+"/uploads/"+ popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SmallText(text: "4.5"),
                        SizedBox(width: 10),
                        SmallText(text: "1287"),
                        SizedBox(width: 5),
                        SmallText(text: "Comments"),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconcolor: AppColors.iconColor1,
                          sizeicon: 20,
                        ),
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text: "1.7 km",
                          iconcolor: AppColors.mainColor,
                          sizeicon: 20,
                        ),
                        IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconcolor: AppColors.iconColor2,
                          sizeicon: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
