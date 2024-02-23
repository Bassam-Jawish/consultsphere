import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopExpertItem extends StatelessWidget {
  const HomeTopExpertItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey, width: 0.5)),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      width: 130.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: CustomImageView(
                  margin: EdgeInsets.only(top: 10.h),
                  imagePath: Assets.images.expert2.path,
                  height: 70.h,
                  width: 70.w,
                  radius: BorderRadius.circular(
                    35.r,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: Assets.icons.imgSignal.path,
                      height: 16.h,
                      width: 16.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        '4.7',
                        style: Styles.textStyle12.copyWith(color: Colors.orangeAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Bassam Jawish',
            style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3.h),
          Text(
            'Programming',
            style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w500,color: AppColor.gray500),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.location_on),
              Text(
                '800m away',
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w500,color: AppColor.gray500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
