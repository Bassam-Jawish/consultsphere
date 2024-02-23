import 'package:consultsphere/config/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../config/theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.onFieldSubmitted,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
  }) : super(
    key: key,
  );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final ValueChanged<String>? onFieldSubmitted;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final AutovalidateMode? autoValidateMode;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: textFormFieldWidget(context),
    )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
    width: width ?? double.maxFinite,
    child: TextFormField(
      autovalidateMode: autoValidateMode,
      scrollPadding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      autofocus: autofocus!,
      style: textStyle ?? Styles.textStyle16,
      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      decoration: decoration,
      validator: validator,
    ),
  );
  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle ?? Styles.textStyle20,
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints,
    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 18.h),
    fillColor: fillColor,
    filled: filled,
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(
            color: AppColor.secondaryLight2,
            width: 1,
          ),
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(
            color: AppColor.secondaryLight2,
            width: 1,
          ),
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.h),
          borderSide: const BorderSide(
            color: AppColor.primaryLight,
            width: 1,
          ),
        ),
  );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static UnderlineInputBorder get underLineGray => const UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.secondaryLight2,
    ),
  );
  static OutlineInputBorder get outlineGrayTL8 => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: const BorderSide(
      color: AppColor.secondaryLight2,
      width: 1,
    ),
  );
}

Widget defInternationalPhoneNumberInput(
    {required TextEditingController controller,
      required FocusNode focusNode,
      void Function (PhoneNumber)? onInputChanged,
      TextInputType? keyboardType,
      String? labelText,
      TextStyle? labelStyle,
      String? labelTextSearch,
      TextStyle? labelStyleSearch,
      Widget? prefix,
      var maxLengthEnforcement,
      FormFieldValidator<String>? validator,
      AutovalidateMode? autoValidateMode,
      Function()? onPressedSuffix,
      Widget? suffix,
      bool obscureText = false,
      ValueChanged<String>? onFieldSubmitted,
      ValueChanged<String>? onChanged,
      GestureTapCallback? onTap,
      double radius = 0.0,
      Color? cursorColor,
      int? maxLength,
      int maxLines = 1,
      Color borderColor = AppColor.gray500,
      Color borderColorOnFocus = AppColor.borderLightOnFocus,
      key}) =>
    InternationalPhoneNumberInput(
        selectorButtonOnErrorPadding: 10.h,
      onInputChanged: onInputChanged,
      initialValue: PhoneNumber(isoCode: 'SY'),
      textFieldController: controller,
      focusNode: focusNode,
      spaceBetweenSelectorAndTextField: 5.w,
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        useBottomSheetSafeArea: true,
        leadingPadding: 10.w,
      ),
      ignoreBlank: false,
      formatInput: true,
      keyboardType:
      const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        counterText: "",
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColorOnFocus),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        prefix: prefix,
        suffixIcon: suffix,
        labelText: labelText,
        labelStyle: labelStyle,
        floatingLabelStyle: const TextStyle(color: AppColor.primaryLight),
      ),
      searchBoxDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
        counterText: "",
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColorOnFocus),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        prefix: prefix,
        suffixIcon: suffix,
        labelText: labelTextSearch,
        labelStyle: labelStyleSearch,
        floatingLabelStyle: const TextStyle(color: AppColor.primaryLight),
      ),
    );

