import 'package:bin_yousuf_driver/core/constants/colors.dart';
import 'package:bin_yousuf_driver/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.validator,
    this.onChanged,
    this.onTap,
    required this.keyboardType,
    required this.controller,
    this.hintext,
    this.labeltext,
    this.maxlines,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.isRequired,
    required this.isObscure,
    this.borderColor,
    this.width,
  });
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? labeltext;
  final String? hintext;
  final String? label;
  final int? maxlines;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final bool isRequired;
  final bool isObscure;
  final Color? borderColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labeltext,
          hintText: widget.hintext,
          hintStyle: outfitStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
            color: textGreyColor,
          ),
          contentPadding: EdgeInsets.only(left: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: widget.borderColor ?? textGreyColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: widget.borderColor ?? textGreyColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: widget.borderColor ?? textGreyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: mainColor),
          ),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
        autocorrect: false,
        obscureText: widget.isObscure,
        maxLines: widget.maxlines,
        obscuringCharacter: '*',
        textCapitalization: TextCapitalization.none,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
