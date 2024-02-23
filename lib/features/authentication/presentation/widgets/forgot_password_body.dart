import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/core/widgets/custom_toast.dart';
import 'package:consultsphere/features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';
import 'package:consultsphere/features/authentication/presentation/widgets/forgot_passwrod_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordBody extends StatelessWidget {
  ForgotPasswordBody({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordError) {
          showToast(text: state.error!.message, state: state);

        }
        if (state is ResetPasswordSuccess) {
          showToast(text: 'Verification Sent', state: state);
          GoRouter.of(context).push(
              '${AppRouter.kLoginPage}/${AppRouter.kRegisterPage}/${AppRouter.kVerificationRegisterPage}/${_emailController.text}');
        }
      },
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            color: AppColor.backgroundColorLight,
            child: Column(
              children: [
                buildTitlePass(context),
                SizedBox(height: 24.h),
                buildEmailSection(
                    context, _emailController, _emailFocusNode, _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
