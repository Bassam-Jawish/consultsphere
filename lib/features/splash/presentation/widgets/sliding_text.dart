import 'package:flutter/material.dart';

import '../../../../config/theme/styles.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    Key? key,
    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child: Text(
              'ConsultSphere',
              style: Styles.textStyle30.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}
