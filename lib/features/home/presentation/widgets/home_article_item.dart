import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeArticleItem extends StatelessWidget {
  const HomeArticleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.h,
        margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
        padding: EdgeInsets.all(5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColor.gray100)),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                  imagePath: Assets.images.article1.path,
                  height: 55.h,
                  width: 55.w,
                  radius: BorderRadius.circular(6.r)),
              Padding(
                  padding: EdgeInsets.only(left: 12.w, bottom: 5.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 180.h,
                            child: Text(
                                "The 25 Healthiest Fruits You Can Eat, According to a Nutritionist",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.textStyle14.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600))),
                        SizedBox(height: 8.h),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jun 10, 2021",
                                  style: Styles.textStyle12
                                      .copyWith(color: AppColor.gray500)),
                              Container(
                                  height: 2.h,
                                  width: 2.w,
                                  margin: EdgeInsets.only(
                                      left: 5.w, top: 3.h, bottom: 4.h),
                                  decoration: BoxDecoration(
                                      color: AppColor.gray500,
                                      borderRadius:
                                          BorderRadius.circular(1.r))),
                              Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text("5min read",
                                      style: Styles.textStyle12
                                          .copyWith(color: AppColor.gray500))),
                            ])
                      ]))
            ]));
  }
}
