import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_colors.dart';

class CustomField extends StatelessWidget {
  Widget? prefixIcon;
  Widget? suffixIcon;
  String hintTxt;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool obscureText ;
  void Function(String)? onChanged;
  void Function()? onTap;
  final String? Function(String?)? validator;
  CustomField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintTxt,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        cursorColor: AppColors.grey,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.grey
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.grey,width: 1.5)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.red,width: 1.5)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10 ),
              borderSide: BorderSide(color: AppColors.red,width: 1.5)
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintTxt,
          filled: false,
          isDense: false,
        ),
      ),
    );
  }
}
