import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_articles.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_cat.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_top_experts.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_widgets.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          searchHome(),
          const HomeCategories(),
          learnMore(context),
          const HomeTopExperts(),
          const HomeArticles(),
        ],
      ),
    );
  }
}
