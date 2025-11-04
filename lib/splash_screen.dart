import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instagram_project/ui/auth/login.dart';
import 'package:instagram_project/ui/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  @override
  initState() {
    init();
    delayedNaviate();
    // getLogginSession();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  bool getLogginSession() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  delayedNaviate() async {
    await Future.delayed(Duration(seconds: 2), () {});
    if (getLogginSession() == true) {
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200.h,
          width: 200.w,
          child: Image.asset('images/instagram-logo.png'),
        ),
      ),
    );
  }
}
