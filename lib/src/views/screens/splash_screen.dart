import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.goNamed(RouteNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor00,
        body: Center(
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors.transparent,
            ),
            child: Center(
              child: Text(
                'Plus App',
                style: TextStyle(color: AppColors.primaryColor01,fontFamily: 'f1',fontSize: 34.sp,fontWeight: FontWeight.w100),
              ),
            ),
          ),
        ));
  }
}
