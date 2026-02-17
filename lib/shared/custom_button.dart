import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  Widget? child;
  Color? backgroundColor;
  CustomButton({super.key,required this.onPressed,required this.child,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 18,horizontal: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            backgroundColor: backgroundColor
        ),
        child: child,
      ),
    );
  }
}
