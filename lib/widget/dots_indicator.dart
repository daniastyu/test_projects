import 'package:flutter/material.dart';

class SmoothDotsIndicator extends StatelessWidget {
  final int count;
  final double position;
  final Color activeColor;
  final Color inactiveColor;

  const SmoothDotsIndicator({
    Key? key,
    required this.count,
    required this.position,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        double opacity = index == position.floor()
            ? 1.0 - (position - index)
            : (index == position.floor() + 1)
            ? position - index + 1
            : 0.0;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: opacity > 0.5 ? 18.0 : 9.0,
          height: 9.0,
          decoration: BoxDecoration(
            color: Color.lerp(inactiveColor, activeColor, opacity),
            borderRadius: BorderRadius.circular(5.0),
          ),
        );
      }),
    );
  }
}
