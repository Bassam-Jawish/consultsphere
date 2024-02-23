import 'package:consultsphere/core/widgets/custom_checkbox_button.dart';
import 'package:consultsphere/features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/styles.dart';

Widget buildAgreeCheckBox(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(right: 28.w),
      child: BlocSelector<AuthBloc, AuthState, bool?>(
          selector: (state) => state.agreeCheckBox,
          builder: (context, agreeCheckBox) {
            return CustomCheckboxButton(
                text: "I agree to ConsultSphere Terms of Service \nand Privacy Policy",
                isExpandedText: true,
                value: agreeCheckBox,
                onChange: (value) {
                  context
                      .read<AuthBloc>()
                      .add(const ChangeAgree());
                });
          }));
}