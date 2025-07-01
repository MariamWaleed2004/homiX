import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';

class ProfileOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ProfileOptionTile(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: width * 0.04,
              )),
          Icon(Icons.arrow_forward_ios,
              size: width * 0.04, color: Colors.grey[600]),
        ],
      ),
    );
  }
}
