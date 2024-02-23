import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopExpertItem extends StatelessWidget {
  TopExpertItem(this.name, this.img, this.rate, this.skill,this.far,
      {Key? key})
      : super(key: key);

  String name;
  String img;
  String rate;
  String skill;
  String far;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColor.gray300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: img,
            height: 100.h,
            width: 100.w,
            radius: BorderRadius.circular(
              15.r,
            ),
          ),
          SizedBox(width: 10.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                skill,
                style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.gray500),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: Assets.icons.imgSignal.path,
                    height: 16.h,
                    width: 16.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      rate,
                      style: Styles.textStyle12
                          .copyWith(color: Colors.orangeAccent),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on),
                  Padding(
                    padding: EdgeInsets.only(left: 3.h),
                    child: Text(
                      far,
                      style: Styles.textStyle12.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.gray500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
