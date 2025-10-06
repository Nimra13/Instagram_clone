import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/auth/passwordpage.dart';
import 'package:instagram_project/ui/auth/signup.dart';
import 'package:instagram_project/ui/home/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 110.w, right: 110.w, top: 122.h),
            child: Image.asset('images/logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  65.verticalSpace,
                  CustomTextField(
                    email: 'Email',
                    icon: Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    email: 'Password',
                    
                    icon: Icon(Icons.lock_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 8) {
                        return 'Password must be atleast 8 character long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  10.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => PasswordPage());
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xff1877F2),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  CustomElevatedButton(
                    formKey: formKey,
                    text: 'Log In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        Get.to(() => HomePage());
                      }
                    },
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account?',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xffAEA9A9),
                        ),
                      ),
                      8.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUpPage());
                        },
                        child: Text(
                          'sign up',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff1877F2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final String text;
  final dynamic onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3.r)),
        fixedSize: Size(330.w, 55.h),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18.sp)),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.email,
    this.icon,
    required this.validator,
    this.onChange,
    this.controller,
    super.key,
  });

  final String email;
  final Icon? icon;
  final dynamic validator;
  final TextEditingController? controller;
  final dynamic onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: email,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChange,
    );
  }
}
