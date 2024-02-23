import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:consultsphere/core/widgets/custom_outlined_bottom.dart';
import 'package:consultsphere/features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/styles.dart';

Widget forgotPasswordLogin(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          GoRouter.of(context)
              .push('${AppRouter.kLoginPage}/${AppRouter.kForgotPasswordPage}');
        },
        child: Text(
          'Forgot Password?',
          style: Styles.textStyle14.copyWith(
            color: theme.primary,
          ),
        ),
      ),
    ],
  );
}

Widget registerRowLogin(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't have an account?",
        style: Styles.textStyle14.copyWith(color: AppColor.gray500),
      ),
      TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          GoRouter.of(context)
              .push('${AppRouter.kLoginPage}/${AppRouter.kRegisterPage}');
        },
        child: Text(
          "Sign Up",
          style: Styles.textStyle14.copyWith(
            color: theme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget buildDivider(BuildContext context) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 9.h),
            child: SizedBox(
                width: 137.h,
                child: const Divider(
                  color: Colors.grey,
                ))),
        Text('OR',
            style: Styles.textStyle18
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w400)),
        Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 9.h),
            child: SizedBox(
                width: 137.h,
                child: const Divider(
                  color: Colors.grey,
                )))
      ]);
}

Widget buildSocial(BuildContext context) {
  return Column(children: [
    CustomOutlinedButton(
        buttonStyle: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AppColor.gray500,
            width: 0.6,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        text: "Sign in with Google",
        leftIcon: Container(
          margin: EdgeInsets.only(right: 30.w),
          child: CustomImageView(
              imagePath: Assets.icons.imgGoogle.path, height: 20.h, width: 19.w),
        ),
        onPressed: () {
          context.read<AuthBloc>().add(const SignInWithGoogle());
        }),
    SizedBox(height: 16.h),
    CustomOutlinedButton(
      alignment: Alignment.centerLeft,
      buttonStyle: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColor.gray500,
          width: 0.6,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      text: "Sign in with Apple",
      onPressed: () {
        context.read<AuthBloc>().add(const SignInWithApple());
      },
      leftIcon: Container(
        margin: EdgeInsets.only(right: 30.w),
        child: CustomImageView(
            imagePath: Assets.icons.imgApple.path, height: 20.h, width: 16.w),
      ),
    ),
    SizedBox(height: 16.h),
    CustomOutlinedButton(
      buttonStyle: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColor.gray500,
          width: 0.6,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      text: "Sign in with Facebook",
      onPressed: () {
        context.read<AuthBloc>().add(const SignInWithFacebook());
      },
      leftIcon: Container(
        margin: EdgeInsets.only(right: 30.w),
        child: CustomImageView(
            imagePath: Assets.icons.imgFacebook.path, height: 25.h, width: 25.w),
      ),
    ),
  ]);
}
