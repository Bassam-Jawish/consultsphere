import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_appbar.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget homeAppBar(BuildContext context) {
  return AppBar(
    leadingWidth: 360.w,
    leading: HomeAppbarSubtitle(
        text: "Find your desire \nexpert for consultation",
        margin: EdgeInsets.only(left: 24.w,top: 30.h)),
    toolbarHeight: 92.h,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    actions: [
      HomeAppbarTrailingImage(
          imagePath: Assets.icons.imgNotification.path,
          margin: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 36.h))
    ],
  );
}

class HomeAppbarSubtitle extends StatelessWidget {
  HomeAppbarSubtitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: SizedBox(
          width: 360.w,
          child: Text(
            text,
            maxLines: 2,
            style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class HomeAppbarTrailingImage extends StatelessWidget {
  HomeAppbarTrailingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath,
          height: 24.h,
          width: 24.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
