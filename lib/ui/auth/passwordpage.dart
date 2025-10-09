import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/auth/login.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 68.w, right: 68.w, top: 122.h),
              child: Image.asset('images/logo.png'),
            ),
            30.verticalSpace,
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.end,
                    'New Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  CustomTextField(
                    controller: passwordController,
                    email: 'Password',
                    onChange: (value) {
                      passwordController.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 8) {
                        return 'Password must be atleast 8 character long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  15.verticalSpace,
                  Text(
                    textAlign: TextAlign.start,
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  CustomTextField(
                    controller: confirmPasswordController,
                    email: 'Re Enter Password',
                    onChange: (value) {
                      confirmPasswordController.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pleases enter above password';
                      }
                      if (value != passwordController.text) {
                        return 'password do not match';
                      } else {
                        return null;
                      }
                    },
                  ),
                  30.verticalSpace,
                  CustomElevatedButton(
                    color: Colors.black,
                    text: 'Resest Password',
                    textcolor: Colors.white,
                    onPressed: () {
                      print(
                        "Password: ${passwordController.text} C.Password: ${confirmPasswordController.text}",
                      );
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        Get.to(() => LoginPage());
                      }
                    },
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
