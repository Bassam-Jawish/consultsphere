import 'package:consultsphere/features/home/presentation/widgets/home_appbar.dart';
import 'package:consultsphere/features/home/presentation/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      backgroundColor: theme.background,
      appBar: homeAppBar(context),
      body: const HomeBody(),
    );
  }
}
