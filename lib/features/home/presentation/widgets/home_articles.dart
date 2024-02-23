import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/core/widgets/custom_text.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeArticles extends StatelessWidget {
  const HomeArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TextSeeAll(
          text: 'Latest articles',
          widget: seeAll(
              (){}
          ),
        ),
        const HomeArticleItem(),
      ],
    );
  }
}
