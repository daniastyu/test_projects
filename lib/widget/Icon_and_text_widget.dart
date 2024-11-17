import 'package:delivery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double sizeicon;
  final Color iconcolor;
  const IconAndTextWidget({super.key, required this.icon, required this.text,  required this.iconcolor, required this.sizeicon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconcolor, size: sizeicon,),
        SizedBox(width: 5,),
        SmallText(text: text,)
      ],
    );
  }
}
