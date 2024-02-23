import 'package:consultsphere/config/theme/app_decoration.dart';
import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_elevated_button.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchHome() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColor.gray500,
          )),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColor.gray500,
          ),
          SizedBox(
            width: 10.w,
          ),
          const Text('Search experts'),
        ],
      ),
    ),
  );
}

Widget learnMore(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return Container(
    height: 120.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    margin: EdgeInsets.only(right: 20.w,left: 20.w, top: 10.h),
    width: double.infinity,
    decoration: BoxDecoration(
        // color: AppColor.primaryLight,
        gradient: AppDecoration.gradientIntroDecoration,
        borderRadius: BorderRadius.circular(15.r),
        shape: BoxShape.rectangle),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 180.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distinctive expert consultation service',
                style:
                    Styles.textStyle18.copyWith(color: AppColor.onPrimaryLight),
                maxLines: 2,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomElevatedButton(
                text: 'Learn More',
                width: 115.w,
                buttonTextStyle:
                    Styles.textStyle12.copyWith(color: theme.primary),
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: theme.background,
                  surfaceTintColor: theme.secondary,
                  foregroundColor: theme.secondary,
                ),
              ),
            ],
          ),
        ),
        CustomImageView(
          imagePath: Assets.images.expert1.path,
        ),
      ],
    ),
  );
}
