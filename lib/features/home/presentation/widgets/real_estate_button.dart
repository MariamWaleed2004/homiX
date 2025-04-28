import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homix/core/const.dart';

class RealEstateButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final FaIcon? faIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const RealEstateButton({
    super.key,
    required this.label,
    this.icon,
    this.faIcon,
    required this.isSelected,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isSelected ? Colors.black : Colors.grey[200],
        foregroundColor: isSelected ? Colors.grey[200] : Colors.black,
        side: BorderSide(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          if (icon != null)
          Icon(
          icon,
          color: isSelected ? Colors.grey[200] : Colors.black,),
          SizedBox(width: width * 0.01,),
          Text(label,),
       ]
      ),
    );
  }
}
