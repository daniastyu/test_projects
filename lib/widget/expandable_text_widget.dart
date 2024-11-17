import 'package:delivery_app/utils/Colors.dart';
import 'package:delivery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secoundHalf;

  bool hiddenText = true;
  double textHeight = 100;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length> textHeight){
      //we need to spilit text into 2 part
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secoundHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }
    else{
      firstHalf = widget.text;
      secoundHalf = "";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: secoundHalf.isEmpty?SmallText(text: firstHalf,color: AppColors.paraColor,size: 16,height: 1.6,): Column(
        children: [
          SmallText(text: hiddenText?(firstHalf + "..."):(firstHalf+secoundHalf),color: AppColors.paraColor,size: 16,height: 1.6,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: "Show more", color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down: Icons.arrow_drop_up, color: AppColors.mainColor,),
              ],
            ),
          )

        ],
      ),
    );
  }
}
