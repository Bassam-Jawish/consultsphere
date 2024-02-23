import 'package:consultsphere/config/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorLight,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context, 'Login', false),
      body: LoginBody(),
    );
  }
}
