import 'package:consultsphere/config/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../widgets/register_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorLight,
      appBar: customAppBar(context, 'Sign Up', true),
      body: RegisterBody(),
    );  }
}
