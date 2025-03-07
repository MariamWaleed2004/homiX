
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {

  final Function(bool) onChanged;

  const CheckBoxWidget({super.key, required this.onChanged});

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false; 

  @override
  Widget build(BuildContext context) {
    return Checkbox(
          value: isChecked,
          checkColor: Colors.white,
          activeColor: Colors.black,
          visualDensity: VisualDensity.compact,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onChanged(isChecked);
          },
        );
    

  }
}