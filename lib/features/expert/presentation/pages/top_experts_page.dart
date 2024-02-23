import 'package:consultsphere/core/widgets/custom_appbar.dart';
import 'package:consultsphere/features/expert/presentation/widgets/top_experts_body.dart';
import 'package:flutter/material.dart';

class TopExpertsPage extends StatelessWidget {
  const TopExpertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      backgroundColor: theme.background,
      appBar: customAppBar(context, 'Top Experts', true),
      body: const TopExpertsBody(),
    );
  }
}
