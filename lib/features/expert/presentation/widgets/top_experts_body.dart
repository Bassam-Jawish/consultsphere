import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/features/expert/presentation/widgets/top_expert_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopExpertsBody extends StatelessWidget {
  const TopExpertsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 15.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) => TopExpertItem('Bassam Jawish',
          Assets.images.user3.path, '4.7', 'Programming', '800m away'),
    );
  }
}
