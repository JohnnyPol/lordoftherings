// register_login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_elevated_button.dart';

class RegisterLoginPage extends StatelessWidget {
  const RegisterLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.startBGcolor,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 48.h,
          ),
          child: Column(
            children: [
              Spacer(
                flex: 21,
              ), // spacer flex: 21
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 60.h),
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: AppDecoration.calmbluedarker.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder40,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "CataList",
                      style: theme.textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 78,
              ),
              CustomElevatedButton(
                text: "Login",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                text: "Register",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
