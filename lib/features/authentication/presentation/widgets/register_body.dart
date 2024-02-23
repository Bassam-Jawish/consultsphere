import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:consultsphere/features/authentication/presentation/widgets/register_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_circular.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../core/widgets/default_textformfield.dart';
import '../bloc/auth/remote/auth_bloc.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  String phoneNumber = '+963';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthError) {
          showToast(text: state.error!.message, state: state);
        }
        if (state is AuthSuccess && state.isRegister!) {
          showToast(text: 'Verification Sent', state: state);
          GoRouter.of(context).push(
              '${AppRouter.kLoginPage}/${AppRouter.kRegisterPage}/${AppRouter.kVerificationRegisterPage}/${_emailController.text}');
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  hintText: "Enter your name",
                  hintStyle: Styles.textStyle16,
                  textInputType: TextInputType.emailAddress,
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.w, 14.h, 14.w, 14.h),
                    child: CustomImageView(
                      imagePath: Assets.icons.imgPerson.path,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(maxHeight: 56.h),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  contentPadding:
                      EdgeInsets.only(top: 8.h, right: 30.w, bottom: 8.h),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  hintText: "Enter your email",
                  hintStyle: Styles.textStyle16,
                  textInputType: TextInputType.emailAddress,
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(16.w, 14.h, 14.w, 14.h),
                    child: CustomImageView(
                      imagePath: Assets.icons.imgEmail.path,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(maxHeight: 56.h),
                  validator: (value) {
                    if (value!.isEmpty || !EmailValidator.validate(value)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  contentPadding:
                      EdgeInsets.only(top: 8.h, right: 30.w, bottom: 8.h),
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    return previous.isPasswordVis != current.isPasswordVis;
                  },
                  builder: (context, state) {
                    return CustomTextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      hintText: "Enter your password",
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(_passwordConfirmFocusNode);
                      },
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
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      controller: _passwordConfirmController,
                      focusNode: _passwordConfirmFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_phoneFocusNode);
                      },
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
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Phone Number',
                  style: Styles.textStyle14.copyWith(
                      color: AppColor.gray600, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10.h,
                ),
                defInternationalPhoneNumberInput(
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    labelText: 'Phone',
                    labelStyle:
                        Styles.textStyle14.copyWith(color: AppColor.gray500),
                    labelTextSearch: 'Search by country name or dial code',
                    labelStyleSearch:
                        Styles.textStyle14.copyWith(color: AppColor.gray500),
                    onInputChanged: (PhoneNumber number) {
                      phoneNumber = number.phoneNumber!;
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Gender',
                  style: Styles.textStyle14.copyWith(
                      color: AppColor.gray600, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Radio(
                          activeColor: AppColor.primaryLight,
                          value: 0,
                          groupValue: state.groupValue!,
                          onChanged: (value) {
                            context.read<AuthBloc>().add(ChangeGender(value!));
                          },
                        ),
                        const Text("Male"),
                        Radio(
                          activeColor: AppColor.primaryLight,
                          value: 1,
                          groupValue: state.groupValue!,
                          onChanged: (value) {
                            context.read<AuthBloc>().add(ChangeGender(value!));
                          },
                        ),
                        const Text("Female"),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                buildAgreeCheckBox(context),
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.isLoading!
                        ? Center(child: circularLoading())
                        : CustomButton(
                            text: 'Sign Up',
                            isClicked: state.agreeCheckBox,
                            image: '',
                            onPressed: () {
                              if (state.agreeCheckBox!) {
                                if (_formKey.currentState!.validate()) {
                                  String? gender;
                                  if (state.groupValue == 0) {
                                    gender = 'male';
                                  } else {
                                    gender = 'female';
                                  }
                                  context.read<AuthBloc>().add(
                                        Register(
                                          _nameController.text,
                                          gender,
                                          _emailController.text,
                                          phoneNumber,
                                          _passwordController.text,
                                          _passwordController.text,
                                        ),
                                      );
                                }
                              }
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
