import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_button.dart';
import 'package:consultsphere/core/widgets/custom_circular.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:consultsphere/core/widgets/default_textformfield.dart';
import 'package:consultsphere/features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordBody extends StatelessWidget {
  CreateNewPasswordBody({Key? key}) : super(key: key);

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(context),
            SizedBox(height: 24.h),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return CustomTextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  hintText: "Enter your password",
                  hintStyle: Styles.textStyle16,
                  textInputType: TextInputType.text,
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.w, 14.h, 14.w, 14.h),
                    child: CustomImageView(
                      imagePath: Assets.icons.imgPassword.path,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const ChangePassword());
                    },
                    iconSize: 26,
                    icon: state.isPasswordVis!
                        ? const Icon(
                            Icons.visibility_outlined,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                  ),
                  obscureText: !state.isPasswordVis!,
                  suffixConstraints: BoxConstraints(maxHeight: 56.h),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  contentPadding:
                      EdgeInsets.only(top: 8.h, right: 30.w, bottom: 8.h),
                );
              },
            ),
            SizedBox(height: 16.h),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return CustomTextFormField(
                  controller: _passwordConfirmController,
                  focusNode: _passwordConfirmFocusNode,
                  hintText: "Confirm your password",
                  hintStyle: Styles.textStyle16,
                  textInputType: TextInputType.text,
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.w, 14.h, 14.w, 14.h),
                    child: CustomImageView(
                      imagePath: Assets.icons.imgPassword.path,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const ChangePassword());
                    },
                    iconSize: 26,
                    icon: state.isPasswordVis!
                        ? const Icon(
                            Icons.visibility_outlined,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                  ),
                  obscureText: !state.isPasswordVis!,
                  suffixConstraints: BoxConstraints(maxHeight: 56.h),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (value != _passwordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  contentPadding:
                      EdgeInsets.only(top: 8.h, right: 30.w, bottom: 8.h),
                );
              },
            ),
            SizedBox(height: 24.h),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.isLoading!
                    ? Center(child: circularLoading())
                    : CustomButton(
                        text: 'Create Password',
                        image: '',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            GoRouter.of(context)
                                .pushReplacement(AppRouter.kLoginPage);
                          }
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Create New Password", style: Styles.textStyle24),
      SizedBox(height: 12.h),
      Text("Create your new password to login", style: Styles.textStyle16)
    ]);
  }
}
