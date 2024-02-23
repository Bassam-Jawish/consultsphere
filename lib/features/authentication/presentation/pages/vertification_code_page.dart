import 'package:consultsphere/core/widgets/custom_appbar.dart';
import 'package:consultsphere/features/authentication/presentation/widgets/verification_code_body.dart';
import 'package:flutter/material.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context, '', true),
      body: VerificationCodeBody(email: email,),
    );
  }
}
