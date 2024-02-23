import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/utils/gen/assets.gen.dart';
import 'package:consultsphere/core/widgets/custom_image_view.dart';
import 'package:consultsphere/core/widgets/custom_toast.dart';
import 'package:consultsphere/features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerificationSendBody extends StatelessWidget {
  VerificationSendBody({Key? key, required this.email}) : super(key: key);

  String? email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SendVerifyEmailSuccess) {
          showToast(text: 'Verification Sent', state: state);
        }
        if (state is SendVerifyEmailError) {
          showToast(text: state.error!.message, state: state);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: Assets.icons.imgEmail.path,
              height: 44.h,
              width: 44.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Verify your email address",
              style: Styles.textStyle24,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "We have just send email verification link on your email. Please check email and click on that link to verify your Email address.",
              style: Styles.textStyle16.copyWith(color: AppColor.gray500),
              maxLines: 4,),
            SizedBox(
              height: 50.h,
            ),
            TextButton(
              onPressed: () {
                final RouteMatch lastMatch = AppRouter.router
                    .routerDelegate.currentConfiguration.last;
                final RouteMatchList matchList =
                lastMatch is ImperativeRouteMatch
                    ? lastMatch.matches
                    : AppRouter.router.routerDelegate
                    .currentConfiguration;
                final String location = matchList.uri.toString();
                print('location: $location');
                if (location == '${AppRouter.kLoginPage}/${AppRouter.kRegisterPage}/${AppRouter.kVerificationRegisterPage}') {
                  BlocProvider.of<AuthBloc>(context).add(
                      const SendEmailVerification());
                }
                else {
                  BlocProvider.of<AuthBloc>(context).add(ResetPassword(email!));
                }
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Text(
                'Resend',
                style: Styles.textStyle14.copyWith(
                  color: theme.primary,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.login,
                  color: theme.primary,
                  size: 15,
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRouter.kLoginPage);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Back to Login',
                    style: Styles.textStyle14.copyWith(
                      color: theme.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
