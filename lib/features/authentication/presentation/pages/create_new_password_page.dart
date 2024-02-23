import 'package:consultsphere/core/widgets/custom_appbar.dart';
import 'package:consultsphere/features/authentication/presentation/widgets/create_new_password_body.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context, '', true),
      body: CreateNewPasswordBody(),
    );
  }
}
