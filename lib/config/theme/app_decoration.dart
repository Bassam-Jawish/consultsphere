import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class AppDecoration {
  // Gradient decorations
  static Gradient get gradientIntroDecoration => const LinearGradient(
          colors: [
            Color(0xFF421297),
            Color(0xFFAC84F1),
          ],
        );

  // PinTheme

  static PinTheme get defaultPinTheme => PinTheme(
        width: 56.w,
        height: 56.h,
        textStyle: Styles.textStyle18.copyWith(color: Colors.black),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.gray500),
          borderRadius: BorderRadius.circular(20.r),
        ),
      );

  static PinTheme get focusedPinTheme => PinTheme(
    width: 56.w,
    height: 56.h,
    textStyle: Styles.textStyle18.copyWith(color: Colors.black),
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.primaryLight),
      borderRadius: BorderRadius.circular(20.r),
    ),
  );

  static PinTheme get submittedPinTheme => PinTheme(
    width: 56.w,
    height: 56.h,
    textStyle: Styles.textStyle18.copyWith(color: Colors.black),
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.primaryLight),
      borderRadius: BorderRadius.circular(20.r),
    ),
  );
}
