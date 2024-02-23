import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          width: 15.w,
        ),
        padding: EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: homeCategories.length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: 65.w,
              decoration: BoxDecoration(
                  color: AppColor.gray100,
                  borderRadius: BorderRadius.circular(12.r)),
              child: CustomImageView(
                imagePath: homeCategories[index].$2,
                color: theme.primary,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              homeCategories[index].$1,
              style: Styles.textStyle12.copyWith(
                color: AppColor.gray500,
                fontWeight: FontWeight.w300,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

List homeCategories = [
  ('Career', Assets.icons.career.path),
  ('Medicine', Assets.icons.medicine.path),
  ('Family', Assets.icons.family.path),
  ('Psychology', Assets.icons.psychology.path),
  ('Management', Assets.icons.management.path),
  ('Programming', Assets.icons.programming.path),
  ('Others', Assets.icons.others.path),
];
