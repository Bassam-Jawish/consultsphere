import 'package:consultsphere/core/widgets/custom_appbar.dart';
import 'package:consultsphere/features/authentication/presentation/widgets/verification_send_body.dart';
import 'package:flutter/material.dart';

class VerificationSendPage extends StatelessWidget {
  const VerificationSendPage({Key? key,required this.email}) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context, '', false),
      body: VerificationSendBody(email: email,),
    );
  }
}
