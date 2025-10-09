import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/auth/login.dart';
import 'package:instagram_project/ui/home/home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

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
            8.verticalSpace,
            Text(
              maxLines: 2,
              textAlign: TextAlign.center,
              'Sign up to see videos and photos from your friend',
              style: TextStyle(color: Color(0xffAEA9A9), fontSize: 20.sp),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  20.verticalSpace,
                  CustomTextField(
                    email: 'Email',
                    icon: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    email: 'Full Name',
                    icon: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    email: 'Usernamel',
                    icon: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your username';
                      } else {
                        return null;
                      }
                    },
                  ),
                  8.verticalSpace,
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
                  20.verticalSpace,
                  CustomElevatedButton(
                    color: Colors.black,
                    text: 'Sign Up',
                    textcolor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        Get.to(() => HomePage());
                      }
                    },
                  ),
                  10.verticalSpace,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xffAEA9A9),
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'By Signing up you agree to our'),
                        TextSpan(
                          text: ' terms',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ','),
                        TextSpan(
                          text: ' Data policy',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' and'),
                        TextSpan(
                          text: ' Cookies poloicies',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.sp,
                        ),
                      ),
                      8.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginPage());
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16.sp,
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
          ],
        ),
      ),
    );
  }
}
