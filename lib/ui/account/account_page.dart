import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/auth/login.dart';
import 'package:instagram_project/ui/home/home.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomBottomBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/face.png'),
                  radius: 30.r,
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'butterfly_abc.pk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '@shehzaddev.20',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 221, 219, 219),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            40.verticalSpace,
            AccountInfoData(
              icon: Icons.account_circle_outlined,
              text: 'My Account',
            ),
            15.verticalSpace,
            AccountInfoData(
              icon: Icons.location_searching_rounded,
              text: 'My Address',
            ),
            15.verticalSpace,

            AccountInfoData(
              icon: Icons.credit_card_off_outlined,
              text: 'My Credit',
            ),
            15.verticalSpace,

            AccountInfoData(
              icon: Icons.chat_bubble_outline,
              text: 'Chat Support',
            ),
            30.verticalSpace,

            Divider(),
            30.verticalSpace,

            AccountInfoData(
              icon: Icons.privacy_tip_rounded,
              text: 'Privacy & Terms of Use',
            ),
            100.verticalSpace,
            CustomElevatedButton(
              text: 'Log Out',
              onPressed: () {
                Get.to(() => LoginPage());
              },
              color: Colors.white,
              textcolor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class AccountInfoData extends StatelessWidget {
  const AccountInfoData({required this.icon, required this.text, super.key});

  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 22.sp),
        10.horizontalSpace,
        Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.sp),
      ],
    );
  }
}
