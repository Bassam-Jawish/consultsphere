import 'package:consultsphere/config/routes/app_router.dart';
import 'package:consultsphere/config/theme/app_decoration.dart';
import 'package:consultsphere/config/theme/colors.dart';
import 'package:consultsphere/config/theme/styles.dart';
import 'package:consultsphere/core/widgets/custom_button.dart';
import 'package:consultsphere/core/widgets/custom_circular.dart';
import 'package:consultsphere/features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeBody extends StatelessWidget {
  VerificationCodeBody({Key? key, required this.email}) : super(key: key);

  final TextEditingController _pinCode = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(children: [
            _buildTitle(context, email),
            SizedBox(height: 40.h),

            // pin code

            Pinput(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              length: 4,
              validator: (value) {
                return null;
              },
              showCursor: true,
              autofocus: true,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              controller: _pinCode,
              defaultPinTheme: AppDecoration.defaultPinTheme,
              focusedPinTheme: AppDecoration.focusedPinTheme,
              submittedPinTheme: AppDecoration.submittedPinTheme,
            ),

            SizedBox(height: 40.h),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.isLoading!
                    ? Center(child: circularLoading())
                    : CustomButton(
                        text: 'Send OTP',
                        image: '',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final RouteMatch lastMatch = AppRouter.router
                                .routerDelegate.currentConfiguration.last;
                            final RouteMatchList matchList =
                                lastMatch is ImperativeRouteMatch
                                    ? lastMatch.matches
                                    : AppRouter.router.routerDelegate
                                        .currentConfiguration;
                            final String location = matchList.uri.toString();
                            print('location: $location');
                            if (location ==
                                '${AppRouter.kLoginPage}/${AppRouter.kForgotPasswordPage}/${AppRouter.kVerificationForgotPage}/$email') {
                              GoRouter.of(context).push(
                                  '${AppRouter.kLoginPage}/${AppRouter.kForgotPasswordPage}/${AppRouter.kVerificationForgotPage}/$email/${AppRouter.kCreatePasswordPage}');
                            } else {}
                          }
                        },
                      );
              },
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't receive the code? ", style: Styles.textStyle16),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: TextButton(
                    onPressed: () {},
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
                ),
              ],
            ),
            SizedBox(height: 5.h)
          ]),
        ));
  }

  Widget _buildTitle(BuildContext context, String email) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Enter Verification", style: Styles.textStyle24),
          SizedBox(height: 10.h),
          Container(
              width: 273.h,
              margin: EdgeInsets.only(right: 54.w),
              child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Enter code that we have sent to your email ",
                        style: Styles.textStyle16
                            .copyWith(color: AppColor.gray500)),
                    TextSpan(
                      text: email,
                      style: Styles.textStyle16.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  textAlign: TextAlign.left))
        ]));
  }
}
