import 'package:delivery_app/utils/Colors.dart';
import 'package:delivery_app/widget/Icon_and_text_widget.dart';
import 'package:delivery_app/widget/big_text.dart';
import 'package:delivery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  String text;
  AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text),
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
    );
  }
}
