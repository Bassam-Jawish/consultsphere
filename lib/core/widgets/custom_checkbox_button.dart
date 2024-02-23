import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckboxButton extends StatelessWidget {
  CustomCheckboxButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  }) : super(
          key: key,
        );

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  bool? value;

  final Function(bool) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final bool isExpandedText;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildCheckBoxWidget,
          )
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => InkWell(
        onTap: () {
          value = !(value!);
          onChange(value!);
        },
        child: Container(
          decoration: decoration,
          width: width,
          child: (isRightCheck ?? false) ? rightSideCheckbox : leftSideCheckbox,
        ),
      );

  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: checkboxWidget,
          ),
          isExpandedText ? Expanded(child: textWidget) : textWidget,
        ],
      );

  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: checkboxWidget,
          ),
        ],
      );

  Widget get textWidget => RichText(
        text: TextSpan(
          style: Styles.textStyle14
              .copyWith(color: AppColor.gray600, fontWeight: FontWeight.w400),
          children: [
            const TextSpan(
              text: 'I agree to ConsultSphere ',
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: Styles.textStyle14.copyWith(color: AppColor.primaryLight,fontWeight: FontWeight.w500),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //_launchURL('https://yourprivacylink.com');
                },
            ),
            TextSpan(
              text: ' and ',
              style: Styles.textStyle14
                  .copyWith(color: AppColor.gray600, fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: 'Terms of Use',
              style: Styles.textStyle14.copyWith(color: AppColor.primaryLight,fontWeight: FontWeight.w500),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // _launchURL('https://yourtermsofuselink.com');
                },
            ),
          ],
        ),
      );

  Widget get checkboxWidget => SizedBox(
        height: iconSize ?? 24.h,
        width: iconSize ?? 24.w,
        child: Checkbox(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? false,
          checkColor: Colors.white,
          onChanged: (value) {
            onChange(value!);
          },
        ),
      );
}
