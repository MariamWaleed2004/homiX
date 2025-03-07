import 'package:flutter/material.dart';



class ButtonContainerWidget extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTapListener;
  final Widget? child;
  const ButtonContainerWidget({Key? key, this.color, this.child, this.onTapListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapListener,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3)
        ),
        child: Center(child: child),
      ),
    );
  }
}