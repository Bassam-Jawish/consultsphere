import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/core/widgets/custom_text.dart';
import 'package:consultsphere/features/base/presentation/widgets/push_bottom_bar.dart';
import 'package:consultsphere/features/expert/presentation/pages/top_experts_page.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_top_expert_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeTopExperts extends StatelessWidget {
  const HomeTopExperts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TextSeeAll(
          text: 'Top Experts',
          widget: seeAll(
              () {
                pushNewScreenWithNavBar(context, const TopExpertsPage(), 'top_experts');
              }
          ),
        ),
        SizedBox(
          height: 170.h,
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 15.w,
              ),
              padding: EdgeInsets.only(left: 20.w, right: 20.h),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => const HomeTopExpertItem()
          ),
        ),
      ],
    );
  }
}
